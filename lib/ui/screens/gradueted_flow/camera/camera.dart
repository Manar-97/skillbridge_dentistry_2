import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/case_details.dart';
import '../../../utils/appcolors.dart';
import '../../../utils/widgets/imagemethods.dart';
import 'imagepreview.dart';

class CameraCases extends StatefulWidget {
  const CameraCases({super.key});
  static const String routeName = 'camera';
  @override
  State<CameraCases> createState() => _CameraCasesState();
}

class _CameraCasesState extends State<CameraCases> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                pickImageFromCamera();
              },
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.barColor,
                ),
                child: const Column(
                  children: [
                    Image(
                      image: AssetImage('assets/camera.png'),
                      height: 200,
                    ),
                    Text(
                      'Take Photo',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            GestureDetector(
              onTap: () {
                pickImageFromGallery();
              },
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  children: [
                    Image(
                      image: AssetImage('assets/gallary.png'),
                      height: 200,
                    ),
                    Text(
                      'Choose from Gallery',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      _goToPreviewScreen(File(image.path));
    } else {
      print('No image taken.');
    }
  }

  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _goToPreviewScreen(File(image.path));
    } else {
      print('No image selected.');
    }
  }

  void _goToPreviewScreen(File imageFile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagePreviewScreen(imageFile: imageFile),
      ),
    );
  }
}
