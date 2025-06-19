import 'dart:math';

import 'package:fitspace_sports_venue_booking_mobile/models/field_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/add_field_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/add_venue_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/book_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/booking_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/update_field_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/screens/update_venue_screen.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/venue_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/size.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import '../models/user_model.dart';
import '../models/venue_model.dart';

import 'package:fitspace_sports_venue_booking_mobile/services/field_service.dart';

class MyVenueDetailScreen extends StatefulWidget {
  const MyVenueDetailScreen(
      {super.key, required this.user, required this.venue});

  final User user;
  final Venue venue;

  @override
  State<MyVenueDetailScreen> createState() => MyVenueDetailScreenState();
}

class MyVenueDetailScreenState extends State<MyVenueDetailScreen> {
  final GlobalKey _containerKey = GlobalKey();
  double containerHeight = 0.0;
  String firstHalf = "";
  String secondHalf = "";
  late Venue venue;
  final FieldService _fieldService = FieldService();
  final VenueService _venueService = VenueService();
  bool flag = true;

  List<Field> fields = [];
  num totalReview = 0;
  num totalRating = 0;

  String text = '';

  @override
  void initState() {
    super.initState();
    venue = widget.venue;
    text =
        "Selamat datang di ${venue.name!}, venue serba-ada yang dikelola langsung oleh pemilik berpengalaman untuk menjamin kenyamanan dan kualitas layanan terbaik. Terletak strategis di ${venue.street!}, Kecamatan ${venue.district!}, ${venue.cityOrRegency!}, ${venue.province!} (kode pos ${venue.postalCode!}), venue kami mudah diakses baik via transportasi umum maupun kendaraan pribadi—Di sini tersedia berbagai lapangan bertipe ${fields.map((field) => field.type).join(', ')} dengan harga sewa mulai dari ${fields != null && fields.isNotEmpty ? fields.map((e) => e.price).reduce((a, b) => min(a!, b!))!.toDouble() : 0} per sesi, lengkap dengan fasilitas pendukung dan area tunggu yang nyaman. Dengan rating rata-rata ${venue.rating!} (berdasarkan ulasan pelanggan), setiap kunjungan Anda akan terekam momen seru dan kepuasan optimal. Untuk reservasi atau informasi lebih lanjut, hubungi kami di ${venue.phoneNumber!}—siap melayani Anda setiap hari, 24 jam. Ayo, booking sekarang dan jadikan acara olahraga atau hiburan Anda semakin berkesan!";
    _loadFields();
    if (text.length > 50) {
      firstHalf = text.substring(0, 148);
      secondHalf = text.substring(148, text.length);
    } else {
      firstHalf = text;
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

    DateTime createdAtDate = venue.owner!.joinedAt!;
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
      joinTime =
          "Joined $daysDifference ${daysDifference > 1 ? 'days' : 'day'} ago";
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
                  icon: const Icon(Icons.edit_outlined,
                      color: AppColors.darkerPrimaryColor),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UpdateVenueScreen(venue: venue),
                    ));
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          height: 90,
          padding: const EdgeInsets.all(0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: AppColors.base),
            child: ElevatedButton(
                onPressed: () async {
                  final back =
                      await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddFieldScreen(
                      venue: venue,
                    ),
                  ));

                  print("BACK: $back");

                  if (back != null && back == true) {
                    await _loadVenue();
                    print("Updated venue: $venue");

                    await _loadFields();
                    print("Updated fields: $fields");
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    backgroundColor: AppColors.darkerPrimaryColor),
                child: Text(
                  "Add Field",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: AppColors.base),
                )),
          ),
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        fields.isEmpty || fields[0].gallery!.isEmpty
                            ? 'https://staticg.sportskeeda.com/editor/2022/11/a9ef8-16681658086025-1920.jpg'
                            : 'http://${dotenv.env["HOST"]}:${dotenv.env["PORT"]}${fields[0].gallery![0].photoUrl != null ? fields[0].gallery![0].photoUrl! : ''}',
                      ),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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
                        height: 5,
                      ),
                      fields.isEmpty
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: fields.isNotEmpty
                                        ? fields.map((field) {
                                            return _buildButton(field.type!);
                                          }).toList()
                                        : [const SizedBox(height: 25)],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.amber),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${totalRating.toStringAsFixed(1)} ${totalReview > 1 ? '($totalReview Reviews)' : '($totalReview Review)'}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                              color: AppColors.darkGrey
                                                  .withOpacity(0.6),
                                              fontSize:
                                                  AppSize.getWidth(context) *
                                                      12 /
                                                      360,
                                            ),
                                      ),
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
                            venue.name!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize:
                                      AppSize.getWidth(context) * 22 / 360,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.grey,
                                size: AppSize.getWidth(context) * 20 / 360,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  '${venue.street} ${venue.cityOrRegency}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          color: AppColors.grey,
                                          fontSize: AppSize.getWidth(context) *
                                              14 /
                                              360),
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          fields.isEmpty
                              ? Container()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Description',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              color: AppColors.darkGrey,
                                              fontSize:
                                                  AppSize.getWidth(context) *
                                                      14 /
                                                      360,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: flag
                                                  ? "$firstHalf  "
                                                  : ("$firstHalf$secondHalf   "),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .copyWith(
                                                      color: AppColors.darkGrey,
                                                      fontSize:
                                                          AppSize.getWidth(
                                                                  context) *
                                                              12 /
                                                              360)),
                                          TextSpan(
                                            text: flag
                                                ? " Read More"
                                                : " Show Less",
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
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
                                  ],
                                ),
                          const SizedBox(height: 16),
                          Text(
                            'Uploader',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: AppColors.darkGrey,
                                    fontSize:
                                        AppSize.getWidth(context) * 14 / 360,
                                    fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.grey,
                                backgroundImage: NetworkImage(
                                  'https://static.vecteezy.com/system/resources/previews/003/715/527/large_2x/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-vector.jpg',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${venue.owner!.firstName!} ${venue.owner!.lastName!}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                            color: AppColors.darkGrey,
                                            fontSize:
                                                AppSize.getWidth(context) *
                                                    14 /
                                                    360,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    joinTime,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                            color: AppColors.darkGrey,
                                            fontSize:
                                                AppSize.getWidth(context) *
                                                    12 /
                                                    360),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            color: AppColors.grey,
                          ),
                          Text(
                            'Available Court',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize:
                                      AppSize.getWidth(context) * 22 / 360,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          fields.isEmpty
                              ? const Center(
                                  child: SizedBox(
                                    height: 230,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.sentiment_dissatisfied,
                                            size: 40,
                                            color: AppColors.darkGrey),
                                        SizedBox(height: 10),
                                        Text(
                                          'No fields found',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.darkGrey),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: fields.length,
                                  itemBuilder: (context, index) {
                                    final field = fields[index];
                                    return Column(
                                      children: [
                                        _cardCourt(
                                          title: field.type!,
                                          price: field.price!,
                                          imagePaths: field.gallery!
                                              .map((photo) => photo.photoUrl!)
                                              .toList(),
                                          onEdit: () async {
                                            final back =
                                                await Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateFieldScreen(venue: venue, field: field, user: widget.user,)));

                                            print("BACK: $back");

                                            if (back != null && back == true) {
                                              await _loadVenue();
                                              print("Updated venue: $venue");

                                              await _loadFields();
                                              print("Updated fields: $fields");
                                            }
                                          },
                                          onDelete: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  height: 150,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Are you sure you want to delete this?',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium!
                                                            .copyWith(
                                                                fontSize: AppSize
                                                                        .getWidth(
                                                                            context) *
                                                                    14 /
                                                                    360),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          SizedBox(
                                                            height: 50,
                                                            width: 120,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .primaryColor,
                                                                foregroundColor:
                                                                    AppColors
                                                                        .whitePurple,
                                                              ),
                                                              child: const Text(
                                                                  'Cancel'),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 50,
                                                            width: 120,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                _deleteField(
                                                                    field);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .red,
                                                                foregroundColor:
                                                                    AppColors
                                                                        .whitePurple,
                                                              ),
                                                              child: const Text(
                                                                  'Delete'),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 8),
                                        // Control the gap between cards
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
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Colors.blue[800],
            fontSize: AppSize.getWidth(context) * 12 / 360),
      ),
    );
  }

  Widget fieldTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
          color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
      child:
          Text(text, style: TextStyle(color: Colors.blue[800], fontSize: 12)),
    );
  }

  Widget _cardCourt({
    required String title,
    required int price,
    required VoidCallback? onEdit,
    required VoidCallback? onDelete,
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
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'http://${dotenv.env["HOST"]}:${dotenv.env["PORT"]}${imagePaths[0]}',
                                fit: BoxFit.cover,
                                width: 250,
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
                                },
                              ),
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imagePaths.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.only(right: 8.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    'http://${dotenv.env["HOST"]}:${dotenv.env["PORT"]}${imagePaths[index]}',
                                    fit: BoxFit.cover,
                                    width: 250,
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
                                    },
                                  ),
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
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: AppSize.getWidth(context) * 12 / 360,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rp${NumberFormat('#,###', 'id_ID').format(price)}/hr",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.darkerPrimaryColor,
                          fontSize: AppSize.getWidth(context) * 18 / 360,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 90,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: onEdit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkerPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                        color: AppColors.whitePurple,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 90,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: onDelete,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Delete',
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
    final result =
        await _fieldService.loadFieldByVenueId(widget.user, venue.id!);

    if (!mounted) return;

    if (result['success'] == true) {
      List<dynamic> fieldsData = result['data'];

      List<dynamic> data = result['data'];
      setState(() {
        fields = data.map((item) {
          print(item);
          return Field.fromJson(item);
        }).toList();

        totalReview = 0;
        num tempRating = 0;
        num tempTotal = 0;

        for (var field in fields) {
          var reviews = field.review;
          if (reviews != null && reviews.isNotEmpty) {
            totalReview += reviews.length;
            for (var review in reviews) {
              tempRating += review.rating!;
            }
            tempTotal += tempRating / reviews.length;
            tempRating = 0;
          }
        }

        if (fields.isNotEmpty) {
          totalRating = tempTotal / fields.length;
        } else {
          totalRating = 0;
        }

        print("Total Reviews: $totalReview");
        print("Total Rating: $totalRating");
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result['error'].toString())));
    }
  }

  Future<void> _deleteField(Field field) async {
    final result = await _fieldService.delete(widget.user, venue, field);

    if (!mounted) return;

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully Delete Field')));
      await _loadVenue();
      await _loadFields();
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result['error'].toString())));
    }
  }

  Future<void> _loadVenue() async {
    final result = await _venueService.load(widget.user, venue.id!);

    if (!mounted) return;

    if (result['success'] == 'true') {
      setState(() {
        venue = Venue.fromJson(result['data']);
        print('venueeeeee: $venue');
      });
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result['error'].toString())));
    }
  }
}
