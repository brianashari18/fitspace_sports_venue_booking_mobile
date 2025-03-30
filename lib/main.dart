import 'package:fitspace_sports_venue_booking_mobile/screens/booking_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/payment_confirmation_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/payment_detail_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/payment_success_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/sign_in_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/sign_up_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/splash_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/start_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/venue_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('en_US', null).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitspace Mobile App',
      theme: ThemeData(useMaterial3: true, textTheme: GoogleFonts.robotoTextTheme()),
      home: const MyBookingPage(),
    );
  }

}
