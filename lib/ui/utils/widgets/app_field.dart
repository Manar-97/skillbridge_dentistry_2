import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.text,
    required this.hintText,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
  });
  final String text;
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool hidden = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            widget.text,
            style: GoogleFonts.getFont(
              'Inter',
              color: const Color(0xFF717070),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        TextFormField(
          obscuringCharacter: '*',
          validator: widget.validator,
          obscureText: hidden,
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon:
                widget.obscureText
                    ? IconButton(
                      onPressed: () {
                        setState(() {
                          hidden = !hidden;
                        });
                      },
                      iconSize: 24,
                      splashRadius: 1,
                      isSelected: !hidden,
                      selectedIcon: const Icon(Icons.remove_red_eye_rounded),
                      icon: Image.asset('assets/images/Eye.png', height: 30.0),
                    )
                    : widget.suffixIcon,
            hintText: widget.hintText,
            hintStyle: GoogleFonts.getFont(
              'Inter',
              color: const Color(0xFF9D9D9D),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
