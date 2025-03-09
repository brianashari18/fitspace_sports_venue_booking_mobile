import 'package:flutter/material.dart';
import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  final List<String> notifications = [
    'Pesanan Diserahkan ke Jasa Kirim: Pesanan akan diproses.',
    'Konfirmasi Penerimaan Pesanan: Jika kamu belum menerima pesanan.',
    'Pesanan Tiba: Pesanan dengan nomor resi telah tiba.',
    'Pesanan Selesai: Klik untuk beri nilai pesanan.'
  ];

  final List<String> notificationTime = [
    '02-03-2025 19:46',
    '02-03-2025 08:09',
    '01-03-2025 16:16',
    '23-02-2025 22:14'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitePurple,
      appBar: AppBar(
        backgroundColor: AppColors.whitePurple,
        automaticallyImplyLeading: false,
        title: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.west,
                  size: 24,
                  color: AppColors.darkGrey,
                ),
              ),
              const Spacer(),
              const Text(
                'Notification',
                style: TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 24,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(
            color: AppColors.lightGrey,
            thickness: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.separated(
                itemCount: notifications.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: AppColors.lightGrey,
                    thickness: 0.5,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: const BoxDecoration(
                      color: AppColors.whitePurple,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.notifications_active,
                          color: AppColors.primaryColor,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notifications[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                notificationTime[index],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.darkGrey.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}