import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consultant_notification/notification.dart';
import 'package:skillbridge_dentistry/ui/utils/appcolors.dart';
import '../../gradueted_flow/profile/profile_vm.dart';
import '../consul_camera/consul_image_preview.dart';

class ConsultantHome extends StatefulWidget {
  const ConsultantHome({super.key});
  static const String routeName = 'consultanthome';
  @override
  State<ConsultantHome> createState() => _ConsultantHomeState();
}

class _ConsultantHomeState extends State<ConsultantHome> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          } else if (state is ProfileFailure) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: GoogleFonts.inter(color: Colors.redAccent, fontSize: 16),
              ),
            );
          } else if (state is ProfileSuccess) {
            final user = state.userModel;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Hello, Drs/${user.fullName}',
                  style: GoogleFonts.getFont(
                    'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                      icon: const Icon(Icons.notifications_none, size: 28),
                      onPressed: () {
                        Navigator.pushNamed(context, ConsultantNotifications.routeName);
                      },
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text(
                              'Upload your case',
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            GestureDetector(
                              onTap: () {
                                pickImageFromCamera();
                              },
                              child: Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.barColor,
                                ),
                                child: const Column(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        'assets/images/camera.png',
                                      ),
                                      height: 200,
                                    ),
                                    Text(
                                      'Take Photo',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Column(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        'assets/images/gallary.png',
                                      ),
                                      height: 200,
                                    ),
                                    Text(
                                      'Choose from Gallery',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
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
