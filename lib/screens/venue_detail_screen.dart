import 'package:fitspace_sports_venue_booking_mobile/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:fitspace_sports_venue_booking_mobile/widgets/card_court_widgets.dart';

class VenueDetailScreen extends StatefulWidget {
  const VenueDetailScreen({super.key});

  @override
  State<VenueDetailScreen> createState() => VenueDetailScreenState();
}

class VenueDetailScreenState extends State<VenueDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
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
            padding: const EdgeInsets.all(8.0),
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
            padding: const EdgeInsets.all(8.0),
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
        child: SizedBox(
          height: AppSize.getHeight(context),
          child: Stack(
            children: [
              Container(
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/venue_dummy.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: AppSize.getHeight(context) * 0.2,
                child: Container(
                  width: AppSize.getWidth(context),
                  height: AppSize.getHeight(context),
                  decoration: BoxDecoration(
                    color: AppColors.whitePurple,
                    borderRadius: BorderRadius.circular(20)
                  ),
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
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 18),
                                SizedBox(width: 4),
                                Text('4.5', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                SizedBox(width: 4),
                                Text('(102 Reviews)', style: TextStyle(fontSize: 14, color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: RichText(
                                    text: const TextSpan(
                                      style:
                                          TextStyle(color: Colors.black87),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                                              'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                                              'Ut enim ad minim veniam.',
                                        ),
                                        TextSpan(
                                          text: ' Read More',
                                          style: TextStyle(
                                            color: AppColors
                                                .darkerPrimaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text('Feronica Maria',
                                        style: TextStyle(
                                            color: AppColors.darkGrey,
                                            fontWeight: FontWeight.bold)),
                                    Text('Joined 2 yrs ago',
                                        style: TextStyle(
                                            color: AppColors.grey)),
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
                                  imagePaths: const [],
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
