import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> { // Corrected this line
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Add content to the Scaffold here
      body: Center(
        child: Text('Profile Screen'), // Example content
      ),
    );
  }
}