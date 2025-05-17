import 'package:flutter/material.dart';
import '../../utils/appcolors.dart';
import 'consul_camera/consul_camera.dart';
import 'consul_home/consul_home.dart';
import 'consul_profile/consultant_profile.dart';

class MainConsultantScreen extends StatefulWidget {
  const MainConsultantScreen({super.key});
  static const String routeName = 'mainconsul';

  @override
  State<MainConsultantScreen> createState() => _MainConsultantScreenState();
}

class _MainConsultantScreenState extends State<MainConsultantScreen> {
  int _selectedIndex = 0;

  String? fullName;
  String? email;
  String? photoPath;

  bool isDataLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isDataLoaded) {
      final args = ModalRoute.of(context)?.settings.arguments;

      if (args != null && args is Map) {
        final Map<String, dynamic> data = Map<String, dynamic>.from(args);
        fullName = data['fullName'];
        email = data['email'];
        photoPath = data['photoPath'];
        isDataLoaded = true;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      ConsultantHome(fullName: fullName ?? ''),
      const ConsultantCases(),
      ConsultantProfileScreen(
        fullName: fullName ?? '',
        email: email ?? '',
        photoPath: photoPath ?? '',
      ),
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
