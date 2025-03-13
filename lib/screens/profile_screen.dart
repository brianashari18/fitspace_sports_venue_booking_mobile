import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/about_us_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
            const Card(
              color: AppColors.darkerPrimaryColor,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage('https://your-image-url.com'), // Replace with actual image URL
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Imelda Damayanti',
                          style: TextStyle(
                            color: AppColors.baseColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '@imeldamayanti123',
                          style: TextStyle(
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
                      onTap: () {},
                    ),
                    _buildListTile(
                      icon: Icons.lock_outline,
                      title: 'Change Password',
                      subtitle: 'Update your password for better security',
                      onTap: () {},
                    ),
                    _buildListTile(
                      icon: Icons.inventory_2_outlined,
                      title: 'My Venue',
                      subtitle: 'Manage your listed venues and bookings',
                      onTap: () {},
                    ),
                    _buildListTile(
                      icon: Icons.exit_to_app,
                      title: 'Log out',
                      subtitle: 'Sign out of your account securely',
                      onTap: () {},
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
                      onTap: () {},
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
}