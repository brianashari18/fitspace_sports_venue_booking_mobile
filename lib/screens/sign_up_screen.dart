import 'package:fitspace_sports_venue_booking_mobile/screens/sign_in_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/google_service.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/size.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:fitspace_sports_venue_booking_mobile/services/auth_service.dart';

import '../models/user_model.dart';
import 'main_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final AuthService _authService = AuthService();
  final GoogleService _googleService = GoogleService();


  String? _emailError;
  String? _firstNameError;
  String? _lastNameError;
  String? _passwordError;
  String? _confirmPasswordError;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isSignUp = false;
  bool _isChecked = false;

  bool _isMinLength = false;
  bool _hasUpperCase = false;
  bool _hasLowerCase = false;
  bool _hasNumber = false;
  bool _hasSpecialCharacter = false;

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
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
                    height: 150,
                    width: 200,
                  ),
                  const Text(
                    'Create new account',
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
                      'First Name',
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
                      'Last Name (Optional)',
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
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Enter your last name (optional)',
                        labelStyle: const TextStyle(
                          fontSize: 14,
                          color: AppColors.grey,
                        ),
                        errorText: _lastNameError,
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
                      onChanged: _checkPassword,
                      decoration: InputDecoration(
                        labelText: 'Enter your password',
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
                  const SizedBox(height: 15),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Confirm Password',
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
                      controller: _confirmPassController,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        labelText: 'Enter your confirm password',
                        labelStyle: const TextStyle(
                          fontSize: 14,
                          color: AppColors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: AppColors.whitePurple,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        errorText: _confirmPasswordError,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: "I’ve read and agreed to ",
                            style: const TextStyle(
                                color: AppColors.darkGrey),
                            children: <TextSpan>[
                              TextSpan(
                                text: "User Agreement",
                                style: const TextStyle(
                                    color: AppColors.darkerPrimaryColor,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Handle User Agreement tap
                                    print('User Agreement tapped');
                                  },
                              ),
                              const TextSpan(
                                text: " and ",
                                style: TextStyle(
                                    color: AppColors.darkGrey
                                ),
                              ),
                              TextSpan(
                                text: "Privacy Policy",
                                style: const TextStyle(
                                    color: AppColors.darkerPrimaryColor,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Handle Privacy Policy tap
                                    print('Privacy Policy tapped');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  Column(
                    children: [
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
                          child: _isSignUp
                              ? const CircularProgressIndicator()
                              : const Text(
                            'SIGN UP',
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
                          onPressed: _signUpWithGoogle,
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
                            'Sign up with Google',
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
                                'Already have an account?',
                                style: TextStyle(
                                  color: AppColors.darkGrey,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const SignInScreen()));
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: AppColors.darkerPrimaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
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

  void _checkPassword(String password) {
    setState(() {
      _isMinLength = password.length >= 8;
      _hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      _hasLowerCase = password.contains(RegExp(r'[a-z]'));
      _hasNumber = password.contains(RegExp(r'\d'));
      _hasSpecialCharacter =
          password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  void _validateInputs() async {
    setState(() {
      _isSignUp = true;
      _emailError = null;
      _firstNameError = null;
      _lastNameError = null;
      _passwordError = null;
      _confirmPasswordError = null;
    });

    final email = _emailController.text;
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPassController.text;

    if (email.isEmpty || !_isValidEmail(email)) {
      setState(() {
        _emailError = 'Enter a valid email address';
        _isSignUp = false; // Set to false on error
      });
      return;
    }

    if (firstName.trim().isEmpty) {
      setState(() {
        _firstNameError = 'Enter a valid name';
        _isSignUp = false; // Set to false on error
      });
      return;
    } else if (firstName.length < 4) {
      setState(() {
        _firstNameError = 'Must be at least 4 characters';
        _isSignUp = false; // Set to false on error
      });
      return;
    }

    if (lastName.trim().isNotEmpty &&  lastName.length < 4) {
      setState(() {
        _lastNameError = 'Must be at least 4 characters';
        _isSignUp = false; // Set to false on error
      });
      return;
    }

    if (password.isEmpty) {
      setState(() {
        _passwordError = 'Password cannot be empty';
        _isSignUp = false;
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _confirmPasswordError = 'Passwords do not match';
        _isSignUp = false;
      });
      return;
    }

    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must agree to the User Agreement and Privacy Policy")),
      );
      setState(() {
        _isSignUp = false;
      });
      return;
    }

    final result = await _authService.register(email, firstName, lastName, password, confirmPassword);

    if (result['success'] == 'true') {
      setState(() {
        _isSignUp = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration successful!")),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SignInScreen()));
    } else {
      setState(() {
        _isSignUp = false;
      });
      String errorMessage;
      if (result['error'] is String) {
        errorMessage = result['error'];
      } else if (result['error'] is List) {
        errorMessage = (result['error'] as List).join('\n');
      } else {
        errorMessage = 'An unknown error occurred.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  void _signUpWithGoogle() async {
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