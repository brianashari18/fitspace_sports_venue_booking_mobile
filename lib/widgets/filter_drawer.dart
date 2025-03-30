import 'package:flutter/material.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Filter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.sports_soccer),
            title: const Text('Futsal'),
            onTap: () {
              // Tambahkan logika untuk filter futsal
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.sports_basketball),
            title: const Text('Basketball'),
            onTap: () {
              // Tambahkan logika untuk filter basketball
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.sports_tennis),
            title: const Text('Badminton'),
            onTap: () {
              // Tambahkan logika untuk filter badminton
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.sports_volleyball),
            title: const Text('Volleyball'),
            onTap: () {
              // Tambahkan logika untuk filter volleyball
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}