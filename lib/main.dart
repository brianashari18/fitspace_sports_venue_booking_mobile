import 'package:fitspace_sports_venue_booking_mobile/screens/sign_in_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/sign_up_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/splash_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/start_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/venue_detail_screen.dart';
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
      home: const VenueDetailScreen(),
    );
  }
}