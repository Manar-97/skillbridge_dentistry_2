import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
    });
    super.initState();
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
              Text('SkillBridge Dentistry',
                  style: GoogleFonts.getFont('Playfair Display',
                      fontSize: 26, fontWeight: FontWeight.w400)),
              Image.asset(
                'assets/images/splashicon.png',
                height: 400,
                width: 400,
              ),
              Text('From Learning To\nLeading Together...',
                  style: GoogleFonts.getFont('Playfair Display',
                      fontSize: 24, fontWeight: FontWeight.w400)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
