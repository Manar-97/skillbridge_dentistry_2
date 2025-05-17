import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/found_treate_case_details.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/mains_dentist_creen.dart';
import 'package:skillbridge_dentistry/ui/utils/widgets/appButton.dart';

class CaseDisease extends StatefulWidget {
  const CaseDisease({super.key});
  static const String routeName = 'casedisease';

  @override
  State<CaseDisease> createState() => _CaseDiseaseState();
}

class _CaseDiseaseState extends State<CaseDisease> {
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
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, MainDentistScreen.routeName);
                },
                child: Text(
                  'Skip',
                  style: GoogleFonts.getFont('Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF13122B)),
                ),
              ),
              Text(
                'Enter Your Disease',
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
                    hintText: 'Enter disease you think about...',
                    filled: true,
                    fillColor: Colors.grey[300]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              AppButton(
                  text: 'Search about Disease',
                  onTap: () {
                    _showSuccessDialog(context);
                  })
            ],
          ),
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
                SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.asset(
                    'assets/uploading.png',
                    fit: BoxFit.cover,
                  ),
                ), // ضع صورة علامة الصح هنا
                const SizedBox(height: 15),
                Text(
                  "Please Wait...",
                  style: GoogleFonts.getFont('Inter',
                      fontSize: 22, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(
          context, FoundTreatCaseDetails.routeName); // يقفل الـDialog
    });
  }
}
