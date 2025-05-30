import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consultant_notification/notification.dart';
import '../../../utils/widgets/appButton.dart';
import '../../../utils/widgets/recommendedcontainer.dart';
import '../../gradueted_flow/profile/profile_vm.dart';

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
                        Navigator.pushNamed(
                          context,
                          ConsultantNotifications.routeName,
                        );
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
                            Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFE2FFFC),
                                    Color(0xFF5D9F99),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.51, 1.0],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'You\'re Making a Difference',
                                      style: GoogleFonts.getFont(
                                        'Roboto',
                                        fontSize: 20,
                                        color: const Color(0xFF13122B),
                                      ),
                                    ),
                                    Text(
                                      'Your Knowledge bridges the gap for new dentists',
                                      style: GoogleFonts.getFont(
                                        'Roboto',
                                        fontSize: 16,
                                        color: const Color(0xFF13122B),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.2,
                                          child: Image.asset(
                                            'assets/images/splashicon.png',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
                            ),
                            Text(
                              'Departments',
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            buildRecommendedRow(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Text(
                              'Departments',
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
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

  Widget buildRecommendedRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RecommendedContainer(
          onPressed: () {},
          text: 'Periodontology',
          imageName: 'assets/images/types of categories.png',
        ),
        RecommendedContainer(
          onPressed: () {},
          text: 'Operative',
          imageName: 'assets/images/types of categories2.png',
        ),
        RecommendedContainer(
          onPressed: () {},
          text: 'Endo',
          imageName: 'assets/images/types of categories3.png',
        ),
      ],
    );
  }

  // Future<void> pickImageFromCamera() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.camera);
  //
  //   if (image != null) {
  //     _goToPreviewScreen(File(image.path));
  //   } else {
  //     print('No image taken.');
  //   }
  // }
  //
  // Future<void> pickImageFromGallery() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (image != null) {
  //     _goToPreviewScreen(File(image.path));
  //   } else {
  //     print('No image selected.');
  //   }
  // }
  //
  // void _goToPreviewScreen(File imageFile) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder:
  //           (context) => ConsultantImagePreviewScreen(imageFile: imageFile),
  //     ),
  //   );
  // }
}
