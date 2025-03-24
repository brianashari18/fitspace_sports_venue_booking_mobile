import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/widgets/card_venue_widget.dart';

class AllRecommendCourtScreen extends StatefulWidget{
  const AllRecommendCourtScreen({super.key});

  @override
  State<AllRecommendCourtScreen> createState() => _AllRecommendCourtScreenState();
}

class _AllRecommendCourtScreenState extends State<AllRecommendCourtScreen>{
  List<Map<String, dynamic>> venues = [
    {
      'name': 'Progresif Sports',
      'location': 'Location 1',
      'price': 'IDR 100K',
      'rating': 4.5,
      'imagePath': 'assets/images/venue_dummy.png',
      'latitude': 12.9716,
      'longitude': 77.5946,
      'tags': ['Football', 'Basketball'],
    },
    {
      'name': 'Progresif Sports',
      'location': 'Location 2',
      'price': 'IDR 150K',
      'rating': 4.8,
      'imagePath': 'assets/images/venue_dummy.png',
      'latitude': 13.0827,
      'longitude': 80.2707,
      'tags': ['Badminton', 'Volleyball'],
    },
    {
      'name': 'Progresif Sports',
      'location': 'Location 2',
      'price': 'IDR 150K',
      'rating': 4.8,
      'imagePath': 'assets/images/venue_dummy.png',
      'latitude': 13.0827,
      'longitude': 80.2707,
      'tags': ['Badminton', 'Volleyball'],
    },
    {
      'name': 'Progresif Sports',
      'location': 'Location 1',
      'price': 'IDR 100K',
      'rating': 4.5,
      'imagePath': 'assets/images/venue_dummy.png',
      'latitude': 12.9716,
      'longitude': 77.5946,
      'tags': ['Football', 'Basketball'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitePurple,
      appBar: AppBar(
        backgroundColor: AppColors.baseColor,
        automaticallyImplyLeading: false,
        title: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.west,
                    size: 24,
                    color: AppColors.darkGrey,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Recommend For You',
                  style: TextStyle(
                    color: AppColors.darkGrey,
                    fontSize: 24,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: venues.length,
          itemBuilder: (context, index) {
            var venue = venues[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CardVenueWidget(
                imagePath: venue['imagePath'],
                tags: List<String>.from(venue['tags']),
                rating: venue['rating'],
                name: venue['name'],
                location: venue['location'],
                price: venue['price'],
                latitude: venue['latitude'],
                longitude: venue['longitude'],
              ),
            );
          },
        ),
      ),
    );
  }
}