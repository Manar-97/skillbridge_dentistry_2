import 'package:flutter/material.dart';

class AuthMethods extends StatelessWidget {
  const AuthMethods({super.key, required this.onTap, required this.imageName});
  final Function() onTap;
  final String imageName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 50, spreadRadius: 2),
            ],
            image: DecorationImage(
                image: AssetImage(imageName)),
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
