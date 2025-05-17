import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/utils/widgets/appButton.dart';
import '../persona/persona.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const String routeName = "onboarding";

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildPage(
                title: 'Welcome to\nSkillBridge Dentistry',
                description: 'Connect, Learn and Grow.',
              ),
              _buildPage(
                title: 'Bridge the Gap\nBetween Knowledge\nand Practice',
                description: 'Collaborate with\nexperienced mentors',
              ),
              _buildPage(
                title: 'AI-Powered\nDiagnosis Assistance',
                description:
                    'Mentor-Mentee\nConnections\nAI-Powered Diagnosis\nAssistance',
              ),
            ],
          ),
          Positioned(
            top: 60,
            right: 20,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, PersonaScreen.routeName);
              },
              child: Text(
                'Skip',
                style: GoogleFonts.getFont('Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF13122B)),
              ),
            ),
          ),
          Positioned(
            bottom: 250,
            left: 180,
            child: Row(
              children: List.generate(
                3,
                (index) => Container(
                  margin: const EdgeInsets.only(right: 5),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? const Color(0xFF2F504D)
                        : const Color(0xFF5D9F99),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 80,
            width: 260,
            height: 50,
            child: AppButton(
                onTap: () {
                  if (_currentPage == 2) {
                    Navigator.pushReplacementNamed(
                        context, PersonaScreen.routeName);
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
                text: _currentPage == 2 ? 'Get Started' : 'Next'),
          ),
        ],
      ),
    );
  }

  Widget _buildPage({
    required String title,
    required String description,
  }) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.51, 1.0],
          colors: [Color(0xFFE2FFFC), Color(0xFF5D9F99)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
