import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';

class AddVenueScreen extends StatefulWidget {
  const AddVenueScreen({super.key});

  @override
  State<AddVenueScreen> createState() => _AddVenueScreenState();
}

class _AddVenueScreenState extends State<AddVenueScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _enteredVenueName = '';
  var _enteredPhoneNumber = '';
  var _enteredStreet = '';
  var _enteredProvince = '';
  var _enteredCityOrRegency = '';
  var _enteredDistrict = '';
  var _enteredPostalCode = '';

  String? _selectedCityOrRegency;

  LatLng? _pickedLocation;
  Set<Marker> _markers = {};

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _pickedLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _onMapTapped(LatLng location) {
    setState(() {
      _pickedLocation = location;
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('picked-location'),
          position: location,
        ),
      );
    });
  }

  void _onSubmit(BuildContext context) {
    bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    if (_pickedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select the location on map')));
      return;
    }

    _formKey.currentState!.save();

    print('Venue Name: $_enteredVenueName');
    print('Phone Number: $_enteredPhoneNumber');
    print('Street: $_enteredStreet');
    print('Province: $_enteredProvince');
    print('City/Regency: $_enteredCityOrRegency');
    print('District: $_enteredDistrict');
    print('Postal Code: $_enteredPostalCode');
    print('Location: $_pickedLocation');
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
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
              onPressed: () {
                _onSubmit(context);
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  backgroundColor: AppColors.darkerPrimaryColor),
              child: Text(
                "Save",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.base),
              )),
        ),
      ),
      body: Container(
        color: AppColors.whitePurple,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Venue Detail',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Enter venue name',
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        // Mengatur enabledBorder
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        // Menambahkan focusedBorder
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.darkGrey,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        //Menambahkan errorBorder
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.red,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.whitePurple,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          value.length < 5) {
                        return "Please enter a valid name";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredVenueName = value!;
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
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Enter phone number',
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.darkGrey,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.red,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.whitePurple,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter a phone number";
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return "Phone number must contain only digits";
                      }
                      if (value.length < 10) {
                        return "Phone number must be at least 10 digits";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredPhoneNumber = value!;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Address Detail',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Street Name',
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.darkGrey,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.red,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.whitePurple,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter a street name";
                      }
                      if (value.length < 3) {
                        return "Street name must be at least 3 characters";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredStreet = value!;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    initialValue: 'Jawa Barat',
                    autocorrect: false,
                    enabled: false,
                    style: const TextStyle(
                      color: AppColors.darkGrey,
                    ),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.grey,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.grey.withOpacity(0.1),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter a province";
                      }
                      if (value.length < 3) {
                        return "Province name must be at least 3 characters";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredProvince = value!;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonFormField<String>(
                    items: <String>[
                      'Bandung',
                      'Kabupaten Bandung',
                      'Kabupaten Bandung Barat'
                    ].map(
                      (String value) {
                        return DropdownMenuItem(
                            value: value, child: Text(value));
                      },
                    ).toList(),
                    iconEnabledColor: AppColors.grey,
                    decoration: InputDecoration(
                      labelText: 'City or Regency',
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.grey,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.red,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.whitePurple,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select a city or regency";
                      }
                      return null;
                    },
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCityOrRegency = newValue;
                      });
                    },
                    onSaved: (value) {
                      _enteredCityOrRegency = value!;
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
                    decoration: InputDecoration(
                      labelText: 'District',
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.darkGrey,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.red,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.whitePurple,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter a district name";
                      }
                      if (value.length < 3) {
                        return "District name must be at least 3 characters";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredDistrict = value!;
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
                    keyboardType: const TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      labelText: 'Postal Code',
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.darkGrey,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.red,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.whitePurple,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter a postal code";
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return "Postal code must contain only digits";
                      }
                      if (value.length != 5) {
                        return "Postal code must be 5 digits";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredPostalCode = value!;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _pickedLocation != null
                          ? Text(
                              'Latitude: ${_pickedLocation!.latitude}\nLongitude: ${_pickedLocation!.longitude}')
                          : const SizedBox.shrink(),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 300,
                        child: _pickedLocation == null
                            ? const Center(child: CircularProgressIndicator())
                            : GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: _pickedLocation!,
                                  zoom: 15,
                                ),
                                onTap: _onMapTapped,
                                markers: _markers,
                                gestureRecognizers: <Factory<
                                    OneSequenceGestureRecognizer>>{
                                  Factory<OneSequenceGestureRecognizer>(
                                    () => EagerGestureRecognizer(),
                                  ),
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
