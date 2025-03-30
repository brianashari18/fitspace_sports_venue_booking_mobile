import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _subjectError;
  String? _descriptionError;

  @override
  void initState() {
    super.initState();
    String email = 'dummyemail@example.com';
    _emailController.text = _maskEmail(email);
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
                  'Contact Us',
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
        child: Container(
          color: AppColors.whitePurple,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Got questions, suggestions, or need some assistance? We are here to help!',
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.darkGrey,
                    fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              const Text(
                'Our team at FitSpace is dedicated to ensuring your experience is smooth '
                    'and hassle-free. Whether you need help with bookings, have feedback'
                    'to share, or just want to learn more about our services, don\'t hesitate'
                    'to reach out.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.darkGrey,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10
                      )
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
                controller: _subjectController,
                decoration: InputDecoration(
                  labelText: 'Subject',
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    color: AppColors.grey,
                  ),
                  errorText: _subjectError,
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
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    color: AppColors.grey,
                  ),
                  errorText: _descriptionError,
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
                maxLines: 5,
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitFeedback,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkerPrimaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Submit',
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
      ),
    );
  }

  void _submitFeedback() {
    setState(() {
      _subjectError = _subjectController.text.isEmpty ? 'Subject is required' : null;
      _descriptionError =
      _descriptionController.text.isEmpty ? 'Description is required' : null;
    });

    if (_subjectError == null && _descriptionError == null) {
      print('Email: ${_emailController.text}');
      print('Subject: ${_subjectController.text}');
      print('Description: ${_descriptionController.text}');
    }
  }

  String _maskEmail(String email) {
    if (email.isEmpty || !email.contains('@')) {
      return email;
    }

    final parts = email.split('@');
    if (parts.length != 2) {
      return email;
    }

    final localPart = parts[0];
    final domainPart = parts[1];

    if (localPart.length <= 4) {
      return email;
    }

    final maskedLocalPart = localPart.substring(0, 2) +
        '*' * (localPart.length - 4) +
        localPart.substring(localPart.length - 2);
    return '$maskedLocalPart@$domainPart';
  }
}