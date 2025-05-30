import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/profile/profile_vm.dart';
import 'package:skillbridge_dentistry/ui/utils/appcolors.dart';
import '../../../utils/core/shared_pref_hepler.dart';
import '../../Auth/presentation/login/UI/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String routeName = 'profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          } else if (state is ProfileFailure) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: GoogleFonts.inter(color: Colors.redAccent, fontSize: 16),
              ),
            );
          } else if (state is ProfileSuccess) {
            final user = state.userModel;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          blurRadius: 15,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 75,
                      backgroundImage: const AssetImage(
                        'assets/images/user.jpeg',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    ' Dr/ ${user.fullName}',
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black45,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    user.email,
                    style: GoogleFonts.inter(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white,
                    elevation: 10,
                    shadowColor: AppColors.mainColor,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _infoRow(
                            icon: Icons.person,
                            label: 'Role ',
                            value: user.role,
                          ),
                          const SizedBox(height: 15),
                          _infoRow(
                            icon: Icons.school,
                            label: 'University',
                            value: user.data.university,
                          ),
                          const SizedBox(height: 15),
                          _infoRow(
                            icon: Icons.account_tree_outlined,
                            label: 'Department',
                            value: user.data.department,
                          ),
                          const SizedBox(height: 15),
                          _infoRow(
                            icon: Icons.calendar_today_outlined,
                            label: 'Graduation Year',
                            value: user.data.yearsOfGraduation.toString(),
                          ),
                          const SizedBox(height: 15),
                          _infoRow(
                            icon: Icons.calendar_today_outlined,
                            label: 'Graduation Year',
                            value: user.data.yearsOfGraduation.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.logout_rounded,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Log Out',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () async {
                        await SharedPrefHelper.logout();
                        Navigator.pushReplacementNamed(
                          context,
                          Login.routeName,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.black, size: 26),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            '$label:',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(fontSize: 16, color: Colors.black),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
