
import 'package:fitspace_sports_venue_booking_mobile/models/user_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/venue_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/venue_service.dart';
import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/widgets/card_venue_widget.dart';

class MainVenueScreen extends StatefulWidget {
  const MainVenueScreen({super.key, required this.user});

  final User user;

  @override
  State<MainVenueScreen> createState() => _MainVenueScreenState();
}

class _MainVenueScreenState extends State<MainVenueScreen> {
  final _venueService = VenueService();
  final _searchController = TextEditingController();

  List<Venue> _venues = [];
  List<Venue> _searchedVenues = [];
  bool _isSearching = false;

  @override
  void initState() {
    _loadVenues();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
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
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: _isSearching
                ? TextField(
              controller: _searchController,
              onChanged: (value) {
              _applyFilters(value);
              },
              autofocus: true,
              style: const TextStyle(color: AppColors.darkGrey),
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: AppColors.darkGrey),
                border: InputBorder.none,
              ),
            )
                : const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Find a Venue',
                style: TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(
                _isSearching ? Icons.clear : Icons.search,
                color: AppColors.darkGrey,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  if (_isSearching) {
                    _isSearching = false;
                    _searchController.clear();
                    _searchedVenues.clear();
                  } else {
                    _isSearching = true;
                  }
                });
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: _searchedVenues.isNotEmpty ? ListView.builder(
          itemCount: _searchedVenues.length,
          itemBuilder: (context, index) {
            Venue venue = _searchedVenues[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CardVenueWidget(
                user: widget.user,
                venue: venue,
                sign: 'book',
              ),
            );
          },
        ) : ListView.builder(
          itemCount: _venues.length,
          itemBuilder: (context, index) {
            Venue venue = _venues[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CardVenueWidget(
                user: widget.user,
                venue: venue,
                sign: 'book',
              ),
            );
          },
        ),
      ),
    );
  }

  void _loadVenues() async {
    final result = await _venueService.loadVenues(widget.user);

    if (result['success'] == 'true') {
      final data = result['data'];
      print('Data: $data');


      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          final tempVenues = List<Venue>.from(data.map((e) => Venue.fromJson(e)));
          _venues =
              tempVenues.where((venue) => venue.fields!.isNotEmpty && venue.owner!.id! != widget.user.id).toList();
          for (var venue in _venues) {
            print(venue);
          }
        });
      }
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

  void _applyFilters(String query) {
    List<Venue> tempFilteredVenues = List.from(_venues);

    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      tempFilteredVenues = tempFilteredVenues.where((venue) {
        return venue.name!.toLowerCase().contains(query) ||
            venue.district!.toLowerCase().contains(query) ||
            venue.cityOrRegency!.toLowerCase().contains(query);
      }).toList();
    }

    setState(() {
      _searchedVenues = tempFilteredVenues;
      print(_searchedVenues);
    });
  }

}