import 'package:fitspace_sports_venue_booking_mobile/models/booking_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/field_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/field_schedule_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/review_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/schedule_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/user_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/payment_detail_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/field_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';
import 'package:intl/intl.dart';

import '../models/venue_model.dart';
import '../utils/colors.dart';
import '../utils/size.dart';

class BookScreen extends StatefulWidget {
  const BookScreen(
      {super.key,
      required this.field,
      required this.venue,
      required this.user});

  final User user;
  final Venue venue;
  final Field field;

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final GlobalKey _containerKey = GlobalKey();
  final _fieldService = FieldService();
  var containerHeight = 0.0;
  var totalReview = 0;
  var totalRating = 0.0;
  late Field field;

  List<DateTime> _weeklyDate = [];
  DateTime _selectedDate = DateTime.now();
  String _selectedTimeSlot = '';
  List<FieldSchedule> _filteredFieldSchedules = [];
  bool _isRender = true;
  bool _isLoad = true;
  bool _isSubmit = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _weeklyDate = _generateWeeklyDate();
    _loadField();
  }

  @override
  Widget build(BuildContext context) {
    double topHeight = AppSize.getHeight(context) * 0.3;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox =
          _containerKey.currentContext?.findRenderObject() as RenderBox;
      final size = renderBox.size;
      setState(() {
        containerHeight = size.height;
        _isRender = false;
      });
    });

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          forceMaterialTransparency: true,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 8, bottom: 8),
            child: CircleAvatar(
              backgroundColor: AppColors.whitePurple.withOpacity(0.7),
              child: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: AppColors.darkerPrimaryColor),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0, top: 8, bottom: 8),
              child: CircleAvatar(
                backgroundColor: AppColors.whitePurple.withOpacity(0.7),
                child: IconButton(
                  icon: const Icon(Icons.share,
                      color: AppColors.darkerPrimaryColor),
                  onPressed: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0, top: 8, bottom: 8),
              child: CircleAvatar(
                backgroundColor: AppColors.whitePurple.withOpacity(0.7),
                child: IconButton(
                  icon: const Icon(Icons.favorite_border,
                      color: AppColors.darkerPrimaryColor),
                  onPressed: () {},
                ),
              ),
            ),
          ],
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
                        "Book Now",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.base),
                      )),
          ),
        ),
        body: _isLoad
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      height: topHeight + containerHeight,
                    ),
                    Positioned(
                      child: Container(
                        height: AppSize.getHeight(context) * 0.4,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'http://192.168.18.11:8080${widget.field.gallery![0].photoUrl != null ? field.gallery![0].photoUrl! : ''}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: topHeight,
                      child: Container(
                        key: _containerKey,
                        width: AppSize.getWidth(context),
                        decoration: const BoxDecoration(
                            color: AppColors.whitePurple,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: _isRender
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 36,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: AppColors.grey,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.venue.name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontSize: AppSize.getWidth(context) *
                                              22 /
                                              360,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.field.type!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                          color: AppColors.darkGrey
                                              .withOpacity(0.75),
                                          fontSize: AppSize.getWidth(context) *
                                              14 /
                                              360,
                                        ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        totalRating.toStringAsFixed(1),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                color: const Color(0xFFFFCC00),
                                                fontSize:
                                                    AppSize.getWidth(context) *
                                                        22 /
                                                        360,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      FlutterRating(
                                        color: const Color(0xFFFFCC00),
                                        rating: totalRating,
                                        starCount: 5,
                                        allowHalfRating: true,
                                        borderColor: const Color(0xFFFFCC00),
                                        size: AppSize.getWidth(context) * 0.05,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    totalReview > 1
                                        ? '$totalReview Reviews'
                                        : '$totalReview Review',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                            color: AppColors.darkGrey
                                                .withOpacity(0.75),
                                            fontSize:
                                                AppSize.getWidth(context) *
                                                    11 /
                                                    360),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Schedule',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontSize: AppSize.getWidth(context) *
                                              22 /
                                              360,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
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

                                          print("TODAY: $fsToday");

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
                                                      _selectedTimeSlot =
                                                          selectedFs.schedule!
                                                              .timeSlot!;
                                                    });
                                                  }
                                                : null, // Disable onTap if not available
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
                                  _isError
                                      ? Text(
                                          'Please choose the schedule!',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                  color:
                                                      Colors.red.withRed(255),
                                                  fontSize: AppSize.getWidth(
                                                          context) *
                                                      14 /
                                                      360),
                                        )
                                      : const SizedBox()
                                ],
                              ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Colors.blue[800],
            fontSize: AppSize.getWidth(context) * 12 / 360),
      ),
    );
  }

  Widget fieldTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
          color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
      child:
          Text(text, style: TextStyle(color: Colors.blue[800], fontSize: 12)),
    );
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
        if (field.review != null && field.review!.isNotEmpty) {
          totalReview = field.review!.length;
          totalRating = field.review!
                  .map((review) => review.rating)
                  .where((rating) => rating != null)
                  .reduce((value, element) => value! + element!)! /
              totalReview;
        } else {
          totalReview = 0;
          totalRating = 0.0; // Default value if no reviews
        }

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

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }

    setState(() {
      _isLoad = false;
    });
  }

  void _submit() {
    setState(() {
      _isSubmit = true;
    });

    if (_selectedTimeSlot == '') {
      setState(() {
        _isError = true;
        _isSubmit = false;
      });
      return;
    }

    final validFs = _filteredFieldSchedules.firstWhere(
      (fs) =>
          fs.schedule!.date!.day == _selectedDate.day &&
          fs.schedule!.date!.month == _selectedDate.month &&
          fs.schedule!.date!.year == _selectedDate.year,
    );

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PaymentDetailScreen(
        field: widget.field,
        user: widget.user,
        venue: widget.venue,
        timeSlot: _selectedTimeSlot,
        date: validFs.schedule!.date!,
      ),
    ));

    setState(() {
      _isSubmit = false;
    });
  }
}
