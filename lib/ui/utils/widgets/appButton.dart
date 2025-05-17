import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/utils/appcolors.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.text, required this.onTap});
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: GoogleFonts.getFont('Inter',
                fontSize: 18, fontWeight: FontWeight.w500,color: Colors.white),
          ),
        ),
      ),
    );
  }
}
