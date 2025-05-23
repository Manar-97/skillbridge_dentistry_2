import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'consul_accepted_case_details.dart';
import 'consul_image_preview.dart';

class ConsultantCases extends StatefulWidget {
  const ConsultantCases({super.key});
  static const String routeName = 'camera';
  @override
  State<ConsultantCases> createState() => _ConsultantCasesState();
}

class _ConsultantCasesState extends State<ConsultantCases> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.716,
                child: GridView.builder(
                  itemCount: 50,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ConsultantAcceptedCaseDetails.routeName,
                        );
                      },
                      child: Container(
                        height: 75,
                        width: 75,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/case.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
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
        builder:
            (context) => ConsultantImagePreviewScreen(imageFile: imageFile),
      ),
    );
  }
}
