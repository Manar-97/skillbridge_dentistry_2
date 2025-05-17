import 'package:flutter/material.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/main_consul_screen.dart';

import '../../../utils/widgets/appButton.dart';
import 'consul_case_description/consul_case_description.dart';
import 'consul_treate_case_details.dart';

class ConsultantAcceptedCaseDetails extends StatefulWidget {
  const ConsultantAcceptedCaseDetails({super.key});
  static const String routeName = 'consulcasedetails';

  @override
  State<ConsultantAcceptedCaseDetails> createState() =>
      _ConsultantAcceptedCaseDetailsState();
}

class _ConsultantAcceptedCaseDetailsState
    extends State<ConsultantAcceptedCaseDetails> {
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
            Center(
              child: Container(
                decoration: const BoxDecoration(),
                child: const Image(image: AssetImage('assets/p1.png')),
              ),
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
                onTap: () {
                  Navigator.pushNamed(
                      context, ConsultantCaseDescription.routeName);
                },
                text: "OK",
              ),
            )
          ],
        ),
      ),
    );
  }
}
