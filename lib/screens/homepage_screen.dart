import 'dart:math';
import 'package:fitspace_sports_venue_booking_mobile/screens/notification_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/venue_detail_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/widgets/filter_drawer.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
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
  String? selectedLocation;
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
    _getCurrentLocation();
    _loadVenues();
  }

  List<Venue> venues = [
    Venue(
      id: 1,
      name: 'Venue One',
      phoneNumber: '123-456-7890',
      street: '123 Main St',
      district: 'Central District',
      cityOrRegency: 'City A',
      province: 'Province A',
      postalCode: '12345',
      latitude: 40.7128,
      longitude: -74.0060,
      rating: 4.5,
      fields: [
        {'type': 'Concert Hall', 'capacity': 500},
        {'type': 'Conference Room', 'capacity': 200},
      ],
      owner: {'name': 'Owner One', 'contact': 'owner1@example.com'},
    ),
    Venue(
      id: 2,
      name: 'Venue Two',
      phoneNumber: '987-654-3210',
      street: '456 Park Ave',
      district: 'East District',
      cityOrRegency: 'City B',
      province: 'Province B',
      postalCode: '67890',
      latitude: 34.0522,
      longitude: -118.2437,
      rating: 4.2,
      fields: [
        {'type': 'Gallery', 'capacity': 100, 'price': 100000},
        {'type': 'Outdoor Stage', 'capacity': 1000, 'price': 100000},
      ],
      owner: {'name': 'Owner Two', 'contact': 'owner2@example.com'},
    ),
    Venue(
      id: 3,
      name: 'Venue Three',
      phoneNumber: '555-123-4567',
      street: '789 Sunset Blvd',
      district: 'West District',
      cityOrRegency: 'City C',
      province: 'Province C',
      postalCode: '23456',
      latitude: 51.5074,
      longitude: -0.1278,
      rating: 4.8,
      fields: [
        {'type': 'Theater', 'capacity': 300, 'price': 100000},
      ],
      owner: {'name': 'Owner Three', 'contact': 'owner3@example.com'},
    ),
    Venue(
      id: 4,
      name: 'Venue Four',
      phoneNumber: '222-333-4444',
      street: '321 Ocean Ave',
      district: 'South District',
      cityOrRegency: 'City D',
      province: 'Province D',
      postalCode: '34567',
      latitude: 48.8566,
      longitude: 2.3522,
      rating: 4.3,
      fields: [
        {'type': 'Event Space', 'capacity': 800, 'price': 100000},
      ],
      owner: {'name': 'Owner Four', 'contact': 'owner4@example.com'},
    ),
    Venue(
      id: 5,
      name: 'Venue Five',
      phoneNumber: '666-777-8888',
      street: '654 River Rd',
      district: 'North District',
      cityOrRegency: 'City E',
      province: 'Province E',
      postalCode: '45678',
      latitude: 35.6895,
      longitude: 139.6917,
      rating: 4.6,
      fields: [
        {'type': 'Conference Center', 'capacity': 150, 'price': 100000},
      ],
      owner: {'name': 'Owner Five', 'contact': 'owner5@example.com'},
    ),
  ];
  List<Venue> nearbyVenues = [
    Venue(
    id: 1,
    name: 'Venue One',
    phoneNumber: '123-456-7890',
    street: '123 Main St',
    district: 'Central District',
    cityOrRegency: 'City A',
    province: 'Province A',
    postalCode: '12345',
    latitude: 40.7128,
    longitude: -74.0060,
    rating: 4.5,
    fields: [
      {'type': 'Concert Hall', 'capacity': 500, 'price': 100000},
      {'type': 'Conference Room', 'capacity': 200, 'price': 100000},
    ],
    owner: {'name': 'Owner One', 'contact': 'owner1@example.com'},
  ),
    Venue(
      id: 2,
      name: 'Venue Two',
      phoneNumber: '987-654-3210',
      street: '456 Park Ave',
      district: 'East District',
      cityOrRegency: 'City B',
      province: 'Province B',
      postalCode: '67890',
      latitude: 34.0522,
      longitude: -118.2437,
      rating: 4.2,
      fields: [
        {'type': 'Gallery', 'capacity': 100, 'price': 100000},
        {'type': 'Outdoor Stage', 'capacity': 1000, 'price': 100000},
      ],
      owner: {'name': 'Owner Two', 'contact': 'owner2@example.com'},
    ),
    Venue(
      id: 3,
      name: 'Venue Three',
      phoneNumber: '555-123-4567',
      street: '789 Sunset Blvd',
      district: 'West District',
      cityOrRegency: 'City C',
      province: 'Province C',
      postalCode: '23456',
      latitude: 51.5074,
      longitude: -0.1278,
      rating: 4.8,
      fields: [
        {'type': 'Theater', 'capacity': 300, 'price': 100000},
      ],
      owner: {'name': 'Owner Three', 'contact': 'owner3@example.com'},
    ),
    Venue(
      id: 4,
      name: 'Venue Four',
      phoneNumber: '222-333-4444',
      street: '321 Ocean Ave',
      district: 'South District',
      cityOrRegency: 'City D',
      province: 'Province D',
      postalCode: '34567',
      latitude: 48.8566,
      longitude: 2.3522,
      rating: 4.3,
      fields: [
        {'type': 'Event Space', 'capacity': 800, 'price': 100000},
      ],
      owner: {'name': 'Owner Four', 'contact': 'owner4@example.com'},
    ),
    Venue(
      id: 5,
      name: 'Venue Five',
      phoneNumber: '666-777-8888',
      street: '654 River Rd',
      district: 'North District',
      cityOrRegency: 'City E',
      province: 'Province E',
      postalCode: '45678',
      latitude: 35.6895,
      longitude: 139.6917,
      rating: 4.6,
      fields: [
        {'type': 'Conference Center', 'capacity': 150, 'price': 100000},
      ],
      owner: {'name': 'Owner Five', 'contact': 'owner5@example.com'},
    ),
  ];
  List<Venue> recommendedVenues = [
    Venue(
    id: 1,
    name: 'Venue One',
    phoneNumber: '123-456-7890',
    street: '123 Main St',
    district: 'Central District',
    cityOrRegency: 'City A',
    province: 'Province A',
    postalCode: '12345',
    latitude: 40.7128,
    longitude: -74.0060,
    rating: 4.5,
    fields: [
      {'type': 'Concert Hall', 'capacity': 500, 'price': 100000},
      {'type': 'Conference Room', 'capacity': 200, 'price': 100000},
    ],
    owner: {'name': 'Owner One', 'contact': 'owner1@example.com'},
  ),
    Venue(
      id: 2,
      name: 'Venue Two',
      phoneNumber: '987-654-3210',
      street: '456 Park Ave',
      district: 'East District',
      cityOrRegency: 'City B',
      province: 'Province B',
      postalCode: '67890',
      latitude: 34.0522,
      longitude: -118.2437,
      rating: 4.2,
      fields: [
        {'type': 'Gallery', 'capacity': 100, 'price': 100000},
        {'type': 'Outdoor Stage', 'capacity': 1000, 'price': 100000},
      ],
      owner: {'name': 'Owner Two', 'contact': 'owner2@example.com'},
    ),
    Venue(
      id: 3,
      name: 'Venue Three',
      phoneNumber: '555-123-4567',
      street: '789 Sunset Blvd',
      district: 'West District',
      cityOrRegency: 'City C',
      province: 'Province C',
      postalCode: '23456',
      latitude: 51.5074,
      longitude: -0.1278,
      rating: 4.8,
      fields: [
        {'type': 'Theater', 'capacity': 300, 'price': 100000},
      ],
      owner: {'name': 'Owner Three', 'contact': 'owner3@example.com'},
    ),
    Venue(
      id: 4,
      name: 'Venue Four',
      phoneNumber: '222-333-4444',
      street: '321 Ocean Ave',
      district: 'South District',
      cityOrRegency: 'City D',
      province: 'Province D',
      postalCode: '34567',
      latitude: 48.8566,
      longitude: 2.3522,
      rating: 4.3,
      fields: [
        {'type': 'Event Space', 'capacity': 800, 'price': 100000},
      ],
      owner: {'name': 'Owner Four', 'contact': 'owner4@example.com'},
    ),
    Venue(
      id: 5,
      name: 'Venue Five',
      phoneNumber: '666-777-8888',
      street: '654 River Rd',
      district: 'North District',
      cityOrRegency: 'City E',
      province: 'Province E',
      postalCode: '45678',
      latitude: 35.6895,
      longitude: 139.6917,
      rating: 4.6,
      fields: [
        {'type': 'Conference Center', 'capacity': 150, 'price': 100000},
      ],
      owner: {'name': 'Owner Five', 'contact': 'owner5@example.com'},
    ),
  ];
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
                      const Text('Location', style: TextStyle(color: AppColors.grey, fontSize: 16, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 30, color: AppColors.darkerPrimaryColor),
                          DropdownButton<String>(
                            value: selectedLocation,
                            hint: const Text('Select Location'),
                            onChanged: (newValue) {
                              setState(() {
                                selectedLocation = newValue;
                              });
                            },
                            items: ['Kota Bandung', 'Kabupaten Bandung', 'Bandung Barat']
                                .map<DropdownMenuItem<String>>((location) => DropdownMenuItem<String>(value: location, child: Text(location)))
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
                      icon: const Icon(Icons.notifications, size: 25, color: Colors.black),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen())),
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
                      decoration: InputDecoration(
                        hintText: 'Search',
                        filled: true,
                        fillColor: AppColors.grey.withOpacity(0.3),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                        prefixIcon: const Icon(Icons.search, size: 24, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(color: AppColors.darkerPrimaryColor, borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      icon: const Icon(Icons.tune, size: 30, color: Colors.white),
                      onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildButton('Futsal'),
                    const SizedBox(width: 10),
                    _buildButton('Basketball'),
                    const SizedBox(width: 10),
                    _buildButton('Badminton'),
                    const SizedBox(width: 10),
                    _buildButton('Volleyball'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
                    _buildNearbySection(),
                    const SizedBox(height: 20),
                    _buildRecommendedSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: FilterDrawer(onFilterApplied: (FilterOptions ) {  },),
    );
  }

  Widget _buildNearbySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Nearby Court', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black)),
            TextButton(
              onPressed: () => setState(() => showAllNearby = !showAllNearby),
              child: Text(showAllNearby ? 'See Less' : 'See All', style: const TextStyle(fontSize: 16, color: AppColors.darkerPrimaryColor)),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: (showAllNearby ? nearbyVenues : nearbyVenues.take(10)).map((venue) => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: _venueCard(venue, isHorizontal: true),
            )).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Recommended for You', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black)),
            TextButton(
              onPressed: () => setState(() => showAllRecommended = !showAllRecommended),
              child: Text(showAllRecommended ? 'See Less' : 'See All', style: const TextStyle(fontSize: 16, color: AppColors.darkerPrimaryColor)),
            ),
          ],
        ),
        Column(
          children: (showAllRecommended ? recommendedVenues : recommendedVenues.take(10)).map((venue) => Column(
            children: [
              _venueCard(venue),
              const SizedBox(height: 10),
            ],
          )).toList(),
        ),
      ],
    );
  }

  Widget _venueCard(Venue venue, {bool isHorizontal = false}) {
    double? distance = _currentPosition != null
        ? _calculateDistance(_currentPosition!.latitude, _currentPosition!.longitude, venue.latitude, venue.longitude)
        : null;

    return GestureDetector(
      onTap: () {
        // Navigate to Venue Detail screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VenueDetailScreen(user: widget.user, venue: venue),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: isHorizontal ? 230 : double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: AppColors.whitePurple, borderRadius: BorderRadius.circular(10)),
          child: isHorizontal
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/dummy/venue_dummy.png',
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 5),
              ..._venueCardContent(venue, distance),
            ],
          )
              : Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/dummy/venue_dummy.png',
                  width: 120,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
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
          children: venue.fields.isNotEmpty
              ? venue.fields.map((tag) {
            return fieldTag(tag['type']);  // Access 'type' from the map
          }).toList()
              : [SizedBox(height: 25)],
        ),
      ),
      const SizedBox(height: 5),
      Text(venue.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 5),
      Row(
        children: [
          const Icon(Icons.location_on, size: 20, color: AppColors.darkGrey),
          Text(venue.cityOrRegency, style: const TextStyle(fontSize: 14, color: AppColors.darkGrey)),
          const SizedBox(width: 5),
          const Text('|', style: TextStyle(color: AppColors.darkGrey)),
          const SizedBox(width: 5),
          Text(distance != null ? "${distance.toStringAsFixed(2)} km" : "Loading...", style: const TextStyle(fontSize: 14, color: AppColors.darkGrey)),
        ],
      ),
      const SizedBox(height: 5),
      Row(
        children: [
          const Text('Start From: ', style: TextStyle(fontSize: 12, color: AppColors.darkGrey)),
          Text(venue.fields.isNotEmpty ? 'IDR ${venue.fields[0]['price']}' : 'IDR N/A',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.darkerPrimaryColor)),
        ],
      ),
    ];
  }

  Widget fieldTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: TextStyle(color: Colors.blue[800], fontSize: 12)),
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

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() => _currentPosition = position);
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    double distanceInMeters = Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    return distanceInMeters / 1000;
  }

  Future<void> _loadVenues() async {
    final result = await _venueService.loadVenue(widget.user);
    print('res : $result');

    if (!mounted) return;

    if (result['success'] == 'true') {
      List<dynamic> data = result['data'];
      setState(() {
        venues = data.map((item) => Venue.fromJson(item)).toList();
        nearbyVenues = venues;
        recommendedVenues = venues.take(3).toList();
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['error'].toString())));
    }
  }

  Widget _buildButton(String text) {
    bool isSelected = selectedSports.contains(text);
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected ? selectedSports.remove(text) : selectedSports.add(text);
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
}