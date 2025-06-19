import 'dart:math';
import 'package:fitspace_sports_venue_booking_mobile/models/field_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/filter_drawer_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/all_nearby_court_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/all_recommend_court_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/notification_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/venue_detail_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/user_service.dart';
import 'package:fitspace_sports_venue_booking_mobile/widgets/filter_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:intl/intl.dart';
import '../models/user_model.dart';
import '../models/venue_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/venue_service.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key, required this.user});

  final User user;

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final _userService = UserService();
  String? selectedLocation;
  String? selectedField;
  TextEditingController searchController = TextEditingController();
  List<String> selectedSports = [];
  Position? _currentPosition;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool showAllNearby = false;
  bool showAllRecommended = false;

  final VenueService _venueService = VenueService();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _getCurrentLocation();
    await _loadVenues();
    _sortNearbyVenues();
    _loadRecommendedVenues();
  }

  List<Venue> _venues = [];
  List<Venue> _nearbyVenues = [];
  List<Venue> _recommendedVenues = [];

  List<String> fieldTypes = ['Futsal', 'Basketball', 'Badminton', 'Volleyball'];

  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.whitePurple,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Location',
                          style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 30, color: AppColors.darkerPrimaryColor),
                          DropdownButton<String>(
                            value: selectedLocation,
                            hint: const Text('Select Location'),
                            onChanged: (newValue) {
                              setState(() {
                                selectedLocation = newValue;
                                _filterVenuesByLocation();
                              });
                            },
                            items: [
                              'Kota Bandung',
                              'Kabupaten Bandung',
                              'Kabupaten Bandung Barat'
                            ]
                                .map<DropdownMenuItem<String>>((location) =>
                                    DropdownMenuItem<String>(
                                        value: location, child: Text(location)))
                                .toList(),
                            underline: const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.grey.withOpacity(0.5),
                    child: IconButton(
                      icon: const Icon(Icons.notifications,
                          size: 25, color: Colors.black),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationScreen())),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (query) => _filterVenuesBySearch(query),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        filled: true,
                        fillColor: AppColors.grey.withOpacity(0.3),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        prefixIcon: const Icon(Icons.search,
                            size: 24, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.darkerPrimaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      icon:
                          const Icon(Icons.tune, size: 30, color: Colors.white),
                      onPressed: () =>
                          _scaffoldKey.currentState!.openEndDrawer(),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: fieldTypes.map((fieldType) {
                    return _buildButton(fieldType);
                  }).toList(),
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: ListView(
                  children: [
                    _buildNearbySection(),
                    const SizedBox(height: 10),
                    _buildRecommendedSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: FilterDrawer(onFilterApplied: (FilterOptions filterOptions) {
        setState(() {
          final tempFilteredVenues = _venues.where((venue) {
            bool matchesPrice = true;
            if (filterOptions.minPrice != null ||
                filterOptions.maxPrice != null) {
              matchesPrice = venue.fields!.any((field) {
                bool priceMatches = true;
                if (filterOptions.minPrice != null) {
                  priceMatches = field.price! >= filterOptions.minPrice!;
                }
                if (filterOptions.maxPrice != null) {
                  priceMatches =
                      priceMatches && field.price! <= filterOptions.maxPrice!;
                }
                return priceMatches;
              });
            }

            bool matchesRating = true;
            if (filterOptions.ratingSort != null) {
              matchesRating = true;
            }

            bool matchesName = true;
            if (filterOptions.nameSort != null) {
              matchesName = true;
            }

            return matchesPrice;
          }).toList();

          if (filterOptions.ratingSort == 'Ascending') {
            tempFilteredVenues.sort((a, b) => a.rating!.compareTo(b.rating!));
          } else if (filterOptions.ratingSort == 'Descending') {
            tempFilteredVenues.sort((a, b) => b.rating!.compareTo(a.rating!));
          }

          if (filterOptions.nameSort == 'Ascending') {
            tempFilteredVenues.sort((a, b) => a.name!.compareTo(b.name!));
          } else if (filterOptions.nameSort == 'Descending') {
            tempFilteredVenues.sort((a, b) => b.name!.compareTo(a.name!));
          }

          _nearbyVenues = tempFilteredVenues;
          _recommendedVenues = tempFilteredVenues.take(5).toList();
        });
      }, onReset: (){
        setState(() {
          selectedField = null;
          selectedLocation = null;
          selectedSports = [];
          searchController.clear();
        });
        _sortNearbyVenues();
        _loadRecommendedVenues();
      },),
    );
  }

  Widget _buildNearbySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Nearby Court',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AllNearbyCourtScreen(user: widget.user, venues: _nearbyVenues),
                ));
              },
              child: const Text('See All',
                  style: TextStyle(
                      fontSize: 16, color: AppColors.darkerPrimaryColor)),
            ),
          ],
        ),
        _isLoading && _currentPosition == null
            ? const Center(child: CircularProgressIndicator())
            : _nearbyVenues.isEmpty
                ? const SizedBox(
                    height: 230,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.sentiment_dissatisfied,
                              size: 40, color: AppColors.darkGrey),
                          SizedBox(height: 10),
                          Text(
                            'No nearby venues found',
                            style: TextStyle(
                                fontSize: 16, color: AppColors.darkGrey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: (showAllNearby
                              ? _nearbyVenues
                              : _nearbyVenues.take(3))
                          .map((venue) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: _venueCard(venue, isHorizontal: true),
                              ))
                          .toList(),
                    ),
                  ),
      ],
    );
  }

  void _applyFilters() {
    List<Venue> tempFilteredVenues = List.from(_venues);
    if (selectedSports.isNotEmpty) {
      tempFilteredVenues = tempFilteredVenues.where((venue) {
        return venue.fields!
            .any((field) => selectedSports.contains(field.type!));
      }).toList();
    }

    if (selectedLocation != null && selectedLocation!.isNotEmpty) {
      tempFilteredVenues = tempFilteredVenues.where((venue) {
        return venue.cityOrRegency == selectedLocation;
      }).toList();
    }

    if (searchController.text.isNotEmpty) {
      final query = searchController.text.toLowerCase();
      tempFilteredVenues = tempFilteredVenues.where((venue) {
        return venue.name!.toLowerCase().contains(query) ||
            venue.district!.toLowerCase().contains(query) ||
            venue.cityOrRegency!.toLowerCase().contains(query);
      }).toList();
    }

    setState(() {
      _nearbyVenues = tempFilteredVenues;
      _recommendedVenues =
          tempFilteredVenues.take(5).toList(); // Take top 5 for recommended
    });
  }

  void _filterVenuesByLocation() {
    _applyFilters();
  }

  void _filterVenuesBySearch(String query) {
    _applyFilters();
  }

  Widget _buildRecommendedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Recommended for You',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AllRecommendCourtScreen(
                    user: widget.user, venues: _recommendedVenues
                  ),
                ));
              },
              child: const Text('See All',
                  style: TextStyle(
                      fontSize: 16, color: AppColors.darkerPrimaryColor)),
            ),
          ],
        ),
        _isLoading
            ? Center(child: const CircularProgressIndicator())
            : _recommendedVenues.isEmpty
                ? const SizedBox(
                    height: 230,
                    width: double.infinity,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.sentiment_dissatisfied,
                              size: 40, color: AppColors.darkGrey),
                          SizedBox(height: 10),
                          Text(
                            'No recommended venue available',
                            style: TextStyle(
                                fontSize: 16, color: AppColors.darkGrey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : Column(
                    children: (showAllRecommended
                            ? _recommendedVenues
                            : _recommendedVenues.take(2))
                        .map((venue) => Column(
                              children: [
                                _venueCard(venue),
                                const SizedBox(height: 10),
                              ],
                            ))
                        .toList(),
                  ),
      ],
    );
  }

  Widget _venueCard(Venue venue, {bool isHorizontal = false}) {
    print('${venue.name!}: ${venue.latitude!} ${venue.longitude!}');

    double? distance = _currentPosition != null
        ? _calculateDistance(_currentPosition!.latitude,
            _currentPosition!.longitude, venue.latitude!, venue.longitude!)
        : null;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VenueDetailScreen(user: widget.user, venue: venue),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: isHorizontal ? 230 : double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.whitePurple,
              borderRadius: BorderRadius.circular(10)),
          child: isHorizontal
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          venue.fields![0].gallery!.isEmpty
                              ? 'https://staticg.sportskeeda.com/editor/2022/11/a9ef8-16681658086025-1920.jpg'
                              : 'http://${dotenv.env["HOST"]}:${dotenv.env["PORT"]}${venue.fields![0].gallery![0].photoUrl != null ? venue.fields![0].gallery![0].photoUrl! : ''}',
                          width: double.infinity,
                          height: 100,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            }
                          },
                        )),
                    const SizedBox(height: 5),
                    ..._venueCardContent(venue, distance),
                  ],
                )
              : Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'http://${dotenv.env["HOST"]}:${dotenv.env["PORT"]}${venue.fields![0].gallery![0].photoUrl != null ? venue.fields![0].gallery![0].photoUrl! : ''}',
                          width: 120,
                          height: 130,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            }
                          },
                        )),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _venueCardContent(venue, distance),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  List<Widget> _venueCardContent(Venue venue, double? distance) {
    return [
      SizedBox(
        height: 25,
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          alignment: WrapAlignment.start,
          children: venue.fields!.isNotEmpty
              ? venue.fields!.map((tag) {
                  return fieldTag(tag.type!);
                }).toList()
              : [const SizedBox(height: 25)],
        ),
      ),
      const SizedBox(height: 5),
      Text(venue.name!,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 5),
      Row(
        children: [
          const Icon(Icons.location_on, size: 20, color: AppColors.darkGrey),
          Text(venue.cityOrRegency!,
              style: const TextStyle(fontSize: 14, color: AppColors.darkGrey)),
        ],
      ),
      const SizedBox(height: 5),
      Row(
        children: [
          Text(
              distance != null
                  ? "${distance.toStringAsFixed(2)} km"
                  : "Loading...",
              style: const TextStyle(fontSize: 14, color: AppColors.darkGrey)),
          const SizedBox(width: 5),
          const Text('|', style: TextStyle(color: AppColors.darkGrey)),
          const SizedBox(width: 5),
          const Text('Start From: ',
              style: TextStyle(fontSize: 12, color: AppColors.darkGrey)),
          Text(
              'Rp${NumberFormat('#,###', 'id_ID').format(venue.fields != null && venue.fields!.isNotEmpty ? venue.fields!.map((e) => e.price).reduce((a, b) => min(a!, b!))!.toDouble() : 0)}',
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkerPrimaryColor)),
        ],
      ),
    ];
  }

  Widget fieldTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
          color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
      child:
          Text(text, style: TextStyle(color: Colors.blue[800], fontSize: 12)),
    );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      print('lokk: $_currentPosition');
    });
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    double distanceInMeters =
        Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    return distanceInMeters / 1000;
  }

  Future<void> _loadVenues() async {
    final result = await _venueService.loadVenues(widget.user);
    print('res : $result');

    if (!mounted) return;

    if (result['success'] == 'true') {
      List<dynamic> data = result['data'];
      setState(() {
        final tempVenues = List<Venue>.from(data.map((e) => Venue.fromJson(e)));
        _venues = tempVenues
            .where((venue) =>
                venue.fields!.isNotEmpty && venue.owner!.id! != widget.user.id)
            .toList();
        if (_currentPosition != null) {
          _nearbyVenues = List.from(_venues);
          _nearbyVenues.sort((a, b) {
            final distanceA = _calculateDistance(a.latitude!, a.longitude!,
                _currentPosition!.latitude, _currentPosition!.longitude);

            final distanceB = _calculateDistance(b.latitude!, b.longitude!,
                _currentPosition!.latitude, _currentPosition!.longitude);

            return distanceA.compareTo(distanceB);
          });
        } else {
          _nearbyVenues = _venues;
        }
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
      final errorMessage = result['error'] is String
          ? result['error']
          : (result['error'] as List).join('\n');

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  Widget _buildButton(String text) {
    bool isSelected = selectedSports.contains(text);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedSports.remove(text);
          } else {
            selectedSports.clear();
            selectedSports.add(text);
          }
          selectedField =
              selectedSports.isNotEmpty ? selectedSports.first : null;
          _applyFilters(); // Apply all filters
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.darkerPrimaryColor : Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(color: isSelected ? Colors.white : Colors.blue[800]),
        ),
      ),
    );
  }

  void _sortNearbyVenues() {
    if (_currentPosition != null && _venues.isNotEmpty) {
      _nearbyVenues = List.from(_venues.where((venue) =>
          venue.latitude != null &&
          venue.longitude != null));

      _nearbyVenues.sort((a, b) {
        final distanceA = _calculateDistance(a.latitude!, a.longitude!,
            _currentPosition!.latitude, _currentPosition!.longitude);

        final distanceB = _calculateDistance(b.latitude!, b.longitude!,
            _currentPosition!.latitude, _currentPosition!.longitude);

        return distanceA.compareTo(distanceB);
      });
    } else {
      _nearbyVenues = List.from(_venues);
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _loadRecommendedVenues() async {
    final result = await _venueService.loadVenuesAi(widget.user, _currentPosition!);

    if (result['success'] == 'true') {
        setState(() {
          _recommendedVenues = _venues.where((venue) {
            return result['data'].any((data) => data['venue_id'] == venue.id);
          }).toList();

          _isLoading = false;
        });
    } else {
      setState(() => _isLoading = false);
      final errorMessage = result['error'] is String
          ? result['error']
          : (result['error'] as List).join('\n');

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}
