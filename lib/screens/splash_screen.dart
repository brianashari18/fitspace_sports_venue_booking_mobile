import 'package:fitspace_sports_venue_booking_mobile/screens/start_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/user_service.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/user_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/sign_in_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/main_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _checkUserAndNavigate();
  }

  Future<void> _checkUserAndNavigate() async {
    try {
      final User? _user = await _userService.getUser();
      await Future.delayed(const Duration(seconds: 2));

      if (_user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen(user: _user,)),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const StartScreen()),
        );
      }
    } catch (e) {
      print('Error checking user: $e');
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image(
          image: AssetImage("assets/images/logo.png"),
        ),
      ),
    );
  }
}