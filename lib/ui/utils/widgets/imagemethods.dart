import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../appcolors.dart';

class ImageMethods extends StatelessWidget {
  const ImageMethods(
      {super.key, required this.icon, required this.text, required this.onTap});

  final IconData icon;
  final String text;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        width: 200,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.mainColor, width: 2)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: AppColors.mainColor,
                size: 50,
              ),
              Text(
                text,
                style: GoogleFonts.getFont('Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
