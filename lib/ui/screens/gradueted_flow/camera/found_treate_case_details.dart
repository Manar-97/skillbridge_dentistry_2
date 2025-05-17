import 'package:flutter/material.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/mains_dentist_creen.dart';
import 'package:skillbridge_dentistry/ui/utils/widgets/appButton.dart';

class FoundTreatCaseDetails extends StatefulWidget {
  const FoundTreatCaseDetails({super.key});
  static const String routeName = 'treatcasedetails';

  @override
  State<FoundTreatCaseDetails> createState() => _FoundTreatCaseDetailsState();
}

class _FoundTreatCaseDetailsState extends State<FoundTreatCaseDetails> {
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Center(
              child: Container(
                decoration: const BoxDecoration(),
                child: const Image(image: AssetImage('assets/p1.png')),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
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
                text: "OK",
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
      barrierDismissible: false, // يمنع الإغلاق بالنقر خارج النافذة
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 180,
                  width: 300,
                  child: Image.asset(
                    'assets/processing.png',
                    fit: BoxFit.cover,
                  ),
                ), // ضع صورة علامة الصح هنا
                const SizedBox(height: 15),
                const Text(
                  "Thank you for your trust Alwayes SkillBridge in your own",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 20),
                AppButton(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, MainDentistScreen.routeName),
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
