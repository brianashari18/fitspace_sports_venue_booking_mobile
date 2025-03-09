import 'package:fitspace_sports_venue_booking_mobile/utils/size.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/widgets/card_court_widgets.dart';

class VenueDetailScreen extends StatefulWidget {
  const VenueDetailScreen({super.key});

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

  bool flag = true;

  @override
  void initState() {
    super.initState();

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
                      image: AssetImage('assets/images/venue_dummy.png'),
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
                            color: Colors.grey[400],
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
                              children: [
                                _buildButton('Mini Soccer'),
                                _buildButton('Volleyball'),
                                _buildButton('Swimming Pool'),
                                _buildButton('Badminton'),
                              ],
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 18),
                                SizedBox(width: 4),
                                Text('4.5',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(width: 4),
                                Text('(102 Reviews)',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey)),
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
                          const Text(
                            'Progresif Sports',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  'Jl. Soekarno-Hatta No.785A, Kab. Bandung',
                                  style: TextStyle(color: Colors.grey),
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
                              // Gaya teks default
                              children: <TextSpan>[
                                TextSpan(
                                  text: flag
                                      ? "$firstHalf  "
                                      : ("$firstHalf$secondHalf   "),
                                ),
                                TextSpan(
                                  text: flag ? " Read More" : " Show Less",
                                  // Perhatikan spasi di awal
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
                          const Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey,
                                child: Text('FM'),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Feronica Maria',
                                      style: TextStyle(
                                          color: AppColors.darkGrey,
                                          fontWeight: FontWeight.bold)),
                                  Text('Joined 2 yrs ago',
                                      style: TextStyle(color: AppColors.grey)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            color: Colors.grey,
                          ),
                          const Text(
                            'Available Court',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            children: [
                              CardCourtWidgets(
                                title: 'Swimming Pool',
                                price: 'Rp 35.000/hr',
                                imagePaths: const [
                                  'assets/images/venue_dummy.png'
                                ],
                                onBook: () {
                                  print('Booked');
                                },
                              ),
                              const SizedBox(height: 8),
                              CardCourtWidgets(
                                title: 'Mini Soccer',
                                price: 'Rp 45.000/hr',
                                imagePaths: const [
                                  'assets/images/venue_dummy.png'
                                ],
                                onBook: () {
                                  print('Booked');
                                },
                              ),
                              const SizedBox(height: 8),
                              CardCourtWidgets(
                                title: 'Mini Soccer',
                                price: 'Rp 45.000/hr',
                                imagePaths: const [
                                  'assets/images/venue_dummy.png',
                                  'assets/images/venue_dummy.png'
                                ],
                                onBook: () {
                                  print('Booked');
                                },
                              ),
                              const SizedBox(height: 8),
                              CardCourtWidgets(
                                title: 'Mini Soccer',
                                price: 'Rp 45.000/hr',
                                imagePaths: const [
                                  'assets/images/venue_dummy.png',
                                  'assets/images/venue_dummy.png',
                                  'assets/images/venue_dummy.png'
                                ],
                                onBook: () {
                                  print('Booked');
                                },
                              ),
                            ],
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
}
