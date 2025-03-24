import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:geolocator/geolocator.dart';

class CardVenueWidget extends StatefulWidget {
  final String imagePath;
  final List<String> tags;
  final double rating;
  final String name;
  final String location;
  final String price;
  final double? latitude;
  final double? longitude;

  const CardVenueWidget({
    super.key,
    required this.imagePath,
    required this.tags,
    required this.rating,
    required this.name,
    required this.location,
    required this.price,
    this.latitude,
    this.longitude,
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
    if (widget.latitude != null && widget.longitude != null && _currentPosition != null) {
      _distance = _calculateDistance(
        widget.latitude!,
        widget.longitude!,
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
    }

    return Card(
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
                child: Image.asset(
                  widget.imagePath,
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
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
                          children: widget.tags.map((tag) => fieldTag(tag)).toList(),
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
                              '${widget.rating}',
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
                    widget.name,
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
                        widget.location,
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
                            fontSize: 12,
                            color: AppColors.darkGrey
                        ),
                      ),
                      Text(
                        widget.price,
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
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
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

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    double distanceInMeters = Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    return distanceInMeters / 1000;
  }
}