import 'package:fitspace_sports_venue_booking_mobile/models/user_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/add_venue_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/user_service.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/venue_service.dart';
import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/widgets/card_venue_widget.dart';

import '../models/venue_model.dart';

class MyVenueScreen extends StatefulWidget {
  const MyVenueScreen({super.key, required this.user});

  final User user;

  @override
  State<MyVenueScreen> createState() => _MyVenueScreenState();
}

class _MyVenueScreenState extends State<MyVenueScreen> {
  final _venueService = VenueService();

  var _myVenues = [];
  var _isLoad = true;

  @override
  void initState() {
    _loadVenues();
    super.initState();
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
                  'My Venue',
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
      bottomNavigationBar: BottomAppBar(
        height: 90,
        padding: const EdgeInsets.all(0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: AppColors.base),
          child: ElevatedButton(
              onPressed: () async {
                final back = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddVenueScreen(),));

                if (back) {
                  _loadVenues();
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  backgroundColor: AppColors.darkerPrimaryColor),
              child: Text(
                "Add Venue",
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.base),
              )),
        ),
      ),
      body: SafeArea(
        child: _myVenues.isEmpty ? const Center(
          child: SizedBox(
            height: 230,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sentiment_dissatisfied,
                    size: 40, color: AppColors.darkGrey),
                SizedBox(height: 10),
                Text(
                  'No venues found',
                  style: TextStyle(
                      fontSize: 16, color: AppColors.darkGrey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ) : ListView.builder(
          itemCount: _myVenues.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var venue = _myVenues[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CardVenueWidget(
                user: widget.user,
                venue: venue as Venue,
                sign: 'owner',
              ),
            );
          },
        ),
      ),
    );
  }

  void _loadVenues() async {
    final result = await _venueService.loadVenuesByOwner(widget.user);
    print('venues: $result');

    if (result['success'] == 'true') {
      List<dynamic> data = result['data'];
      setState(() {
        _myVenues = data.map((item) => Venue.fromJson(item)).toList();
        print('myvenues: $_myVenues');
        _isLoad = false;
      });
    } else {
      setState(() => _isLoad = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['error'].toString())));
    }
  }
}
