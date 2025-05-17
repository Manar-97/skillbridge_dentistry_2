import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/register/UI/consultant_register.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/register/UI/fresh_register.dart';
import 'package:skillbridge_dentistry/ui/utils/widgets/appButton.dart';

class PersonaScreen extends StatefulWidget {
  const PersonaScreen({super.key});
  static const String routeName = "persona";

  @override
  State<PersonaScreen> createState() => _PersonaScreenState();
}

class _PersonaScreenState extends State<PersonaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/persona.png'),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Continue as',
                  style: GoogleFonts.getFont('Inter',
                      fontSize: 20, fontWeight: FontWeight.w500)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              AppButton(
                  text: 'Consultant',
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, ConsultantRegister.routeName);
                  }),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              AppButton(
                  text: 'Fresh Graduated',
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, FreshGraduatedRegister.routeName);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
