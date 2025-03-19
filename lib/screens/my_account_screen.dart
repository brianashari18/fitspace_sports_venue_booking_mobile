import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  String? _firstNameError;
  String? _lastNameError;

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

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
                  'My Account',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.grey,
                        width: 1,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.baseColor,
                      child: Icon(
                        Icons.person,
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'email@example.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                enabled: false,
                filled: true,
                fillColor: AppColors.grey.withOpacity(0.3),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'Email',
                labelStyle: const TextStyle(
                  fontSize: 14,
                  color: AppColors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'Enter your first name',
                labelStyle: const TextStyle(
                  fontSize: 14,
                  color: AppColors.grey,
                ),
                errorText: _firstNameError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.darkerPrimaryColor),
                ),
                filled: true,
                fillColor: AppColors.baseColor,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Enter your last name',
                labelStyle: const TextStyle(
                  fontSize: 14,
                  color: AppColors.grey,
                ),
                errorText: _lastNameError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.darkerPrimaryColor),
                ),
                filled: true,
                fillColor: AppColors.baseColor,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkerPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Update Profile',
                  style: TextStyle(
                    color: AppColors.whitePurple,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateProfile() {
    setState(() {
      _firstNameError = _firstNameController.text.isEmpty
          ? 'First name cannot be empty'
          : null;
      _lastNameError = _lastNameController.text.isEmpty
          ? 'Last name cannot be empty'
          : null;
    });

    if (_firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    }
  }
}