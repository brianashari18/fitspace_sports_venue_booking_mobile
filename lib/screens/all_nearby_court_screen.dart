import 'package:fitspace_sports_venue_booking_mobile/models/user_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/venue_model.dart';
import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/widgets/card_venue_widget.dart';

class AllNearbyCourtScreen extends StatefulWidget{
  const AllNearbyCourtScreen({super.key, required this.user, required this.venues});

  final User user;
  final List<Venue> venues;

  @override
  State<AllNearbyCourtScreen> createState() => _AllNearbyCourtScreenState();

}

class _AllNearbyCourtScreenState extends State<AllNearbyCourtScreen>{
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
                  'Nearby Court',
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
          itemCount: widget.venues.length,
          itemBuilder: (context, index) {
            var venue = widget.venues[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CardVenueWidget(
                user: widget.user,
                venue: venue,
                sign: 'book',
              ),
            );
          },
        ),
      ),
    );
  }
}