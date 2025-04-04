import 'package:fitspace_sports_venue_booking_mobile/screens/notification_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/widgets/filter_drawer.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';

import '../models/user_model.dart';
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

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  List<Court> nearbyCourts = [
    Court(
      name: 'Progresif Sports',
      location: 'Kab. Bandung',
      price: 'IDR 50K',
      rating: 4.5,
      image: 'assets/images/dummy/venue_dummy.png',
      latitude: -6.9000,
      longitude: 107.6000,
      tags: ['Futsal', 'Basketball', 'Volleyball', 'Badminton'],
    ),
    Court(
      name: 'Sport Center Tech',
      location: 'Kab. Bandung',
      price: 'IDR 30K',
      rating: 4.0,
      image: 'assets/images/dummy/venue_dummy.png',
      latitude: -6.8900,
      longitude: 107.6100,
      tags: ['Premium Venue'],
    ),
    Court(
      name: 'Mega Sport Center',
      location: 'Bandung',
      price: 'IDR 75K',
      rating: 4.8,
      image: 'assets/images/dummy/venue_dummy.png',
      latitude: -6.9200,
      longitude: 107.6200,
      tags: ['Elite Venue'],
    ),
    Court(
      name: 'Active Arena',
      location: 'Bandung Barat',
      price: 'IDR 60K',
      rating: 4.7,
      image: 'assets/images/dummy/venue_dummy.png',
      latitude: -6.9300,
      longitude: 107.6300,
      tags: ['Best Seller', 'Popular Venue'],
    ),
  ];

  List<Court> recommendedCourts = [
    Court(
      name: 'Progresif Sports',
      location: 'Kab. Bandung',
      price: 'IDR 50K',
      rating: 4.5,
      image: 'assets/images/dummy/venue_dummy.png',
      latitude: -6.9000,
      longitude: 107.6000,
      tags: ['Futsal', 'Basketball', 'Volleyball', 'Badminton'],
    ),
    Court(
      name: 'Sport Center Tech',
      location: 'Kab. Bandung',
      price: 'IDR 30K',
      rating: 4.0,
      image: 'assets/images/dummy/venue_dummy.png',
      latitude: -6.8900,
      longitude: 107.6100,
      tags: ['Premium Venue'],
    ),
    Court(
      name: 'Mega Sport Center',
      location: 'Bandung',
      price: 'IDR 75K',
      rating: 4.8,
      image: 'assets/images/dummy/venue_dummy.png',
      latitude: -6.9200,
      longitude: 107.6200,
      tags: ['Elite Venue'],
    ),
    Court(
      name: 'Active Arena',
      location: 'Bandung Barat',
      price: 'IDR 60K',
      rating: 4.7,
      image: 'assets/images/dummy/venue_dummy.png',
      latitude: -6.9300,
      longitude: 107.6300,
      tags: ['Best Seller', 'Popular Venue'],
    ),
  ];

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
                      const Text(
                        'Location',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 30,
                            color: AppColors.darkerPrimaryColor,
                          ),
                          DropdownButton<String>(
                            value: selectedLocation,
                            hint: const Text('Select Location'),
                            onChanged: (newValue) {
                              setState(() {
                                selectedLocation = newValue;
                              });
                            },
                            items: ['Kota Bandung', 'Kabupaten Bandung', 'Bandung Barat']
                                .map<DropdownMenuItem<String>>((location) {
                              return DropdownMenuItem<String>(value: location, child: Text(location));
                            }).toList(),
                            underline: const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.grey.withOpacity(0.5),
                        child: IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            size: 25,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const NotificationScreen()),
                            );
                          },
                        ),
                      ),
                    ],
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkerPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.tune,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Sports category filter buttons
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
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Nearby Court',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    showAllNearby = !showAllNearby;
                                  });
                                },
                                child: Text(
                                  showAllNearby ? 'See Less' : 'See All',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.darkerPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: (showAllNearby ? nearbyCourts : nearbyCourts.take(10).toList())
                                  .map((court) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: _nearbyCourtCard(
                                    court.name,
                                    court.location,
                                    court.price,
                                    court.rating,
                                    court.image,
                                    court.latitude,
                                    court.longitude,
                                    court.tags,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    } else if (index == 1) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Recommended for You',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    showAllRecommended = !showAllRecommended;
                                  });
                                },
                                child: Text(
                                  showAllRecommended ? 'See Less' : 'See All',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.darkerPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: (showAllRecommended
                                ? recommendedCourts
                                : recommendedCourts.take(10).toList())
                                .map((court) {
                              return Column(
                                children: [
                                  _recommendedCourtCard(
                                    court.name,
                                    court.location,
                                    court.price,
                                    court.rating,
                                    court.image,
                                    court.latitude,
                                    court.longitude,
                                    court.tags,
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: const FilterDrawer(),
    );
  }

  Widget _buildButton(String text) {
    bool isSelected = selectedSports.contains(text);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedSports.remove(text);
          } else {
            selectedSports.add(text);
          }
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
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.blue[800],
          ),
        ),
      ),
    );
  }

  Widget _nearbyCourtCard(String name, String location, String price, double rating, String imagePath, double venueLat, double venueLon, List<String> tags) {
    double? distance = _currentPosition != null
        ? _calculateDistance(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      venueLat,
      venueLon,
    )
        : null;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 250,
        ),
        child: Container(
          width: 230,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.whitePurple,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  width: 210,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: tags.map((tag) => fieldTag(tag)).toList(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.amber,
                      ),
                      Text(
                        '$rating',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 20,
                      color: AppColors.darkGrey,
                    ),
                    Text(
                      location,
                      style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.darkGrey,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      '|',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.darkGrey,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                        distance != null
                            ? "${distance?.toStringAsFixed(2)} km"
                            : "Loading...",
                        style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.darkGrey,
                        )
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const Text(
                      'Start From: ',
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.darkGrey
                      ),
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkerPrimaryColor
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recommendedCourtCard(String name, String location, String price, double rating, String imagePath, double venueLat, double venueLon, List<String> tags) {
    double? distance = _currentPosition != null
        ? _calculateDistance(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      venueLat,
      venueLon,
    )
        : null;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 150,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.whitePurple,
          ),
          child: Row(
            children: [
              // Image section
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  width: 120,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: tags.map((tag) => fieldTag(tag)).toList(),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber,
                              ),
                              Text(
                                '$rating',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 20,
                          color: AppColors.darkGrey,
                        ),
                        Text(
                          location,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.darkGrey,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          '|',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.darkGrey,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                            distance != null
                                ? "${distance?.toStringAsFixed(2)} km"
                                : "Loading...",
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.darkGrey,
                            )
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          'Start From: ',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.darkGrey
                          ),
                        ),
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkerPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue[800],
          fontSize: 12,
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    double distanceInMeters = Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    return distanceInMeters / 1000;
  }
}

class Court {
  final String name;
  final String location;
  final String price;
  final double rating;
  final String image;
  final double latitude;
  final double longitude;
  final List<String> tags;

  Court({
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.tags,
  });
}