import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/utils/widgets/appButton.dart';

import '../consul_treate_case_details.dart';

class ConsultantCaseDescription extends StatefulWidget {
  const ConsultantCaseDescription({super.key});
  static const String routeName = 'consulcasedescription';

  @override
  State<ConsultantCaseDescription> createState() =>
      _ConsultantCaseDescriptionState();
}

class _ConsultantCaseDescriptionState extends State<ConsultantCaseDescription> {
  final TextEditingController _caseDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload your case Treatment',
                style: GoogleFonts.getFont('Inter',
                    fontWeight: FontWeight.w500, fontSize: 22),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              TextField(
                maxLines: 5,
                controller: _caseDescription,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    hintText: 'Enter the treatment',
                    filled: true,
                    fillColor: Colors.grey[300]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              AppButton(
                  text: 'Upload Treatment',
                  onTap: () {
                    Navigator.pushNamed(
                        context, ConsultantTreatCaseDetails.routeName);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
