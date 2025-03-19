import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/verification_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isContinue = false;
  String? _emailError;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Forgot Password',
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
      body: Container(
        color: AppColors.whitePurple,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your email to reset your password',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.darkGrey,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Registered Email',
                hintStyle: const TextStyle(
                  color: AppColors.grey,
                ),
                filled: true,
                fillColor: Colors.white,
                errorText: _emailError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    width: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkerPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Reset Password',
                  style: TextStyle(
                    color: AppColors.whitePurple,
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

  bool _isValidEmail(String email) {
    final RegExp emailRegex =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  void _handleContinue() async {
    setState(() {
      _isContinue = true;
    });

    final email = _emailController.text.trim();
    if (_isValidEmail(email)) {
      setState(() {
        _emailError = null;
      });

      // final result = await _apiService.forgotPassword(email);

      setState(() {
        _isContinue = false;
      });

      // if (result['success'] == 'true') {
      //   final message = result['message'];
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: Text(message)));
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //         builder: (context) => VerificationScreen(email: email)),
      //   );
      // } else {
      //   final errorMessage = result['error'];
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: Text(errorMessage)));
      // }
    } else {
      setState(() {
        _isContinue = false;
        _emailError = 'Please enter a valid email address';
        FocusScope.of(context).requestFocus(FocusNode());
      });
    }
  }
}