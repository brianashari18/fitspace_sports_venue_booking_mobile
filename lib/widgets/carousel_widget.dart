import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final List<String> imagePaths = [
  'assets/images/login1.png',
  'assets/images/login2.png',
  'assets/images/success.png',
];

final List<String> titles = [
  'Book Your Favorite \nVenue in Seconds!',
  'Multiple Payment \nOptions, Fully Secure',
  'Play More, Worry Less',
];

final List<String> descriptions = [
  'Find and reserve best courts and fields \nanytime, anywhere',
  'Choose your preferred payment method \nwith complete security and peace of \nmind.',
  'Enjoy a smooth booking experience and make every game count. Book now!',
];

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _activeIndicator = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            items: imagePaths
                .map((e) => Center(
              child: Image.asset(e),
            ))
                .toList(),
            options: CarouselOptions(
                initialPage: 0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                height: 300,
                enlargeCenterPage: true,
                viewportFraction: 1.0,
                onPageChanged: (value, _) {
                  setState(() {
                    _activeIndicator = value;
                  });
                }),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGrey,
                ),
              ),
              children: _buildTextWithHighlight(_activeIndicator),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            descriptions[_activeIndicator],
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGrey,
                )),
          ),
          const SizedBox(height: 90),
          buildCarouselIndicator(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }


  List<TextSpan> _buildTextWithHighlight(int index) {
    String title = titles[index];

    List<TextSpan> result = [];

    if (index == 0) {
      // Highlighting "Book" and "in Seconds"
      String before = '';
      String highlighted = 'Book';
      String after = 'in Seconds';
      String remaining = title.split(after)[1];

      result.add(TextSpan(text: before));
      result.add(TextSpan(text: highlighted, style: TextStyle(color: Colors.blue)));
      result.add(TextSpan(text: title.split(after)[0].substring(highlighted.length)));
      result.add(TextSpan(text: after, style: TextStyle(color: Colors.blue)));
      result.add(TextSpan(text: remaining));
    } else if (index == 1) {
      // Highlighting "Fully Secure"
      String before = '';
      String highlighted = 'Fully Secure';
      String remaining = title.split(highlighted)[1];

      result.add(TextSpan(text: before));
      result.add(TextSpan(text: highlighted, style: TextStyle(color: Colors.blue)));
      result.add(TextSpan(text: remaining));
    } else if (index == 2) {
      // Highlighting "Play More"
      String before = '';
      String highlighted = 'Play More';
      String remaining = title.split(highlighted)[1];

      result.add(TextSpan(text: before));
      result.add(TextSpan(text: highlighted, style: TextStyle(color: Colors.blue)));
      result.add(TextSpan(text: remaining));
    }

    return result;
  }



  buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < imagePaths.length; i++)
          Container(
            height: 6,
            width: 15,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: i == _activeIndicator
                    ? AppColors.darkerPrimaryColor
                    : AppColors.darkerPrimaryColor.withOpacity(0.5),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4)),
          )
      ],
    );
  }
}
