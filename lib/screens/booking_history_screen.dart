import 'package:fitspace_sports_venue_booking_mobile/models/user_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/booking_service.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

import '../models/booking_model.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key, required this.user});

  final User user;

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  final _bookingService = BookingService();
  List<Booking> _orders = [];

  @override
  void initState() {
    _getOrders();
    super.initState();
  }

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
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
          return BookingCard(order: order, onCancelled: () {
            _cancelOrder(order);
          },);
        },
      ),
    );
  }

  void _getOrders() async {
    final result = await _bookingService.get(widget.user);

    if (result['success'] == true) {
      final data = result['data'];
      setState(() {
        _orders = List<Booking>.from(data.map((e) => Booking.fromJson(e)));
      });

      for (var order in _orders) {
        print(order);
      }
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

  void _cancelOrder(Booking order) async {
    final result = await _bookingService.cancel(widget.user, order.id!);

    if (result['success'] == true) {
      _getOrders();
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
}

class BookingCard extends StatelessWidget {
  final Booking order;
  final void Function() onCancelled;

  const BookingCard({
    super.key,
    required this.order, required this.onCancelled,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    Color textColor;
    switch (order.status!.toLowerCase()) {
      case 'finished':
        statusColor = AppColors.green;
        textColor = AppColors.darkGreen;
        break;
      case 'ongoing':
        statusColor = AppColors.yellow;
        textColor = AppColors.darkYellow;
        break;
      case 'canceled':
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${order.status!.substring(0, 1).toUpperCase()}${order.status!.substring(1, order.status!.length).toLowerCase()}',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  'Rp ${NumberFormat('#,###', 'id_ID').format(order.field!.price!)}',
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'http://${dotenv.env["HOST"]}:${dotenv.env["PORT"]}${order.field!.gallery![0].photoUrl != null ? order.field!.gallery![0].photoUrl! : ''}',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.field!.venue!.name!,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkGrey),
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
                            '${order.field!.venue!.cityOrRegency!} | ${order.field!.type!}',
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
                            '${order.schedule!.date!.day} ${DateFormat('MMMM').format(order.schedule!.date!).substring(0, 3)}, ${order.schedule!.timeSlot!}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.darkGrey,
                            ),
                          ),
                        ],
                      ),
                      order.status! == 'ongoing'
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))
                              ),
                              onPressed: onCancelled,
                              child: Text(
                                'Cancel Order',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color: AppColors.whitePurple,
                                      fontSize:
                                          AppSize.getWidth(context) * 14 / 360,
                                    ),
                              ))
                          : Container()
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
