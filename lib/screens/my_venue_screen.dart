import 'package:fitspace_sports_venue_booking_mobile/screens/add_venue_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/widgets/card_venue_widget.dart';

class MyVenueScreen extends StatefulWidget {
  const MyVenueScreen({super.key});

  @override
  State<MyVenueScreen> createState() => _MyVenueScreenState();
}

class _MyVenueScreenState extends State<MyVenueScreen> {
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
    }
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
                  'My Venue',
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
      bottomNavigationBar: BottomAppBar(
        height: 90,
        padding: const EdgeInsets.all(0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: AppColors.base),
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddVenueScreen(),));
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  backgroundColor: AppColors.darkerPrimaryColor),
              child: Text(
                "Add Venue",
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.base),
              )),
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
