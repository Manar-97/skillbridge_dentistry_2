import 'package:flutter/material.dart';
import '../../utils/appcolors.dart';
import 'consul_camera/consul_camera.dart';
import 'consul_home/consul_home.dart';
import 'consul_profile/consul_profile.dart';
import 'level/level_screen.dart';

class MainConsultantScreen extends StatefulWidget {
  const MainConsultantScreen({
    super.key,
  });
  static const String routeName = 'mainconsul';

  @override
  State<MainConsultantScreen> createState() => _MainConsultantScreenState();
}

class _MainConsultantScreenState extends State<MainConsultantScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      ConsultantHome(),
      const ConsultantLevelScreen(),
      ConsultantProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: tabs),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: const Color(0xFFC9DFDD),
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: const Color(0xFF717070),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        iconSize: 25,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.network_cell),
            label: 'Level',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
