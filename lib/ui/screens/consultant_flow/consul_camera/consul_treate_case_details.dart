import 'package:flutter/material.dart';
import 'package:skillbridge_dentistry/ui/utils/widgets/appButton.dart';

import '../main_consul_screen.dart';

class ConsultantTreatCaseDetails extends StatefulWidget {
  const ConsultantTreatCaseDetails({super.key});
  static const String routeName = 'consulcasetreatdetails';

  @override
  State<ConsultantTreatCaseDetails> createState() =>
      _ConsultantTreatCaseDetailsState();
}

class _ConsultantTreatCaseDetailsState
    extends State<ConsultantTreatCaseDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Consultant Name',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
            ),
            const Text(
              'dentistname55@gmail.com',
              style: TextStyle(color: Color(0xFF898989), fontSize: 17),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              decoration: const BoxDecoration(),
              child: const Image(image: AssetImage('assets/p1.png')),
            ),
            const Text(
              'Treatment the case',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            const Text(
              'Lorem ipsum dolor sit amet consectetur. Risus et tempor congue id tortor. Non nisi sagittis bibendum nisl.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const Text(
              '21 Sep 2024',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: AppButton(
                onTap: () {
                  _showSuccessDialog(context);
                },
                text: "Submit",
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // يمنع الإغلاق بالنقر خارج النافذة
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/success_icon.png',
                    width: 80), // ضع صورة علامة الصح هنا
                const SizedBox(height: 15),
                const Text(
                  "Send Success",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Your Response has been Sent successfully",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                AppButton(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, MainConsultantScreen.routeName),
                  text: "OK",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
