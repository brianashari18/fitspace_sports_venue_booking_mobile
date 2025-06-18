import 'dart:io';

import 'package:fitspace_sports_venue_booking_mobile/services/field_service.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/user_service.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:image_picker/image_picker.dart';

import '../models/venue_model.dart';

class AddFieldScreen extends StatefulWidget {
  const AddFieldScreen({super.key, required this.venue});

  final Venue venue;

  @override
  State<AddFieldScreen> createState() => _AddFieldScreenState();
}

class _AddFieldScreenState extends State<AddFieldScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fieldService = FieldService();
  final _userService = UserService();
  final _picker = ImagePicker();

  var _enteredType = '';
  var _enteredPrice = 0;
  var _enteredPhotos = <File>[];

  var _isSubmit = false;
  var _errorPhoto = '';

  @override
  void initState() {
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
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.west,
                    size: 24,
                    color: AppColors.darkGrey,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Add Field',
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
              child: _isSubmit
                  ? const Center(child: CircularProgressIndicator())
                  : Text(
                      "Save",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
              Text('Field Detail',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
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
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: DropdownButtonFormField<String>(
                              value: _enteredType.isEmpty ? null : _enteredType,
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
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: AppColors.red,
                                    width: 2.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: AppColors.red,
                                    width: 2.0,
                                  ),
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                labelText: 'Select a type of field',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color: AppColors.darkGrey.withOpacity(0.5),
                                      fontSize:
                                          AppSize.getWidth(context) * 14 / 419,
                                    ),
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: AppColors.darkGrey,
                                    fontSize:
                                        AppSize.getWidth(context) * 14 / 419,
                                  ),
                              onChanged: (String? value) {
                                setState(() {
                                  _enteredType = value!;
                                });
                              },
                              items: [
                                'Futsal',
                                'Basketball',
                                'Badminton',
                                'Volleyball'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: Theme.of(context)
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
                                  return 'Choose your type of field';
                                }
                                return null;
                              },
                            )),
                        const SizedBox(height: 15,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: AppColors.darkGrey,
                                  fontSize:
                                      AppSize.getWidth(context) * 14 / 419,
                                ),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Price',
                              labelStyle: Theme.of(context)
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
                                return 'Enter Price';
                              }

                              final price = int.tryParse(value);
                              if (price == null) {
                                return 'Enter a valid price';
                              }

                              if (price <= 0) {
                                return 'Price must be greater than 0';
                              }

                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredPrice = int.tryParse(newValue!)!;
                            },
                          ),
                        ),

                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: _showOptions,
                          child: const Text('Add Image'),
                        ),

                        // Display selected images
                        const SizedBox(height: 15),
                        _enteredPhotos.isEmpty
                            ? const Text('No images selected.')
                            : GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _enteredPhotos.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _enteredPhotos[index],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -10,
                                  right: -7.5,
                                  child: IconButton(
                                    icon: const Icon(Icons.remove_circle,
                                        color: Colors.red),
                                    onPressed: () =>
                                        _removeImage(index),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        _errorPhoto.isNotEmpty ? Text(_errorPhoto, style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: AppColors.red,
                            fontSize: AppSize.getWidth(context) * 14 / 360
                        ),) : Container()

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
      _errorPhoto = '';
    });

    var isValid = _formKey.currentState!.validate();

    if (!isValid) {
      setState(() {
        _isSubmit = false;
      });
      return;
    }

    if (_enteredPhotos.isEmpty) {
      setState(() {
        _isSubmit = false;
        _errorPhoto = 'Enter at least one photo';
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

    final result = await _fieldService.create(
        user, widget.venue, _enteredType, _enteredPrice, _enteredPhotos);

    setState(() {
      _isSubmit = false;
    });

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add Field Successfully')),
      );

      Navigator.of(context).pop(true);
    } else {
      print(result);
      final errorMessage = result['error'] is String
          ? result['error']
          : (result['error'] as List).join('\n');

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  Future _getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _enteredPhotos.add(File(pickedFile.path));
      }
    });
  }

  Future _getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _enteredPhotos.add(File(pickedFile.path));
      }
    });
  }

  void _removeImage(int index) {
    setState(() {
      _enteredPhotos.removeAt(index);
    });
  }

  Future<void> _showOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('Photo Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _getImageFromGallery();
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _getImageFromCamera();
              },
            ),
          ],
        );
      },
    );
  }
}
