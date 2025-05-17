import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../appcolors.dart';

class CaseContainer extends StatelessWidget {
  const CaseContainer(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.text});
  final IconData icon;
  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              color: const Color(0xFFC9DFDD),
              borderRadius: BorderRadius.circular(8)),
          child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                color: AppColors.mainColor,
                size: 50,
              )),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.getFont('Inter',
              fontSize: 18,
              color: const Color(0xFF2F504D)),
        ),
      ],
    );
  }
}
