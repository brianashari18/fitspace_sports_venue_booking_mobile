import 'package:fitspace_sports_venue_booking_mobile/screens/change_password_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/contact_us_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/my_account_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/my_venue_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/sign_in_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/google_service.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/about_us_screen.dart';

import '../models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.user});

  final User user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserService _userService = UserService();
  final GoogleService _googleService = GoogleService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitePurple,
      appBar: AppBar(
        backgroundColor: AppColors.baseColor,
        automaticallyImplyLeading: false,
        title: const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 25, left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Profile',
                style: TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              color: AppColors.darkerPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://static.vecteezy.com/system/resources/previews/003/715/527/large_2x/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-vector.jpg'), // Replace with actual image URL
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.user.firstName} ${widget.user.lastName}',
                          style: const TextStyle(
                            color: AppColors.baseColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.user.email!,
                          style: const TextStyle(
                            color: AppColors.baseColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: AppColors.baseColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    _buildListTile(
                      icon: Icons.person_outline,
                      title: 'My Account',
                      subtitle: 'Make changes to your account settings',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyAccountScreen(user: widget.user,),
                          ),
                        );
                      },
                    ),
                    _buildListTile(
                      icon: Icons.lock_outline,
                      title: 'Change Password',
                      subtitle: 'Update your password for better security',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen(user: widget.user,),
                          ),
                        );
                      },
                    ),
                    _buildListTile(
                      icon: Icons.inventory_2_outlined,
                      title: 'My Venue',
                      subtitle: 'Manage your listed venues and bookings',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MyVenueScreen(user: widget.user,),
                        ));
                      },
                    ),
                    _buildListTile(
                      icon: Icons.exit_to_app,
                      title: 'Log out',
                      subtitle: 'Sign out of your account securely',
                      onTap: () {
                        _showLogoutDialog(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: AppColors.baseColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    _buildListTile(
                      icon: Icons.notifications_outlined,
                      title: 'Help & Support',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContactUsScreen(),
                          ),
                        );
                      },
                    ),
                    _buildListTile(
                      icon: Icons.favorite_border,
                      title: 'About App',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutUsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.darkerPrimaryColor.withOpacity(0.1),
          ),
          Icon(
            icon,
            size: 24,
            color: AppColors.darkerPrimaryColor,
          ),
        ],
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.darkGrey,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.grey,
              ),
            )
          : null,
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppColors.grey,
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whitePurple,
              borderRadius: BorderRadius.circular(30.0),
            ),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor:
                      AppColors.darkerPrimaryColor.withOpacity(0.1),
                  child: const Icon(
                    Icons.exit_to_app,
                    size: 50, // Icon size
                    color: AppColors.darkerPrimaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Are you logging out?',
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColors.darkGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Are you sure you want to log out? You can always log back in at any time.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.darkGrey,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: AppColors.darkerPrimaryColor,
                          width: 1,
                        ),
                        foregroundColor: AppColors.darkGrey,
                        backgroundColor: AppColors.whitePurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.baseColor,
                        backgroundColor: AppColors.darkerPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                      ),
                      onPressed: () {
                        _userService.removeUser();
                        _googleService.logout();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
