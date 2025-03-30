import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';

class MyBookingPage extends StatefulWidget {
  const MyBookingPage({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  _MyBookingPageState createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: widget.width ?? MediaQuery.of(context).size.width,
          height: widget.height ?? MediaQuery.of(context).size.height,
          child: BookingCalendar(
            bookedSlotColor: AppColors.yellowPrimaryColor,
            bookingService: mockBookingService,
            convertStreamResultToDateTimeRanges: convertStreamResultMock,
            getBookingStream: getBookingStreamMock,
            uploadBooking: uploadBookingMock,
            hideBreakTime: true,
            loadingWidget: const Text('Fetching data...'),
            uploadingWidget: const Center(child: CircularProgressIndicator()),
            locale: 'en_US',
            startingDayOfWeek: StartingDayOfWeek.monday,
            // Changed to Monday
            wholeDayIsBookedWidget:
                const Text('Sorry, this day is fully booked'),

          ),
        ),
      ),
    );
  }

  final now = DateTime.now();
  late BookingService mockBookingService;
  late List<DateTimeRange> converted;

  @override
  void initState() {
    super.initState();
    mockBookingService = BookingService(
      serviceName: 'Venue Booking',
      serviceDuration: 60,
      bookingStart: DateTime(now.year, now.month, now.day, 6, 0),  // Start at 6:00 AM today
      bookingEnd: DateTime(now.year, now.month, now.day, 23, 0),  // End at 11:59 PM today
    );

    converted = [
      DateTimeRange(
        start: DateTime(now.year, now.month, now.day, 6, 0),
        end: DateTime(now.year, now.month, now.day, 7, 0),
      ),
    ];
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value(
        []); // Mock stream, could be replaced with real booking data.
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    print('${newBooking.toJson()} has been uploaded');
  }

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    // This would process the stream result into DateTimeRanges
    print('C: $converted');
    return converted;
  }
}
