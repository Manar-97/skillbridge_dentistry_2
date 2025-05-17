import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consul_camera/consul_accepted_case_details.dart';
import 'package:skillbridge_dentistry/ui/utils/appcolors.dart';

class ConsultantNotifications extends StatefulWidget {
  const ConsultantNotifications({super.key});
  static const String routeName = 'consul_notification';

  @override
  State<ConsultantNotifications> createState() =>
      _ConsultantNotificationsState();
}

class _ConsultantNotificationsState extends State<ConsultantNotifications> {
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
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "New Case Alert: A dentist seeks your diagnosis on a new case",
                        style: GoogleFonts.getFont('Inter',
                            fontSize: 16, color: const Color(0xFF13122B)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Reject',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context,
                                  ConsultantAcceptedCaseDetails.routeName);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Accept',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
