import 'package:fitspace_sports_venue_booking_mobile/models/user_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/venue_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/main_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/venue_detail_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/size.dart';
import 'package:flutter/material.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key, required this.user, required this.venue});

  final User user;
  final Venue venue;

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: AppSize.getHeight(context),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/payments/success.png"),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Payment Successful",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkerPrimaryColor),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Your payment has successfully completed. \nYou can check your order in history order.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.darkerPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.whitePurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => VenueDetailScreen(
                                user: widget.user, venue: widget.venue),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text('Book Again')),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.whitePurple,
                        foregroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => MainScreen(user: widget.user),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text('Homepage')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
