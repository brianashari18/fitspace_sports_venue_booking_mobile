import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/size.dart';
import 'package:fitspace_sports_venue_booking_mobile/widgets/carousel_widget.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitePurple,
      body: SingleChildScrollView(
        child: Container(
          height: AppSize.getHeight(context),
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CarouselWidget(),
              Container(
                width: double.infinity, // Full width
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkerPrimaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Get Started"),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
