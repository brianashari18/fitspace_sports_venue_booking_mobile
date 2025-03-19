import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/widgets/verification_field_widget.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>{
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  final TextEditingController _textEditingController3 = TextEditingController();
  final TextEditingController _textEditingController4 = TextEditingController();
  bool _isVerify = false;
  bool _isResend = false;

  @override
  void dispose() {
    _textEditingController1.dispose();
    _textEditingController2.dispose();
    _textEditingController3.dispose();
    _textEditingController4.dispose();
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
                  'Verification',
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
            Text(
              'We have sent a code to ${widget.email}',
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.darkGrey,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VerificationFieldWidget(controller: _textEditingController1),
                VerificationFieldWidget(controller: _textEditingController2),
                VerificationFieldWidget(controller: _textEditingController3),
                VerificationFieldWidget(controller: _textEditingController4),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onVerify,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkerPrimaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isVerify
                        ? const CircularProgressIndicator()
                        : const Text(
                      'Verify',
                      style: TextStyle(
                        color: AppColors.whitePurple,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn't you receive any code?"),
                    InkWell(
                      onTap: _resendCode,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
                        child: _isResend
                            ? const SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(),
                        )
                            : const Text(
                          'Resend Code',
                          style: TextStyle(
                            color: AppColors.darkerPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      )
    );
  }

  void _onVerify() async {
    setState(() {
      _isVerify = true;
    });

    final otp =
        '${_textEditingController1.text}${_textEditingController2.text}${_textEditingController3.text}${_textEditingController4.text}';

    if (otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter the full code')));

      setState(() {
        _isVerify = false;
      });
      return;
    }

    // final result = await _apiService.validateOTP(int.parse(otp));

    setState(() {
      _isVerify = false;
    });

    // if (result['success'] == 'true') {
    //   final message = result['message'];
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text(message)));
    //
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(
    //           builder: (context) => ResetPasswordScreen(email: widget.email)),
    //           (route) => false);
    // } else {
    //   final errorMessage = result['error'];
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text(errorMessage)));
    // }

    _textEditingController1.clear();
    _textEditingController2.clear();
    _textEditingController3.clear();
    _textEditingController4.clear();
  }

  void _resendCode() async {
    setState(() {
      _isResend = true;
    });
    // final result = await _apiService.forgotPassword(widget.email);

    setState(() {
      _isResend = false;
    });
    // if (result['success'] == 'true') {
    //   final message = result['message'];
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text(message)));
    // } else {
    //   final errorMessage = result['error'];
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text(errorMessage)));
    // }
  }
}