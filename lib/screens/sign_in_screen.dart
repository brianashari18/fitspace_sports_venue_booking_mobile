import 'package:fitspace_sports_venue_booking_mobile/screens/forgot_password_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/homepage_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/main_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/sign_up_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/google_service.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/size.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:fitspace_sports_venue_booking_mobile/services/auth_service.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/user_model.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final GoogleService _googleService = GoogleService();

  String? _emailError;
  String? _passwordError;
  bool _obscurePassword = true;
  bool _isSignIn = false;
  bool _isChecked = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitePurple,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/fitspace.jpg',
                    scale: 4.5,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Sign in to your account',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkerPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email Address',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.darkGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Enter your email address',
                        labelStyle: const TextStyle(
                          fontSize: 14,
                          color: AppColors.grey,
                        ),
                        errorText: _emailError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: AppColors.whitePurple,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.darkGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          fontSize: 14,
                          color: AppColors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: AppColors.whitePurple,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        errorText: _passwordError,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                            const ForgotPasswordScreen()));
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: AppColors.darkGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 150),
                  Column(
                    children: [
                      // Sign in button at the top
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _validateInputs,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkerPrimaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: _isSignIn
                              ? const CircularProgressIndicator()
                              : const Text(
                            'SIGN IN',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.whitePurple,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _signInWithGoogle,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.whitePurple,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(color: AppColors.darkerPrimaryColor),
                            ),
                          ),
                          icon: Transform.scale(
                            scale: 1.5,  // Adjust this value to resize the logo
                            child: Image.asset(
                              'assets/icons/google.png', // Google logo image
                              height: 24, // Maintain original height
                            ),
                          ),
                          label: const Text(
                            'Sign in with Google',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.darkGrey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  color: AppColors.darkGrey,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const SignUpScreen()));
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: const Text(
                                  'Create Account',
                                  style: TextStyle(
                                    color: AppColors.darkerPrimaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,  // Make it stand out
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegex =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  void _validateInputs() async {
    setState(() {
      _isSignIn = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    setState(() {
      _emailError = null;
      _passwordError = null;

      if (email.isEmpty || !_isValidEmail(email)) {
        _emailError = 'Enter a valid email address';
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });

    if (password.isEmpty) {
      _passwordError = 'Password cannot be empty';
      FocusScope.of(context).requestFocus(FocusNode());
    }

    final result = await _authService.login(email, password);

    setState(() {
      _isSignIn = false;
    });

    if (result['success'] == 'true') {
      User user = result['user'];

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign In Successfully')),
      );

      // Navigate to homepage or wherever you'd like
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainScreen(user: user)),
        (route) => false,
      );

    } else {
      final errorMessage = result['error'] is String
          ? result['error']
          : (result['error'] as List).join('\n');

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }

  }

  void _signInWithGoogle() async {
    final result = await _googleService.login();
    if (result['success'] != false) {
      User user = result['user'];
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Sign In Successfully')));
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainScreen(user: user)),
            (route) => false,
      );
    } else {
      _googleService.logout();
      final errorMessage = result['message'];
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }
}