import 'dart:math';

import 'package:fitspace_sports_venue_booking_mobile/screens/payment_success_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/booking_service.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/field_model.dart';
import '../models/user_model.dart';
import '../models/venue_model.dart';

class PaymentConfirmationScreen extends StatefulWidget {
  const PaymentConfirmationScreen(
      {super.key,
      required this.detail,
      required this.user,
      required this.venue,
      required this.field,
      required this.timeSlot,
      required this.date});

  final Map<String, String> detail;
  final User user;
  final Venue venue;
  final Field field;
  final String timeSlot;
  final DateTime date;

  @override
  State<PaymentConfirmationScreen> createState() =>
      _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  final _bookingService = BookingService();

  var _isSubmit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.base,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Payment Detail",
          style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.darkGrey)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.base,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 3,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: Image.network(
                          'http://192.168.18.11:8080${widget.field.gallery![0].photoUrl != null ? widget.field.gallery![0].photoUrl! : ''}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                widget.venue.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.darkGrey),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: AppColors.darkGrey.withOpacity(0.7),
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${widget.venue.cityOrRegency!} | ${widget.field.type!}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            color: AppColors.darkGrey
                                                .withOpacity(0.7)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_outlined,
                                    color: AppColors.darkGrey.withOpacity(0.7),
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${widget.date.day} ${DateFormat('MMMM').format(widget.date).substring(0, 3)}, ${widget.timeSlot}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            color: AppColors.darkGrey
                                                .withOpacity(0.7)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              paymentDetailWidget(
                  context, widget.detail['PaymentMethod']!, widget.detail),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                      'Rp ${NumberFormat('#,###', 'id_ID').format(widget.field.price!)}',
                      style: Theme.of(context).textTheme.bodyMedium)
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Service Fee",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                      "Rp ${NumberFormat('#,###', 'id_ID').format(widget.field.price! * 0.01)}",
                      style: Theme.of(context).textTheme.bodyMedium)
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Application Fee",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                      "Rp ${NumberFormat('#,###', 'id_ID').format(widget.field.price! * 0.02)}",
                      style: Theme.of(context).textTheme.bodyMedium)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Rp ${NumberFormat('#,###', 'id_ID').format(widget.field.price! + widget.field.price! * 0.01 + widget.field.price! * 0.02)}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 90,
        padding: const EdgeInsets.all(0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.base, boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 3,
              offset: const Offset(0, -4),
            ),
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: const Color(0xFF1B1F26).withOpacity(0.72),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Rp ${NumberFormat('#,###', 'id_ID').format(widget.field.price! + widget.field.price! * 0.01 + widget.field.price! * 0.02)}",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.darkGrey, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: _onSubmit,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      backgroundColor: AppColors.darkerPrimaryColor),
                  child: _isSubmit
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          "Pay",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.base),
                        ))
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() async {
    setState(() {
      _isSubmit = true;
    });

    final result = await _bookingService.create(
        widget.user, widget.venue, widget.field, widget.date, widget.timeSlot);

    if (result['success'] == true) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PaymentSuccessScreen(
          user: widget.user,
          venue: widget.venue,
        ),
      ));
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
      _isSubmit = false;
    });
  }
}

String generateVirtualAccount() {
  final random = Random();
  int randomNumber = 10000000000 + random.nextInt(999999999);
  return randomNumber.toString();
}

Widget paymentDetailWidget(BuildContext context, String paymentMethod,
    Map<String, String> paymentDetail) {
  switch (paymentMethod) {
    case "qr":
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "QR Code Payment",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child:
                Image.asset("assets/images/payments/dummy_qr.jpg", height: 150),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Scan this QR Code to make your payment.",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColors.darkGrey),
            ),
          ),
        ],
      );
    case "bank":
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Virtual Account ${paymentDetail["Bank"]?.substring(5)}",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              generateVirtualAccount(),
              style: Theme.of(context).textTheme.titleMedium!,
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Please transfer the amount to the above account.",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColors.darkGrey),
            ),
          ),
        ],
      );
    case "credit":
    default:
      String creditCardNumber = paymentDetail["CreditNumber"] ?? "";
      String lastFourDigits = creditCardNumber.length >= 4
          ? creditCardNumber.substring(creditCardNumber.length - 4)
          : "****";

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Credit Card Payment",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Card Number: **** **** **** $lastFourDigits",
              style: Theme.of(context).textTheme.titleMedium!,
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Expiry Date: ${paymentDetail["ExpDate"]}",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColors.darkGrey),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Your payment will be processed using your credit card.",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColors.darkGrey),
            ),
          ),
        ],
      );
  }
}
