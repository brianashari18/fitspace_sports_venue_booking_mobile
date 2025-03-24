import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  final List<Map<String, String>> bookingData = [
    {
      'status': 'Completed',
      'venueName': 'Oasis Siliwangi',
      'location': 'Bandung',
      'field': 'Swimming Pool',
      'date': '17 Aug',
      'time': '14.00-15.00',
      'price': 'Rp 31.500',
      'image': 'assets/images/venue_dummy.png',
    },
    {
      'status': 'Waiting for Payment',
      'venueName': 'Oasis Siliwangi',
      'location': 'Bandung',
      'field': 'Swimming Pool',
      'date': '17 Aug',
      'time': '14.00-15.00',
      'price': 'Rp 31.500',
      'image': 'assets/images/venue_dummy.png',
    },
    {
      'status': 'Canceled',
      'venueName': 'Oasis Siliwangi',
      'location': 'Bandung',
      'field': 'Swimming Pool',
      'date': '17 Aug',
      'time': '14.00-15.00',
      'price': 'Rp 31.500',
      'image': 'assets/images/venue_dummy.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitePurple,
      appBar: AppBar(
        backgroundColor: AppColors.baseColor,
        automaticallyImplyLeading: false,
        title: const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 25, left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Booking History',
                style: TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: bookingData.length,
        itemBuilder: (context, index) {
          return BookingCard(
            status: bookingData[index]['status']!,
            venueName: bookingData[index]['venueName']!,
            location: bookingData[index]['location']!,
            field: bookingData[index]['field']!,
            date: bookingData[index]['date']!,
            time: bookingData[index]['time']!,
            price: bookingData[index]['price']!,
            image: bookingData[index]['image']!,
          );
        },
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final String status;
  final String venueName;
  final String location;
  final String field;
  final String date;
  final String time;
  final String price;
  final String image;

  const BookingCard({
    super.key,
    required this.status,
    required this.venueName,
    required this.location,
    required this.field,
    required this.date,
    required this.time,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    Color textColor;
    switch (status) {
      case 'Completed':
        statusColor = AppColors.green;
        textColor = AppColors.darkGreen;
        break;
      case 'Waiting for Payment':
        statusColor = AppColors.yellow;
        textColor = AppColors.darkYellow;
        break;
      case 'Canceled':
        statusColor = AppColors.red;
        textColor = AppColors.darkRed;
        break;
      default:
        statusColor = AppColors.grey;
        textColor = AppColors.grey;
        break;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkerPrimaryColor,
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            Row(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        venueName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkGrey
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: AppColors.darkGrey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$location, | ,$field',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.darkGrey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 16,
                            color: AppColors.darkGrey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$date, $time',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.darkGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}