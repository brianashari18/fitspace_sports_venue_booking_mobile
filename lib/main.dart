import 'package:fitspace_sports_venue_booking_mobile/screens/about_us_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/change_password_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/contact_us_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/forgot_password_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/main_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/my_account_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/profile_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/reset_password_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/reset_succes_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/sign_in_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/sign_up_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/splash_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/start_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/venue_detail_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/verification_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/widgets/filter_drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitspace Mobile App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const ProfileScreen(),
    );
  }
}