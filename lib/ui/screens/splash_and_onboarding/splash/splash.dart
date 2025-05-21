import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/login/UI/login.dart';

import '../../../utils/core/shared_pref_hepler.dart';
import '../../consultant_flow/main_consul_screen.dart';
import '../../gradueted_flow/mains_dentist_creen.dart';
import '../onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      checkLoginAndNavigate(context);
    });
    super.initState();
  }

  void checkLoginAndNavigate(BuildContext context) async {
    bool loggedIn = await SharedPrefHelper.isLoggedIn();
    if (!loggedIn) {
      Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
      return;
    }

    String? role = await SharedPrefHelper.getUserRole();

    if (role == 'consultant') {
      Navigator.pushReplacementNamed(context, MainConsultantScreen.routeName);
    } else if (role == 'freshGraduate') {
      Navigator.pushReplacementNamed(context, MainDentistScreen.routeName);
    } else {
      // في حالة غير متوقعة، ترجع للدخول
      Navigator.pushReplacementNamed(context, Login.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE2FFFC), Color(0xFF5D9F99)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.51, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Text(
                'SkillBridge Dentistry',
                style: GoogleFonts.getFont(
                  'Playfair Display',
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Image.asset(
                'assets/images/splashicon.png',
                height: 400,
                width: 400,
              ),
              Text(
                'From Learning To\nLeading Together...',
                style: GoogleFonts.getFont(
                  'Playfair Display',
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
