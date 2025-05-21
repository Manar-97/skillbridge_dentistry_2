import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/camera.dart';
import 'package:skillbridge_dentistry/ui/utils/widgets/appButton.dart';
import '../../../utils/widgets/casecontainer.dart';
import '../../../utils/widgets/recommendedcontainer.dart';
import '../camera/case_description/case_description.dart';
import '../notification/notification.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.fullName});
  final String fullName;
  static const String routeName = 'home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Hello, ${widget.fullName}',
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
                  Navigator.pushNamed(context, Notifications.routeName);
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
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    buildAdsContainer(context),
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
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    buildCasesRow(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      'Recommended for you',
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
                  ],
                ),
              ),
            ],
          ),
        ),
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

  Widget buildCasesRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CaseContainer(
          icon: Icons.personal_injury_outlined,
          onPressed: () {
            Navigator.pushNamed(context, CaseDescription.routeName);
          },
          text: 'Diagnose',
        ),
        CaseContainer(
          icon: Icons.image_outlined,
          onPressed: () {
            Navigator.pushNamed(context, CameraCases.routeName);
          },
          text: 'Image',
        ),
      ],
    );
  }

  Widget buildAdsContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [Color(0xFFE2FFFC), Color(0xFF5D9F99)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.51, 1.0],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Need Expert Advice?',
              style: GoogleFonts.getFont(
                'Roboto',
                fontSize: 20,
                color: const Color(0xFF13122B),
              ),
            ),
            Text(
              'Access top consultants instantly for\nsecond opinions or case reviews',
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
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: AppButton(text: 'Consult Now', onTap: () {}),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
