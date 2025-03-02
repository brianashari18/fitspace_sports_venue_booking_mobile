import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final List<String> imagePaths = [
  'assets/images/login1.png',
  'assets/images/login2.png',
  'assets/images/login1.png',
];

final List<String> titles = [
  'Easy Booking & \nSecure Payment',
  'Real Time \nSchedule Availibility',
  'Many People \nUse This',
];

final List<String> descriptions = [
  'Reserve, pay securely, and enjoy your \ngame without any worries!',
  'Reserve, pay securely, and enjoy your \ngame without any worries!',
  'Reserve, pay securely, and enjoy your \ngame without any worries!',
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
                height: 250,
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
    String before = '';
    String highlighted = '';
    String after = '';

    if (index == 0) {
      // Highlighting "Booking" and "Secure"
      before = title.split('Booking')[0];
      highlighted = 'Booking';
      after = title.split('Booking')[1];
      result.add(TextSpan(text: before));
      result.add(TextSpan(text: highlighted, style: TextStyle(color: Colors.blue)));
      result.add(TextSpan(text: after.split('Secure')[0]));
      result.add(TextSpan(text: 'Secure', style: TextStyle(color: Colors.blue)));
      result.add(TextSpan(text: after.split('Secure')[1]));
    } else if (index == 1) {
      // Highlighting "Time" and "Availibility"
      before = title.split('Time')[0];
      highlighted = 'Time';
      after = title.split('Time')[1];
      result.add(TextSpan(text: before));
      result.add(TextSpan(text: highlighted, style: TextStyle(color: Colors.blue)));
      result.add(TextSpan(text: after.split('Availibility')[0]));
      result.add(TextSpan(text: 'Availibility', style: TextStyle(color: Colors.blue)));
      result.add(TextSpan(text: after.split('Availibility')[1]));
    } else if (index == 2) {
      // Highlighting "People"
      before = title.split('People')[0];
      highlighted = 'People';
      after = title.split('People')[1];
      result.add(TextSpan(text: before));
      result.add(TextSpan(text: highlighted, style: TextStyle(color: Colors.blue)));
      result.add(TextSpan(text: after));
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
