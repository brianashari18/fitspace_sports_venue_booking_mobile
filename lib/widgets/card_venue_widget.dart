import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../models/user_model.dart';
import '../models/venue_model.dart';
import '../screens/venue_detail_screen.dart';

class CardVenueWidget extends StatefulWidget {
  final User user;
  final Venue venue;

  const CardVenueWidget({
    super.key,
    required this.user,
    required this.venue,
  });

  @override
  State<CardVenueWidget> createState() => _CardVenueWidgetState();
}

class _CardVenueWidgetState extends State<CardVenueWidget> {
  Position? _currentPosition;
  double? _distance;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.venue.latitude != null &&
        widget.venue.longitude != null &&
        _currentPosition != null) {
      _distance = _calculateDistance(
        widget.venue.latitude!,
        widget.venue.longitude!,
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VenueDetailScreen(user: widget.user, venue: widget.venue),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 150,
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.whitePurple,
            ),
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'http://192.168.18.11:8080${widget.venue.fields![0].gallery![0].photoUrl != null ? widget.venue.fields![0].gallery![0].photoUrl! : ''}',
                          width: double.infinity,
                          height: 100,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: List<String>.from(
                                      widget.venue.fields!.map(
                                    (e) => e.type,
                                  )).map((tag) => fieldTag(tag)).toList(),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 16,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                      '${widget.venue.rating}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.darkGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.venue.name!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 20,
                                color: AppColors.darkGrey,
                              ),
                              Text(
                                widget.venue.cityOrRegency!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                '|',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                _distance != null
                                    ? "${_distance?.toStringAsFixed(2)} km"
                                    : "Loading...",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Text(
                                'Start From: ',
                                style: TextStyle(
                                    fontSize: 12, color: AppColors.darkGrey),
                              ),
                              Text(
                                'Rp${NumberFormat('#,###', 'id_ID').format(widget.venue.fields != null && widget.venue.fields!.isNotEmpty ? widget.venue.fields!.map((e) => e.price).reduce((a, b) => min(a!, b!))!.toDouble() : 0)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkerPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget fieldTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue[800],
          fontSize: 12,
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      print("Loading...");
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print("!enabled");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print("denied");
          return;
        }
      }

      print("here");
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 3), // Timeout dalam 10 detik
        );
        print(position);
      } catch (e) {
        print("Gagal mendapatkan lokasi: $e");
      }

      print("pass");

      Position? position = await Geolocator.getLastKnownPosition();
      if (position != null) {
        print("Lokasi terakhir: ${position.latitude}, ${position.longitude}");
      } else {
        print("Tidak ada lokasi terakhir yang tersedia");
      }

      setState(() {
        print("test");
        _currentPosition = position;
        _isLoading = false; // Set loading to false after location is fetched
      });
    } catch (e) {
      setState(() {
        _isLoading = false; // Set loading to false in case of error
      });
      print("Error getting location: $e");
    }
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    double distanceInMeters =
        Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    return distanceInMeters / 1000;
  }
}
