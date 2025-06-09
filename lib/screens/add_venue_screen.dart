import 'package:fitspace_sports_venue_booking_mobile/services/user_service.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/venue_service.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class AddVenueScreen extends StatefulWidget {
  const AddVenueScreen({super.key});

  @override
  State<AddVenueScreen> createState() => _AddVenueScreenState();
}

class _AddVenueScreenState extends State<AddVenueScreen> {
  final _formKey = GlobalKey<FormState>();
  final _venueService = VenueService();
  final _userService = UserService();

  var _enteredVenueName = '';
  var _enteredPhoneNumber = '';
  var _enteredStreet = '';
  var _enteredDistrict = '';
  var _enteredCityOrRegency = '';
  var _enteredProvince = '';
  var _enteredPostalCode = '';
  var _enteredLatitude = 0.0;
  var _enteredLongitude = 0.0;

  Position? _currentPosition;

  var _isSubmit = false;

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
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
                  'Add Venue',
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
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  backgroundColor: AppColors.darkerPrimaryColor),
              child: _isSubmit ? const Center(child: CircularProgressIndicator()) : Text(
                "Save",
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.base),
              )),
        ),
      ),
      body: Container(
          color: AppColors.whitePurple,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: SingleChildScrollView(
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Venue Detail',
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(
                      color: AppColors.darkGrey,
                      fontSize: AppSize.getWidth(context) * 14 / 419,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            autocorrect: false,
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                              color: AppColors.darkGrey,
                              fontSize:
                              AppSize.getWidth(context) * 14 / 419,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Venue Name',
                              labelStyle: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: AppColors.grey,
                                fontSize:
                                AppSize.getWidth(context) * 14 / 419,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.darkGrey.withOpacity(0.25),
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.darkGrey.withOpacity(0.25),
                                  width: 2.0,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                // Border when there's an error
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.red,
                                  // Set this color to your error color
                                  width: 2.0,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                // Border when the field is focused and has an error
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.red,
                                  // Set this color to your error color
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.whitePurple,
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter venue name';
                              }

                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredVenueName = newValue!;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                              color: AppColors.darkGrey,
                              fontSize:
                              AppSize.getWidth(context) * 14 / 419,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              labelStyle: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: AppColors.grey,
                                fontSize:
                                AppSize.getWidth(context) * 14 / 419,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.darkGrey.withOpacity(0.25),
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.darkGrey.withOpacity(0.25),
                                  width: 2.0,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                // Border when there's an error
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.red,
                                  // Set this color to your error color
                                  width: 2.0,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                // Border when the field is focused and has an error
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.red,
                                  // Set this color to your error color
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.whitePurple,
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Enter your phone number';
                              }

                              RegExp phoneRegExp = RegExp(
                                r'^(?:\+?(\d{1,3}))?[-.\s]?(\(?\d{1,4}\)?[-.\s]?)?(\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,4})$',
                              );

                              if (!phoneRegExp.hasMatch(value)) {
                                return 'Enter a valid phone number';
                              }

                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredPhoneNumber = newValue!;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                              color: AppColors.darkGrey,
                              fontSize:
                              AppSize.getWidth(context) * 14 / 419,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Street Name',
                              labelStyle: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: AppColors.grey,
                                fontSize:
                                AppSize.getWidth(context) * 14 / 419,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.darkGrey.withOpacity(0.25),
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.darkGrey.withOpacity(0.25),
                                  width: 2.0,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                // Border when there's an error
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.red,
                                  // Set this color to your error color
                                  width: 2.0,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                // Border when the field is focused and has an error
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.red,
                                  // Set this color to your error color
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.whitePurple,
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter street name';
                              }

                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredStreet = newValue!;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            enabled: false,
                            initialValue: 'Jawa Barat',
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                              color: AppColors.darkGrey,
                              fontSize:
                              AppSize.getWidth(context) * 14 / 419,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Province',
                              labelStyle: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: AppColors.grey,
                                fontSize:
                                AppSize.getWidth(context) * 14 / 419,
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.darkGrey.withOpacity(0.25),
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.darkGrey.withOpacity(0.25),
                                  width: 2.0,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                // Border when there's an error
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.red,
                                  // Set this color to your error color
                                  width: 2.0,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                // Border when the field is focused and has an error
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.red,
                                  // Set this color to your error color
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.whitePurple,
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                            ),
                            onSaved: (newValue) {
                              _enteredProvince = newValue!;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: DropdownButtonFormField<String>(
                              value: _enteredCityOrRegency.isEmpty
                                  ? null
                                  : _enteredCityOrRegency,
                              elevation: 16,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: AppColors.darkGrey.withOpacity(0.25),
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: AppColors.darkGrey.withOpacity(0.25),
                                    width: 2.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  // Border when there's an error
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: AppColors.red,
                                    // Set this color to your error color
                                    width: 2.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  // Border when the field is focused and has an error
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: AppColors.red,
                                    // Set this color to your error color
                                    width: 2.0,
                                  ),
                                ),
                                hintText: 'Select a City or Regency',
                                hintStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                  color: AppColors.darkGrey,
                                  fontSize:
                                  AppSize.getWidth(context) * 14 / 419,
                                ),
                              ),
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: AppColors.darkGrey,
                                fontSize:
                                AppSize.getWidth(context) * 14 / 419,
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  _enteredCityOrRegency = value!;
                                });
                              },
                              items: [
                                'Bandung',
                                'Kabupaten Bandung',
                                'Kabupaten Bandung Barat'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                        color: AppColors.darkGrey,
                                        fontSize:
                                        AppSize.getWidth(context) *
                                            14 /
                                            419,
                                      ),
                                    ));
                              }).toList(),
                              isExpanded: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Choose your city';
                                }
                                return null;
                              },
                            )),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                              color: AppColors.darkGrey,
                              fontSize:
                              AppSize.getWidth(context) * 14 / 419,
                            ),
                            decoration: InputDecoration(
                              labelText: 'District',
                              labelStyle: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: AppColors.grey,
                                fontSize:
                                AppSize.getWidth(context) * 14 / 419,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.darkGrey.withOpacity(0.25),
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.darkGrey.withOpacity(0.25),
                                  width: 2.0,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                // Border when there's an error
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.red,
                                  // Set this color to your error color
                                  width: 2.0,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                // Border when the field is focused and has an error
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.red,
                                  // Set this color to your error color
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.whitePurple,
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter District name';
                              }

                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredDistrict = newValue!;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                              color: AppColors.darkGrey,
                              fontSize:
                              AppSize.getWidth(context) * 14 / 419,
                            ),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Postal Code',
                              labelStyle: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: AppColors.grey,
                                fontSize:
                                AppSize.getWidth(context) * 14 / 419,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.darkGrey.withOpacity(0.25),
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.darkGrey.withOpacity(0.25),
                                  width: 2.0,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                // Border when there's an error
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.red,
                                  // Set this color to your error color
                                  width: 2.0,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                // Border when the field is focused and has an error
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppColors.red,
                                  // Set this color to your error color
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.whitePurple,
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Postal Code';
                              }

                              if (value.length < 5) {
                                return 'Postal code must be 5 number';
                              }

                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredPostalCode = newValue!;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        _currentPosition == null
                            ? const Text('')
                            : Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${_currentPosition!.latitude.toStringAsFixed(
                                2)}, ${_currentPosition!
                                .longitude.toStringAsFixed(2)}',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _currentPosition == null
                            ? const Center(child: CircularProgressIndicator())
                            : SizedBox(
                          height: AppSize.getHeight(context) * 300 / 1120,
                          child: FlutterMap(
                            options: MapOptions(
                              initialCenter: LatLng(
                                  _currentPosition!.latitude,
                                  _currentPosition!.longitude),
                              initialZoom: 15,
                              onTap: (tapPosition, point) {
                                if (!false) {
                                  setState(() {
                                    _currentPosition = Position(
                                        latitude: point.latitude,
                                        longitude: point.longitude,
                                        timestamp: DateTime.now(),
                                        accuracy: 0.0,
                                        altitude: 0.0,
                                        altitudeAccuracy: 0,
                                        heading: 0,
                                        headingAccuracy: 0,
                                        speed: 0,
                                        speedAccuracy: 0);
                                    _enteredLatitude = point.latitude;
                                    _enteredLongitude = point.longitude;
                                  });
                                }
                              },
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                              ),
                              MarkerLayer(markers: [
                                Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: LatLng(
                                      _currentPosition!.latitude,
                                      _currentPosition!.longitude),
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Color.fromARGB(255, 255, 7, 7),
                                  ),
                                ),
                              ])
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ]),
          )),
    );
  }

  void _submit() async {
    setState(() {
      _isSubmit = true;
    });

    var isValid = _formKey.currentState!.validate();

    if (!isValid) {
      setState(() {
        _isSubmit = false;
      });
      return;
    }

    _formKey.currentState!.save();

    final user = await _userService.getUser();
    if (user == null) {
      setState(() {
        _isSubmit = false;
      });
      return;
    }

    final result = await _venueService.create(
        user,
        _enteredVenueName,
        _enteredPhoneNumber,
        _enteredProvince,
        _enteredDistrict,
        _enteredCityOrRegency,
        _enteredProvince,
        _enteredPostalCode,
        _enteredLatitude,
        _enteredLongitude);

    setState(() {
      _isSubmit = false;
    });

    if (result['success'] == 'true') {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign In Successfully')),
      );

      Navigator.of(context).pop();
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

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() => _currentPosition = position);
  }
}
