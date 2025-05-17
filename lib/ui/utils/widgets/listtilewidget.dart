import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget(
      {super.key, required this.icon, required this.text, required this.onTap});
  final IconData icon;
  final String text;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        title: Row(
          children: [
            Icon(icon),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
            Text(
              text,
              style: GoogleFonts.getFont('Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF13122B)),
            )
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
