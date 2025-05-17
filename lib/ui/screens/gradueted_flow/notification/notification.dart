import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/utils/appcolors.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});
  static const String routeName = 'notification';

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Notification',
          style: GoogleFonts.getFont('Inter',
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF13122B)),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.commentBgrColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '🎉 Earn More Points & Get Discounts! "Boost your rewards! Upload before and after images of cases you’ve treated, and earn extra points',
                  style: GoogleFonts.getFont('Inter',
                      fontSize: 16, color: const Color(0xFF13122B)),
                ),
              ),
            ),
          );
        },
        itemCount: 2,
      ),
    );
  }
}
