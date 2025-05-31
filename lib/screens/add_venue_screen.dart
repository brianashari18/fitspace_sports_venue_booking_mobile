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

  var _enteredVenueName = '';
  var _enteredPhoneNumber = '';
  var _enteredStreet = '';
  var _enteredDistrict = '';
  var _enteredCityOrRegency = 'Bandung';
  var _enteredProvince = '';
  var _enteredPostalCode = '';
  var _enteredLatitude = '';
  var _enteredLongitude = '';

  Position? _currentPosition;

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
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  backgroundColor: AppColors.darkerPrimaryColor),
              child: Text(
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
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
            'Venue Detail',
            style: Theme
                .of(context)
                .textTheme
                .labelMedium!
                .copyWith(
                color: AppColors.darkGrey,
                fontSize: AppSize.getWidth(context) * 14 / 419,
                fontWeight: FontWeight.bold
            )
        ),
        const SizedBox(height: 10),
        Form(
          key: _formKey,
          child: Container(
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
                fontSize: AppSize.getWidth(context) * 14 / 419,
              ),
              decoration: InputDecoration(
                labelText: 'Venue name',
                labelStyle: Theme
                    .of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(
                  color: AppColors.grey,
                  fontSize: AppSize.getWidth(context) * 14 / 419,
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
                filled: true,
                fillColor: AppColors.whitePurple,
                floatingLabelBehavior: FloatingLabelBehavior.never,
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
              fontSize: AppSize.getWidth(context) * 14 / 419,
            ),
            decoration: InputDecoration(
              labelText: 'Street Name',
              labelStyle: Theme
                  .of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(
                color: AppColors.grey,
                fontSize: AppSize.getWidth(context) * 14 / 419,
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
              filled: true,
              fillColor: AppColors.whitePurple,
              floatingLabelBehavior: FloatingLabelBehavior.never,
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
              fontSize: AppSize.getWidth(context) * 14 / 419,
            ),
            decoration: InputDecoration(
              labelText: 'Province',
              labelStyle: Theme
                  .of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(
                color: AppColors.grey,
                fontSize: AppSize.getWidth(context) * 14 / 419,
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
              filled: true,
              fillColor: AppColors.whitePurple,
              floatingLabelBehavior: FloatingLabelBehavior.never,
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
              border: Border.all(
                color: AppColors.darkGrey.withOpacity(0.25),
                width: 2.0,
              ),
            ),
            child: DropdownButton<String>(
              value: _enteredCityOrRegency,
              elevation: 16,
              style: Theme
                  .of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(
                color: AppColors.darkGrey,
                fontSize: AppSize.getWidth(context) * 14 / 419,
              ),
              underline: Container(),
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
                        fontSize: AppSize.getWidth(context) * 14 / 419,
                      ),
                    ));
              }).toList(),
              isExpanded: true,
              selectedItemBuilder: (BuildContext context) {
                return [
                  'Bandung',
                  'Kabupaten Bandung',
                  'Kabupaten Bandung Barat'
                ].map<Widget>((String value) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    child: Text(
                      value,
                      style: Theme
                          .of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(
                        color: AppColors.darkGrey,
                        fontSize: AppSize.getWidth(context) * 14 / 419,
                      ),
                    ),
                  );
                }).toList();
              },
              hint: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 12),
                child: Text(
                  'Select a City or Regency',
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(
                    color: AppColors.darkGrey,
                    fontSize: AppSize.getWidth(context) * 14 / 419,
                  ),
                ),
              ),
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
              fontSize: AppSize.getWidth(context) * 14 / 419,
            ),
            decoration: InputDecoration(
              labelText: 'District',
              labelStyle: Theme
                  .of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(
                color: AppColors.grey,
                fontSize: AppSize.getWidth(context) * 14 / 419,
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
              filled: true,
              fillColor: AppColors.whitePurple,
              floatingLabelBehavior: FloatingLabelBehavior.never,
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
              fontSize: AppSize.getWidth(context) * 14 / 419,
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
                fontSize: AppSize.getWidth(context) * 14 / 419,
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
              filled: true,
              fillColor: AppColors.whitePurple,
              floatingLabelBehavior: FloatingLabelBehavior.never,
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
        Text('$_currentPosition'),
        const SizedBox(height: 20,),
        _currentPosition == null
            ? const CircularProgressIndicator()
            : Flexible(
              child: FlutterMap(
                        options: MapOptions(
              initialCenter: LatLng(
              _currentPosition!.latitude, _currentPosition!.longitude),
                        initialZoom: 12,
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
                });
              }
                        },),
                        children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              MarkerLayer(markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(
                      _currentPosition!.latitude, _currentPosition!.longitude),
                  child: const Icon(
                    Icons.location_on,
                    color: Color.fromARGB(255, 255, 7, 7),
                  ),
                ),
              ])
                        ],
                      ),
            ),])
      ),
    );
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
