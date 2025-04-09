import 'package:fitspace_sports_venue_booking_mobile/models/field_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/size.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import '../models/user_model.dart';
import '../models/venue_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/size.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import '../models/user_model.dart';
import '../models/venue_model.dart';

import 'package:fitspace_sports_venue_booking_mobile/services/field_service.dart';

class VenueDetailScreen extends StatefulWidget {
  const VenueDetailScreen({super.key, required this.user, required this.venue});

  final User user;
  final Venue venue;

  final String text =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

  @override
  State<VenueDetailScreen> createState() => VenueDetailScreenState();
}

class VenueDetailScreenState extends State<VenueDetailScreen> {
  final GlobalKey _containerKey = GlobalKey();
  double containerHeight = 0.0;
  String firstHalf = "";
  String secondHalf = "";
  late Venue venue;
  final FieldService _fieldService = FieldService();
  bool flag = true;

  List<Field> fields = [];
  num totalReview = 0;

  @override
  void initState() {
    super.initState();
    venue = widget.venue;
    _loadFields();
    if (widget.text.length > 50) {
      firstHalf = widget.text.substring(0, 148);
      secondHalf = widget.text.substring(148, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    double topHeight = AppSize.getHeight(context) * 0.3;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox =
      _containerKey.currentContext?.findRenderObject() as RenderBox;
      final size = renderBox.size;
      setState(() {
        containerHeight = size.height;
      });
    });

    DateTime createdAtDate = DateTime.parse(widget.venue.owner['createdAt']);
    DateTime currentDate = DateTime.now();
    int daysDifference = currentDate.difference(createdAtDate).inDays;
    String joinTime = "";
    if (daysDifference >= 365) {
      int years = daysDifference ~/ 365;
      joinTime = "Joined $years ${years > 1 ? 'years' : 'year'} ago";
    } else if (daysDifference >= 30) {
      int months = daysDifference ~/ 30;
      joinTime = "Joined $months ${months > 1 ? 'months' : 'month'} ago";
    } else {
      joinTime = "Joined $daysDifference ${daysDifference > 1 ? 'days' : 'day'} ago";
    }

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          forceMaterialTransparency: true,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 8, bottom: 8),
            child: CircleAvatar(
              backgroundColor: AppColors.whitePurple.withOpacity(0.7),
              child: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: AppColors.darkerPrimaryColor),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0, top: 8, bottom: 8),
              child: CircleAvatar(
                backgroundColor: AppColors.whitePurple.withOpacity(0.7),
                child: IconButton(
                  icon: const Icon(Icons.share,
                      color: AppColors.darkerPrimaryColor),
                  onPressed: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0, top: 8, bottom: 8),
              child: CircleAvatar(
                backgroundColor: AppColors.whitePurple.withOpacity(0.7),
                child: IconButton(
                  icon: const Icon(Icons.favorite_border,
                      color: AppColors.darkerPrimaryColor),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: topHeight + containerHeight,
              ),
              Positioned(
                child: Container(
                  height: AppSize.getHeight(context) * 0.4,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/dummy/venue_dummy.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: topHeight,
                child: Container(
                  key: _containerKey,
                  width: AppSize.getWidth(context),
                  decoration: const BoxDecoration(
                      color: AppColors.whitePurple,
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        alignment: Alignment.center,
                        child: Container(
                          width: 36,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: venue.fields.isNotEmpty
                                  ? venue.fields.map((field) {
                                return _buildButton(field['type']);
                              }).toList()
                                  : [SizedBox(height: 25)],
                            ),
                          ),
                           Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 18),
                                SizedBox(width: 4),
                                Text('${widget.venue.rating}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(width: 4),
                                Text( totalReview > 1 ? '($totalReview Reviews)' : '($totalReview Review)',
                                    style: TextStyle(
                                        fontSize: 14, color: AppColors.grey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.venue.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: AppColors.grey,
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  '${widget.venue.street} ${widget.venue.cityOrRegency}',
                                  style: TextStyle(color: AppColors.grey),
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Description',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: flag
                                      ? "$firstHalf  "
                                      : ("$firstHalf$secondHalf   "),
                                ),
                                TextSpan(
                                  text: flag ? " Read More" : " Show Less",
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      setState(() {
                                        flag = !flag;
                                      });
                                    },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Uploader',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.grey,
                                child: Text('FM'),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.venue.owner['firstName']} ${widget.venue.owner['lastName']}',
                                    style: TextStyle(
                                        color: AppColors.darkGrey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    joinTime,
                                    style: TextStyle(color: AppColors.darkGrey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            color: AppColors.grey,
                          ),
                          const Text(
                            'Available Court',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: fields.length,
                            itemBuilder: (context, index) {
                              final field = fields[index];
                              return Column(
                                children: [
                                  _cardCourt(
                                    title: field.type,
                                    price: 'Rp ${field.price}/hr',
                                    imagePaths: const [
                                      'assets/images/dummy/venue_dummy.png'
                                    ],
                                    onBook: () {
                                      print('Booked');
                                    },
                                  ),
                                  const SizedBox(height: 8), // Control the gap between cards
                                ],
                              );
                            },
                          )
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
    );
  }

  Widget _buildButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.blue[800]),
      ),
    );
  }

  Widget fieldTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: TextStyle(color: Colors.blue[800], fontSize: 12)),
    );
  }

  Widget _cardCourt({
    required String title,
    required String price,
    required VoidCallback? onBook,
    required List<String> imagePaths,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imagePaths.isNotEmpty
                ? SizedBox(
              width: double.infinity,
              height: 120,
              child: imagePaths.length == 1
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    imagePaths[0],
                    fit: BoxFit.cover,
                    width: 250,
                  ),
                ],
              )
                  : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.asset(
                      imagePaths[index],
                      fit: BoxFit.cover,
                      width: 250,
                    ),
                  );
                },
              ),
            )
                : Container(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                        color: AppColors.darkerPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 90,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: onBook,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkerPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Book',
                      style: TextStyle(
                        color: AppColors.whitePurple,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadFields() async {
    final result = await _fieldService.loadFieldByVenueId(widget.user, widget.venue.id);

    if (!mounted) return;  // Ensure widget is still in the widget tree

    List<dynamic> fieldsData = result['data'];  // Assuming response['data'] contains your fields

    for (var field in fieldsData) {
      totalReview += field['reviews']?.length ?? 0;  // Null-safe check in case reviews is null
    }

    print("Total Reviews: $totalReview");


    if (result['success'] == true) {
      List<dynamic> data = result['data'];
      setState(() {
        fields = data.map((item) => Field.fromJson(item)).toList();
      });
    } else {
      // Show error message if there is an issue loading fields
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['error'].toString())));
    }
  }

}



