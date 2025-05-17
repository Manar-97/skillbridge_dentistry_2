// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/request/register_request.dart';
// import 'package:skillbridge_dentistry/ui/utils/widgets/appButton.dart';
// import '../../../../utils/validators.dart';
// import '../../../../utils/widgets/apptextfield.dart';
// import '../../../gradueted_flow/register/UI/fresh_register.dart';
// import '../../data/repositories/auth_ds/auth_ds.dart';
//
// class FreshGraduated extends StatefulWidget {
//   const FreshGraduated({super.key});
//   static const String routeName = 'dentist';
//   @override
//   State<FreshGraduated> createState() => _FreshGraduatedState();
// }
//
// class _FreshGraduatedState extends State<FreshGraduated> {
//   String? _selectedUniversity;
//   final TextEditingController fullName = TextEditingController();
//   final TextEditingController years = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   void _proceedToRegistration() async {
//     if (fullName.text.isNotEmpty &&
//         years.text.isNotEmpty &&
//         _selectedUniversity != null) {
//       FreshGraduateRegisterRequest graduated = FreshGraduateRegisterRequest(
//         fullName: fullName.text,
//         yearOfGraduation: int.parse(years.text),
//         university: _selectedUniversity!,
//         email: '',
//         password: '',
//       );
//       Navigator.pushNamed(
//         context,
//         FreshGraduatedRegister.routeName,
//         arguments: graduated,
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill all required fields.')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authService = GetIt.instance<AuthOnlineDS>(); // الحصول على AuthService المسجل
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: SingleChildScrollView(
//           physics: const NeverScrollableScrollPhysics(),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.03,
//                 ),
//                 Text(
//                   'Welcome to\nSkillBridge Dentistry',
//                   style: GoogleFonts.getFont('Inter',
//                       fontSize: 24, fontWeight: FontWeight.w400),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.015,
//                 ),
//                 Text(
//                   'Please complete the following',
//                   style: GoogleFonts.getFont('Inter',
//                       color: const Color(0xFF717070), fontSize: 20),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.04,
//                 ),
//                 BuildTextField(
//                   backgroundColor: Colors.white,
//                   hint: 'enter your name',
//                   label: 'Full Name',
//                   textInputType: TextInputType.emailAddress,
//                   validation: AppValidators.validateFullName,
//                   controller: fullName,
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.015,
//                 ),
//                 BuildTextField(
//                   backgroundColor: Colors.white,
//                   hint: 'enter your answer',
//                   label: 'Years of Graduation',
//                   textInputType: TextInputType.emailAddress,
//                   validation: AppValidators.validateEmail,
//                   controller: years,
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.015,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 5),
//                   child: Text(
//                     'University',
//                     style: GoogleFonts.getFont('Inter',
//                         color: const Color(0xFF717070),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400),
//                   ),
//                 ),
//                 DropdownButtonFormField<String>(
//                   value: _selectedUniversity,
//                   items: ['MUST', 'O6U', 'Elahram', 'Other']
//                       .map((university) => DropdownMenuItem(
//                           value: university, child: Text(university)))
//                       .toList(),
//                   onChanged: (value) =>
//                       setState(() => _selectedUniversity = value),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.015,
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.06,
//                 ),
//                 AppButton(
//                     text: 'Next',
//                     onTap: () {
//                       _proceedToRegistration();
//                     })
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
