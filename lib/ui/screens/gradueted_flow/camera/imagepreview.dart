import 'dart:io';
import 'package:flutter/material.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/case_description/case_description.dart';
import 'package:skillbridge_dentistry/ui/utils/widgets/appButton.dart';

class ImagePreviewScreen extends StatelessWidget {
  final File imageFile;

  const ImagePreviewScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
                width: 80,
                height: 35,
                child: AppButton(
                    text: 'Add',
                    onTap: () {
                      _showSuccessDialog(context);
                    })),
          )
        ],
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.file(
              imageFile,
              fit: BoxFit.contain,
            ),
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
                Image.asset('assets/success_icon.png',
                    width: 80), // ضع صورة علامة الصح هنا
                const SizedBox(height: 15),
                const Text(
                  "Add Success",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Your photo has been added successfully",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                AppButton(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, CaseDescription.routeName),
                  text: "Add Disease",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
