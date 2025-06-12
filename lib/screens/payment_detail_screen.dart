import 'package:fitspace_sports_venue_booking_mobile/screens/payment_confirmation_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/field_model.dart';
import '../models/user_model.dart';
import '../models/venue_model.dart';

class PaymentDetailScreen extends StatefulWidget {
  const PaymentDetailScreen(
      {super.key,
      required this.user,
      required this.venue,
      required this.field,
      required this.date,
      required this.timeSlot});

  final User user;
  final Venue venue;
  final Field field;
  final DateTime date;
  final String timeSlot;

  @override
  State<PaymentDetailScreen> createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formCreditKey = GlobalKey<FormState>();

  String _enteredName = "";
  String _enteredEmail = "";
  String _enteredPhoneNumber = "";
  String _enteredNotes = "";
  String _enteredPaymentMethod = "";
  String _enteredBank = "";
  String _enteredCreditNumber = "";
  String _enteredExpDate = "";
  String _enteredCvv = "";

  int? _selectedTile;

  final List<Map<String, String>> test = [
    {"name": "Bank BCA", "image": "assets/images/payments/va.png"},
    {"name": "Bank Mandiri", "image": "assets/images/payments/va.png"},
    {"name": "Bank BNI", "image": "assets/images/payments/va.png"},
    {"name": "Bank BRI", "image": "assets/images/payments/va.png"},
    {"name": "Bank CIMB Niaga", "image": "assets/images/payments/va.png"},
    {"name": "Bank Danamon", "image": "assets/images/payments/va.png"},
    {"name": "Bank Permata", "image": "assets/images/payments/va.png"},
    {
      "name": "Bank Maybank Indonesia",
      "image": "assets/images/payments/va.png"
    },
    {"name": "Bank OCBC NISP", "image": "assets/images/payments/va.png"},
  ];

  final List<Map<String, String>> _banks = [
    {
      "name": "Bank BCA",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Bank_Central_Asia.svg/1200px-Bank_Central_Asia.svg.png"
    },
    {
      "name": "Bank Mandiri",
      "image":
          "https://www.bankmandiri.co.id/image/layout_set_logo?img_id=31567&t=1732986257988"
    },
    {
      "name": "Bank BNI",
      "image": "https://cdn.prod.website-files.com/64199d190fc7afa82666d89c/6491bee525769f3d615b7ac3_bni_bank.webp"
    },
    {
      "name": "Bank BRI",
      "image": "https://bri.co.id/o/bri-corporate-theme/images/bri-logo.png"
    },
    {"name": "Bank BSI", "image": "https://www.bankbsi.co.id/img/logo.png"},
  ];

  void _onSubmit() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    if (_enteredPaymentMethod == "bank") {
      if (_enteredBank.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please choose your virtual account")));
        return;
      }
    }

    if (_enteredPaymentMethod == "credit") {
      final isValid2 = _formCreditKey.currentState!.validate();

      if (!isValid2) {
        return;
      }

      _formCreditKey.currentState!.save();
    }

    final Map<String, String> paymentDetail = {
      "Name": _enteredName,
      "Email": _enteredEmail,
      "PhoneNumber": _enteredPhoneNumber,
      "Notes": _enteredNotes,
      "PaymentMethod": _enteredPaymentMethod,
      "Bank": _enteredBank,
      "CreditNumber": _enteredCreditNumber,
      "ExpDate": _enteredExpDate,
      "Cvv": _enteredCvv,
    };

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PaymentConfirmationScreen(
        detail: paymentDetail,
        user: widget.user,
        venue: widget.venue,
        field: widget.field,
        date: widget.date,
        timeSlot: widget.timeSlot,
      ),
    ));
  }

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
                    "Rp ${NumberFormat('#,###', 'id_ID').format(widget.field.price!)}",
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
                  child: Text(
                    "Pay",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: AppColors.base),
                  ))
            ],
          ),
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
                height: 20,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Full Name',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.darkGrey),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          decoration: InputDecoration(
                              labelText: 'Enter your full name',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w100,
                                      color: AppColors.lightGrey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              filled: true,
                              fillColor: AppColors.whitePurple,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 15)),
                          validator: (name) {
                            if (name == null ||
                                name.trim().isEmpty ||
                                name.length < 3) {
                              return "Please enter a valid name";
                            }
                            return null;
                          },
                          onSaved: (name) {
                            _enteredName = name!;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkGrey),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          decoration: InputDecoration(
                              labelText: 'Enter your email',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w100,
                                      color: AppColors.lightGrey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              filled: true,
                              fillColor: AppColors.whitePurple,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 15)),
                          validator: (email) {
                            if (email == null || email.trim().isEmpty) {
                              return "Please enter your email";
                            }

                            final RegExp emailRegex = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                            if (!emailRegex.hasMatch(email)) {
                              "Please enter a valid email";
                            }

                            return null;
                          },
                          onSaved: (email) {
                            _enteredEmail = email!;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Phone Number',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkGrey),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: 'Enter your phone number',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w100,
                                    color: AppColors.lightGrey,
                                  ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              filled: true,
                              fillColor: AppColors.whitePurple,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 15),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter your phone number";
                              }

                              final phoneRegExp = RegExp(r'^\+?[0-9]{10,15}$');
                              if (!phoneRegExp.hasMatch(value)) {
                                return "Please enter a valid phone number";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPhoneNumber = value!;
                            },
                          )),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Notes',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkGrey),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: 'Enter your notes',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w100,
                                    color: AppColors.lightGrey,
                                  ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              filled: true,
                              fillColor: AppColors.whitePurple,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 15),
                            ),
                            onSaved: (value) {
                              _enteredNotes = value!;
                            },
                          )),
                      const SizedBox(height: 15),
                      const Divider(),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Payment Method",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 5),
                      ExpansionTile(
                        onExpansionChanged: (expanded) {
                          setState(() {
                            _selectedTile = 0;
                            _enteredPaymentMethod = "qr";
                          });
                        },
                        tilePadding: const EdgeInsets.all(0),
                        shape: const Border(),
                        leading:
                            Image.asset("assets/images/payments/qrish.png"),
                        title: Text(
                          "QR Code",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.radio_button_checked,
                          color: _selectedTile == 0
                              ? Colors.blue
                              : AppColors.darkGrey.withOpacity(0.6),
                        ),
                        children: const [], // Empty children to disable expansion
                      ),
                      ExpansionTile(
                        tilePadding: const EdgeInsets.all(0),
                        shape: const Border(),
                        leading: Image.asset("assets/images/payments/va.png"),
                        title: Text(
                          "Virtual Account",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: _enteredBank.trim().isNotEmpty
                            ? Text(_enteredBank)
                            : null,
                        trailing: Icon(
                          Icons.radio_button_checked,
                          color: _selectedTile == 1
                              ? Colors.blue
                              : AppColors.darkGrey.withOpacity(0.6),
                        ),
                        onExpansionChanged: (expanded) {
                          setState(() {
                            _selectedTile = 1;
                            _enteredPaymentMethod = "bank";
                          });
                        },
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _banks.length,
                            itemBuilder: (context, index) {
                              final bank = _banks[index];
                              return ListTile(
                                leading: Container(
                                  width: AppSize.getWidth(context) * 28 / 360,
                                  height: AppSize.getWidth(context) * 28 / 360,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.whitePurple
                                  ),
                                  child: Image.network(bank["image"]!, fit: BoxFit.contain,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                        ),
                                      );
                                    }
                                  }),
                                ),
                                title: Text(bank["name"]!),
                                trailing: _enteredBank == bank["name"] &&
                                        _enteredPaymentMethod == "bank"
                                    ? const Icon(Icons.check,
                                        color: Colors.blue)
                                    : null,
                                onTap: () {
                                  setState(() {
                                    _enteredBank = bank["name"]!;
                                    _selectedTile =
                                        1; // Set this to 1 to change the Virtual Account radio to blue
                                  });
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      ExpansionTile(
                        shape: const Border(),
                        tilePadding: const EdgeInsets.all(0),
                        leading:
                            Image.asset("assets/images/payments/credit.png"),
                        title: Text(
                          "Credit Card",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.radio_button_checked,
                          color: _selectedTile == 2
                              ? Colors.blue
                              : AppColors.darkGrey.withOpacity(0.6),
                        ),
                        onExpansionChanged: (expanded) {
                          setState(() {
                            _selectedTile = 2;
                            _enteredPaymentMethod = "credit";
                          });
                        },
                        children: [
                          Form(
                            key: _formCreditKey,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Credit Card Number",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: "Enter your credit card number",
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter your credit card number";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        _enteredCreditNumber = value!;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  Text("Expiration Date",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: "MM/YY",
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter expiration date";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        _enteredExpDate = value!;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  Text("CVV",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: "Enter CVV",
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter CVV";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        _enteredCvv = value!;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: true,
                                          onChanged: (bool? value) {}),
                                      const Text(
                                          "Save this card for future use")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
