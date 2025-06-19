import 'dart:io';
import 'package:fitspace_sports_venue_booking_mobile/models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:fitspace_sports_venue_booking_mobile/models/field_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/field_service.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/user_service.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:image_picker/image_picker.dart';

import '../models/field_schedule_model.dart';
import '../models/venue_model.dart';

class UpdateFieldScreen extends StatefulWidget {
  const UpdateFieldScreen(
      {super.key, required this.venue, required this.field, required this.user});

  final User user;
  final Venue venue;
  final Field field;

  @override
  State<UpdateFieldScreen> createState() => _UpdateFieldScreenState();
}

class _UpdateFieldScreenState extends State<UpdateFieldScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fieldService = FieldService();
  final _userService = UserService();
  final _picker = ImagePicker();

  var _enteredType = '';
  var _enteredPrice = 0;
  var _enteredPhotos = <File>[];
  var _oldPhotos = <File>[];
  var _newPhotos = <File>[];
  var _removedImages = <String>[];

  var _isSubmit = false;
  var _isLoad = false;
  var _errorPhoto = '';

  List<DateTime> _weeklyDate = [];
  DateTime _selectedDate = DateTime.now();
  String _selectedTimeSlot = '';
  List<FieldSchedule> _filteredFieldSchedules = [];
  late Field field;
  List<FieldSchedule> _updatedFieldSchedules = [];

  @override
  void initState() {
    _enteredType = widget.field.type!;
    _enteredPrice = widget.field.price!;
    _weeklyDate = _generateWeeklyDate();
    _loadField();

    for (var photo in widget.field.gallery!) {
      downloadImage(photo.photoUrl!).then((file) {
        if (file != null) {
          setState(() {
            _enteredPhotos.add(file);
          });
        } else {
          print("Failed to download image.");
        }
      });
    }
    
    _oldPhotos = _enteredPhotos;

    print(_enteredPhotos);

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
                  'Update Field',
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
                _submit(context);
              },
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
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelText: 'Select a type of field',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color:
                                          AppColors.darkGrey.withOpacity(0.5),
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
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            initialValue: _enteredPrice.toString(),
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
                          onPressed: () {
                            _showOptions(context);
                          },
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          onPressed: () => _removeImage(index),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                        _errorPhoto.isNotEmpty
                            ? Text(
                                _errorPhoto,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: AppColors.red,
                                        fontSize: AppSize.getWidth(context) *
                                            14 /
                                            360),
                              )
                            : Container(),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Field Schedule',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      color: AppColors.darkGrey,
                                      fontSize:
                                          AppSize.getWidth(context) * 14 / 419,
                                      fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height:
                          AppSize.getWidth(context) * 50 / 360,
                          child: ListView.separated(
                            itemCount: _weeklyDate.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedDate = _weeklyDate[index];
                                  _selectedTimeSlot = '';
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(7.5),
                                width: AppSize.getWidth(context) *
                                    75 /
                                    360,
                                decoration: BoxDecoration(
                                    color: _selectedDate.day ==
                                        _weeklyDate[index].day
                                        ? AppColors.primaryColor
                                        : AppColors.whitePurple,
                                    borderRadius:
                                    BorderRadius.circular(15),
                                    border: Border.all(
                                        color: AppColors.grey)),
                                child: Text(
                                  '${_weeklyDate[index].day} ${DateFormat('MMMM').format(_weeklyDate[index]).substring(0, 3)}\n${DateFormat('EEEE').format(_weeklyDate[index]).substring(0, 3)}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                      color: _selectedDate.day ==
                                          _weeklyDate[index]
                                              .day
                                          ? AppColors.whitePurple
                                          : AppColors
                                          .primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppSize.getWidth(
                                          context) *
                                          14 /
                                          360),
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                            const SizedBox(
                              width: 10,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            height: AppSize.getHeight(context) / 3.25,
                            child: GridView.builder(
                              padding: const EdgeInsets.all(0),
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 7,
                                childAspectRatio: 8 / 4,
                                crossAxisCount: 4,
                              ),
                              itemBuilder: (context, index) {
                                List<FieldSchedule> fsToday =
                                _filteredFieldSchedules
                                    .where((schedule) {
                                  DateTime scheduleDate =
                                  schedule.schedule!.date!;

                                  return scheduleDate.day ==
                                      _selectedDate.day;
                                }).toList();

                                final List<FieldSchedule> sortedFs =
                                List.from(fsToday)
                                  ..sort((a, b) {
                                    final aStartHour = int.parse(a
                                        .schedule!.timeSlot!
                                        .substring(0, 2));
                                    final bStartHour = int.parse(b
                                        .schedule!.timeSlot!
                                        .substring(0, 2));

                                    return aStartHour
                                        .compareTo(bStartHour);
                                  });

                                if (!sortedFs.isNotEmpty && !(index < sortedFs.length)) {
                                  print('Error: The list is empty or index is out of range');
                                  return Container();
                                }

                                final selectedFs = sortedFs[index];

                                bool isAvailable =
                                    selectedFs.status == 'Available';

                                return InkWell(
                                  onTap: isAvailable
                                      ? () {
                                    setState(() {
                                      FieldSchedule updateToNotAvailFS = FieldSchedule(id: selectedFs.id, status: 'Not Available', schedule: selectedFs.schedule, fieldId: selectedFs.fieldId, scheduleId: selectedFs.scheduleId);
                                      if (_updatedFieldSchedules.any((fs) => fs.id == updateToNotAvailFS.id)) {
                                        FieldSchedule existingUpdatedFs = _updatedFieldSchedules.firstWhere((fs) => fs.id == updateToNotAvailFS.id);
                                        _updatedFieldSchedules.remove(existingUpdatedFs);
                                      }
                                      _updatedFieldSchedules.add(updateToNotAvailFS);

                                      FieldSchedule existingFilteredFs = _filteredFieldSchedules.firstWhere((fs) => fs.id == updateToNotAvailFS.id);
                                      _filteredFieldSchedules.remove(existingFilteredFs);
                                      _filteredFieldSchedules.add(updateToNotAvailFS);

                                      print('update: $_updatedFieldSchedules');
                                    });
                                  }
                                      : () {
                                    setState(() {
                                      FieldSchedule updateToAvailFS = FieldSchedule(id: selectedFs.id, status: 'Available', schedule: selectedFs.schedule, fieldId: selectedFs.fieldId, scheduleId: selectedFs.scheduleId);
                                      if (_updatedFieldSchedules.any((fs) => fs.id == updateToAvailFS.id)) {
                                        FieldSchedule existingUpdatedFs = _updatedFieldSchedules.firstWhere((fs) => fs.id == updateToAvailFS.id);
                                        _updatedFieldSchedules.remove(existingUpdatedFs);
                                      }
                                      _updatedFieldSchedules.add(updateToAvailFS);

                                      FieldSchedule existingFilteredFs = _filteredFieldSchedules.firstWhere((fs) => fs.id == updateToAvailFS.id);
                                      _filteredFieldSchedules.remove(existingFilteredFs);
                                      _filteredFieldSchedules.add(updateToAvailFS);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: !isAvailable
                                          ? AppColors.grey
                                          .withOpacity(0.7)
                                          : _selectedTimeSlot ==
                                          selectedFs.schedule!
                                              .timeSlot
                                          ? AppColors.primaryColor
                                          : Colors.transparent,
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      border: Border.all(
                                        color: isAvailable
                                            ? AppColors.primaryColor
                                            : AppColors.grey
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        selectedFs.schedule!.timeSlot!
                                            .substring(0, 6),
                                        style: TextStyle(
                                          color: _selectedTimeSlot ==
                                              selectedFs.schedule!
                                                  .timeSlot
                                              ? AppColors
                                              .whitePurple // Change text color when selected
                                              : isAvailable
                                              ? AppColors
                                              .primaryColor
                                              : AppColors
                                              .whitePurple, // Text color based on availability
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: 18,
                            )),
                      ],
                    )),
              ),
            ]),
          )),
    );
  }

  void _submit(BuildContext context) async {
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

    final result = await _fieldService.update(user, widget.venue, widget.field,
        _enteredType, _enteredPrice, _newPhotos, _removedImages, _updatedFieldSchedules);

    setState(() {
      _isSubmit = false;
    });

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Update Field Successfully')),
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
        _newPhotos.add(File(pickedFile.path));
      }
    });
  }

  Future _getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _enteredPhotos.add(File(pickedFile.path));
        _newPhotos.add(File(pickedFile.path));
      }
    });
  }

  void _removeImage(int index) {
    setState(() {
      _removedImages.add(widget.field.gallery![index].photoUrl!);
      print('GID: ${widget.field.gallery![index].id}');
      _enteredPhotos.removeAt(index);
    });
  }

  Future<void> _showOptions(BuildContext context) async {
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

  Future<File?> downloadImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(
          'http://${dotenv.env["HOST"]}:${dotenv.env["PORT"]}$imageUrl'));

      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = join(
            directory.path, '${DateTime.now().millisecondsSinceEpoch}.jpg');

        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        print("Image saved at: $filePath");
        return file;
      } else {
        print("Failed to load image: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error downloading image: $e");
      return null;
    }
  }

  List<DateTime> _generateWeeklyDate() {
    var today = DateTime.now();
    var weekday = today.weekday;
    var startOfWeek = today.subtract(Duration(days: weekday - 1));

    List<DateTime> weekDates =
    List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    return weekDates;
  }

  void _loadField() async {
    final result = await _fieldService.loadField(widget.user, widget.field.id!);

    if (result['success'] == true) {
      setState(() {
        field = Field.fromJson(result['data']);

        final startDate = _weeklyDate[0];
        final endDate = _weeklyDate[6];

        _filteredFieldSchedules = field.fieldSchedules!.where((schedule) {
          DateTime scheduleDate = schedule.schedule!.date!;
          return scheduleDate
              .isAfter(startDate.subtract(const Duration(days: 1))) &&
              scheduleDate.isBefore(endDate.add(const Duration(days: 1)));
        }).toList();
      });
    } else {
      final errorMessage = result['error'] is String
          ? result['error']
          : (result['error'] as List).join('\n');

      ScaffoldMessenger.of(context as BuildContext).clearSnackBars();
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }

    setState(() {
      _isLoad = false;
    });
  }
}
