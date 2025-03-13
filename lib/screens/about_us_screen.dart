import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitePurple,
      appBar: AppBar(
        backgroundColor: AppColors.baseColor,
        automaticallyImplyLeading: false,
        title: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
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
                  'About Us',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/venue_dummy.png',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 24),
              RichText(
                textAlign: TextAlign.justify,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'FitSpace is your ',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.darkGrey,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: 'ultimate destination ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkerPrimaryColor,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: 'for discovering and booking the finest sports venues around you. ',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.darkGrey,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text:
                          'Whether you’re a seasoned athlete, a casual sports enthusiast, or someone just beginning your fitness journey, '
                          'we are here to make your experience smoother, more convenient, and enjoyable.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.darkGrey,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Our Vision',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGrey,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'To become the leading platform connecting sports enthusiasts with top-tier sports venues, fostering a healthy and active community across Indonesia.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.darkGrey,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 24),
              const Text(
                'Our Mission',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGrey,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '• Provide easy access to a variety of sports venues.\n'
                    '• Deliver a fast and secure booking experience through \n'
                    '  cutting-edge technology.\n'
                    '• Support the sports community with trusted \n'
                    '   information, recommendations, and reviews.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.darkGrey,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}