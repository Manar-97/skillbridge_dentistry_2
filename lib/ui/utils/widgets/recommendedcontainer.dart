import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../appcolors.dart';

class RecommendedContainer extends StatelessWidget {
  const RecommendedContainer(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.imageName});
  final String imageName;
  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(imageName)))),
        Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.getFont('Inter',
              fontSize: 12, color: const Color(0xFF2F504D)),
        ),
      ],
    );
  }
}
