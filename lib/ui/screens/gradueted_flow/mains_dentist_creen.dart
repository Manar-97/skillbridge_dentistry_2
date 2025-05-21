import 'package:flutter/material.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/profile/profile.dart';
import '../../utils/appcolors.dart';
import 'camera/camera.dart';
import 'home/home.dart';

class MainDentistScreen extends StatefulWidget {
  const MainDentistScreen({super.key, required this.fullName});
  final String fullName;
  static const String routeName = 'maindent';

  @override
  State<MainDentistScreen> createState() => _MainDentistScreenState();
}

class _MainDentistScreenState extends State<MainDentistScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      Home(fullName: widget.fullName),
      const CameraCases(),
      ProfileScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: const Color(0xFFC9DFDD),
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: const Color(0xFF717070),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        iconSize: 25,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
      body: tabs[_selectedIndex],
    );
  }
}
