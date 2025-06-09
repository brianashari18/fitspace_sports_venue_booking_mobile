import 'dart:math';

import 'package:fitspace_sports_venue_booking_mobile/models/venue_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/user_service.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/venue_service.dart';
import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/widgets/card_venue_widget.dart';

class MainVenueScreen extends StatefulWidget {
  const MainVenueScreen({super.key});

  @override
  State<MainVenueScreen> createState() => _MainVenueScreenState();
}

class _MainVenueScreenState extends State<MainVenueScreen> {
  final _venueService = VenueService();
  final _userService = UserService();

  List<Venue> _venues = [];

  List<Map<String, dynamic>> venues = [
    {
      'name': 'Progresif Sports',
      'location': 'Location 1',
      'price': 'IDR 100K',
      'rating': 4.5,
      'imagePath': 'assets/images/dummy/venue_dummy.png',
      'latitude': 12.9716,
      'longitude': 77.5946,
      'tags': ['Football', 'Basketball'],
    },
    {
      'name': 'Progresif Sports',
      'location': 'Location 2',
      'price': 'IDR 150K',
      'rating': 4.8,
      'imagePath': 'assets/images/dummy/venue_dummy.png',
      'latitude': 13.0827,
      'longitude': 80.2707,
      'tags': ['Badminton', 'Volleyball'],
    },
    {
      'name': 'Progresif Sports',
      'location': 'Location 2',
      'price': 'IDR 150K',
      'rating': 4.8,
      'imagePath': 'assets/images/dummy/venue_dummy.png',
      'latitude': 13.0827,
      'longitude': 80.2707,
      'tags': ['Badminton', 'Volleyball'],
    },
    {
      'name': 'Progresif Sports',
      'location': 'Location 1',
      'price': 'IDR 100K',
      'rating': 4.5,
      'imagePath': 'assets/images/dummy/venue_dummy.png',
      'latitude': 12.9716,
      'longitude': 77.5946,
      'tags': ['Football', 'Basketball'],
    },
  ];

  @override
  void initState() {
    _loadVenues();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitePurple,
      appBar: AppBar(
        backgroundColor: AppColors.baseColor,
        automaticallyImplyLeading: false,
        title: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Find a Venue',
                style: TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                color: AppColors.darkGrey,
                size: 30,
              ),
              onPressed: () {

              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _venues.length,
          itemBuilder: (context, index) {
            Venue venue = _venues[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CardVenueWidget(
                imagePath: venue.fields![0].gallery![0].photoUrl != null ? venue.fields![0].gallery![0].photoUrl! : '',
                tags: List<String>.from(venue.fields!.map((e) => e.type,)),
                rating: venue.rating!,
                name: venue.name!,
                location: venue.cityOrRegency!,
                price: venue.fields != null && venue.fields!.isNotEmpty
                    ? venue.fields!
                    .map((e) => e.price)
                    .reduce((a, b) => min(a!, b!))!.toDouble()
                    : 0,

                latitude: venue.latitude,
                longitude: venue.longitude,
              ),
            );
          },
        ),
      ),
    );
  }

  void _loadVenues() async {
    final user = await _userService.getUser();

    if (user == null) {
      return;
    }

    final result = await _venueService.loadVenues(user);

    if (result['success'] == 'true') {
      final data = result['data'];
      print('Data: $data');


      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          _venues = List<Venue>.from(data.map((e) => Venue.fromJson(e)));
          for (var venue in _venues) {
            print(venue);
          }
        });
      }
    } else {
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