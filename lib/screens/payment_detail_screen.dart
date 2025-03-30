import 'package:fitspace_sports_venue_booking_mobile/screens/payment_confirmation_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentDetailScreen extends StatefulWidget {
  const PaymentDetailScreen({super.key});

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

  final List<Map<String, String>> _banks = [
    {"name": "Bank BCA", "image": "assets/images/payment/va.png"},
    {"name": "Bank Mandiri", "image": "assets/images/payment/va.png"},
    {"name": "Bank BNI", "image": "assets/images/payment/va.png"},
    {"name": "Bank BRI", "image": "assets/images/payment/va.png"},
    {"name": "Bank CIMB Niaga", "image": "assets/images/payment/va.png"},
    {"name": "Bank Danamon", "image": "assets/images/payment/va.png"},
    {"name": "Bank Permata", "image": "assets/images/payment/va.png"},
    {"name": "Bank Maybank Indonesia", "image": "assets/images/payment/va.png"},
    {"name": "Bank OCBC NISP", "image": "assets/images/payment/va.png"},
  ];

  void _onSubmit() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    if (_enteredPaymentMethod == "bank") {
      if (_enteredBank.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please choose your virtual account")));
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
      "Cvv": _enteredCvv
    };

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentConfirmationScreen(detail: paymentDetail,),));
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
                    "Rp 30.000",
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
                      Image.asset(
                        "assets/images/dummy/pool_dummy.png",
                        height: 70,
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
                                "Oasis Siliwangi",
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
                                    "Bandung" + " | " + "Swimming Pool",
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
                                    "17 Aug" + ", " + "14.00 - 15.00",
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
                        leading: Image.asset("assets/images/payment/qrish.png"),
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
                        leading: Image.asset("assets/images/payment/va.png"),
                        title: Text(
                          "Virtual Account",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle:
                            _enteredBank.trim().isNotEmpty ? Text(_enteredBank) : null,
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
                                leading: Image.asset(bank["image"]!),
                                title: Text(bank["name"]!),
                                trailing: _enteredBank == bank["name"] && _enteredPaymentMethod == "bank"
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
                            Image.asset("assets/images/payment/credit.png"),
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
