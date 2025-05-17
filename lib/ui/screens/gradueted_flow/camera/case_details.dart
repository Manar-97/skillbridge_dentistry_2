import 'package:flutter/material.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/main_consul_screen.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/mains_dentist_creen.dart';

import '../../../utils/widgets/appButton.dart';

class CaseDetails extends StatefulWidget {
  const CaseDetails({super.key});
  static const String routeName = 'casedetails';

  @override
  State<CaseDetails> createState() => _CaseDetailsState();
}

class _CaseDetailsState extends State<CaseDetails> {
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
              'Dentist Name',
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
              'Case Details',
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
                onTap: () {},
                text: "Next",
              ),
            )
          ],
        ),
      ),
    );
  }
}
