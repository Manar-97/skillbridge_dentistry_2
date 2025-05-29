import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/camera.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/found_treate_case_details.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/upload_case_response.dart';
import 'package:skillbridge_dentistry/ui/utils/widgets/appButton.dart';
import '../../../../utils/core/shared_pref_hepler.dart';
import '../../data/model/case_request.dart';
import '../../mains_dentist_creen.dart';
import '../camera_vm.dart';

class CaseDescription extends StatefulWidget {
  const CaseDescription({super.key, required this.imageFile});
  final File imageFile;
  static const String routeName = 'casedescription';

  @override
  State<CaseDescription> createState() => _CaseDescriptionState();
}

class _CaseDescriptionState extends State<CaseDescription> {
  final TextEditingController _caseDescription = TextEditingController();

  @override
  void dispose() {
    _caseDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<UploadCaseCubit, UploadCaseState>(
        listener: (context, state) async {
          if (state is UploadCaseLoading) {
            _showLoadingDialog(context);
          } else if (state is UploadCaseSuccess) {
            Navigator.pop(context); // Close dialog
            await SharedPrefHelper.saveUploadedCase(state.response.toModel());
            final caseRequestId = state.response.caseRequestId;
            print('Uploaded caseRequestId: $caseRequestId');
            if (state.response.treatment ==
                "Sent Case For Specific Consultant") {
              _showSentToConsultantDialog(context);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => FoundTreatCaseDetails(
                        imageFile: widget.imageFile,
                        treatment: state.response.treatment,
                      ),
                ),
              );
            }
          } else if (state is UploadCaseFailure) {
            Navigator.pop(context); // Close dialog
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        CameraCases.routeName,
                      );
                    },
                    child: Text(
                      'Skip',
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF13122B),
                      ),
                    ),
                  ),
                  Text(
                    'Enter Your Disease',
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  TextField(
                    maxLines: 5,
                    controller: _caseDescription,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Enter disease you think about...',
                      filled: true,
                      fillColor: Colors.grey[300],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.4),
                  AppButton(text: 'Upload Your Disease', onTap: _uploadCase),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _uploadCase() {
    final diagnose = _caseDescription.text.trim();
    if (diagnose.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter diagnosis')));
      return;
    }
    final request = UploadCaseRequest(
      diagnose: diagnose,
      imageFile: widget.imageFile,
    );

    context.read<UploadCaseCubit>().uploadCase(request);
    _showLoadingDialog(context);
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 200,
                  child: Image.asset('assets/images/uploading.png'),
                ),
                const SizedBox(height: 15),
                Text(
                  "Uploading...",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSentToConsultantDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 180,
                  width: 300,
                  child: Image.asset(
                    'assets/images/processing.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Your case has been sent to a specific consultant. Please wait for a response.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 20),
                AppButton(
                  onTap: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pushReplacementNamed(
                      context,
                      MainDentistScreen.routeName,
                    );
                  },
                  text: "Back to Home",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
