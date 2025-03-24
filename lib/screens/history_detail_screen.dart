import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';

class HistoryDetailScreen extends StatefulWidget {
  const HistoryDetailScreen({super.key});

  @override
  State<HistoryDetailScreen> createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
  final Map<String, dynamic> bookingData = {
    'status': 'Canceled',
    'venueName': 'Oasis Siliwangi',
    'location': 'Bandung',
    'field': 'Swimming Pool',
    'date': '17 Aug',
    'time': '14.00-15.00',
    'price': 'Rp 31.500',
    'image': 'assets/images/venue_dummy.png',
    'paymentMethod': 'Virtual Account Mandiri',
    'virtualAccount': '96969696969699',
    'basePrice': 'Rp 30.000',
    'serviceFee': 'Rp 500',
    'applicationFee': 'Rp 1.000',
  };

  @override
  Widget build(BuildContext context) {
    String status = bookingData['status'];
    Color statusColor;
    Color textColor;
    double imageHeight = 110;

    switch (status) {
      case 'Completed':
        statusColor = AppColors.green;
        textColor = AppColors.darkGreen;
        imageHeight = 80;
        break;
      case 'Waiting for Payment':
        statusColor = AppColors.yellow;
        textColor = AppColors.darkYellow;
        imageHeight = 110;
        break;
      case 'Canceled':
        statusColor = AppColors.red;
        textColor = AppColors.darkRed;
        imageHeight = 80;
        break;
      default:
        statusColor = AppColors.grey;
        textColor = AppColors.grey;
        imageHeight = 110;
        break;
    }

    return Scaffold(
      backgroundColor: AppColors.whitePurple,
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
                  'History Detail',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.baseColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage(bookingData['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      bookingData['venueName'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: statusColor,
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
                                ],
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
                                    '${bookingData['location']} | ${bookingData['field']}',
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
                                    '${bookingData['date']}, ${bookingData['time']}',
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
                    const SizedBox(height: 16),
                    const Divider(
                        height: 1,
                        color: AppColors.grey
                    ),
                    const SizedBox(height: 16),
                    Text(
                      bookingData['paymentMethod'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      bookingData['virtualAccount'],
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    const Divider(
                        height: 1,
                        color: AppColors.grey
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Price'),
                        Text(bookingData['basePrice']),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Service Fee'),
                        Text(bookingData['serviceFee']),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Application Fee'),
                        Text(bookingData['applicationFee']),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(
                        height: 1,
                        color: AppColors.grey
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          bookingData['price'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}