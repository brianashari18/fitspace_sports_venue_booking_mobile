import 'package:fitspace_sports_venue_booking_mobile/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double _currentRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.base,
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            "Write a review",
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
        body: Center(
          child: Container(
            height: AppSize.getHeight(context) * 0.55,
            width: AppSize.getWidth(context) * 0.925,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.125),
                  spreadRadius: 0,
                  blurRadius: 30,
                  offset: Offset(0, 20),
                ),
              ],
            ),
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                Text(
                  "How was the facility?",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: const Color(0xFF1B1F26).withOpacity(0.72),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Form(
                      child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar.builder(
                        initialRating: 3,
                        itemPadding: const EdgeInsets.all(5),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return const Icon(
                                Icons.sentiment_very_dissatisfied,
                                color: Color(0xFFFABF35),
                              );
                            case 1:
                              return const Icon(
                                Icons.sentiment_dissatisfied,
                                color: Color(0xFFFABF35),
                              );
                            case 2:
                              return const Icon(
                                Icons.sentiment_neutral,
                                color: Color(0xFFFABF35),
                              );
                            case 3:
                              return const Icon(
                                Icons.sentiment_satisfied,
                                color: Color(0xFFFABF35),
                              );
                            case 4:
                              return const Icon(
                                Icons.sentiment_very_satisfied,
                                color: Color(0xFFFABF35),
                              );
                            default:
                              return const Text("Error");
                          }
                        },
                        onRatingUpdate: (rating) {
                          setState(() {
                            _currentRating = rating;
                          });
                        },
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          label: const Text(
                              'Would you like to write anything about this?'),
                          labelStyle:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: AppColors.grey,
                                  ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.darkerPrimaryColor),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF6F6F6),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        maxLines: 5,
                      ),

                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text('Add Photo'),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFF6F6F6),
                          foregroundColor: AppColors.grey,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkerPrimaryColor,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Submit Review',
                            style: TextStyle(
                              color: AppColors.whitePurple,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                )
              ],
            ),
          ),
        ));
  }
}
