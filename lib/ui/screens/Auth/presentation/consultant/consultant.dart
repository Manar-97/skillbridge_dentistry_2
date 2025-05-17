// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/request/register_request.dart';
// import 'package:skillbridge_dentistry/ui/screens/consultant_flow/register/UI/consultant_register.dart';
// import 'package:skillbridge_dentistry/ui/utils/widgets/appButton.dart';
// import '../../../../utils/validators.dart';
// import '../../../../utils/widgets/apptextfield.dart';
// import 'package:file_picker/file_picker.dart';
//
// import '../../data/repositories/auth_ds/auth_ds.dart'; // إضافة حزمة لاختيار الملفات
//
// class Consultant extends StatefulWidget {
//   const Consultant({super.key});
//   static const String routeName = 'consultant';
//   @override
//   State<Consultant> createState() => _ConsultantState();
// }
//
// class _ConsultantState extends State<Consultant> {
//   String? _selectedDepartment;
//   final TextEditingController fullName = TextEditingController();
//   final TextEditingController years = TextEditingController();
//   final TextEditingController bio = TextEditingController();
//   File? resumeFile;
//   File? photoFile;
//   final ImagePicker _picker = ImagePicker();
//   final _formKey = GlobalKey<FormState>();
//
//   // اختيار صورة الملف الشخصي
//   Future<void> _pickPhoto() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         photoFile = File(image.path);
//       });
//     }
//   }
//
//   // اختيار ملف السيرة الذاتية
//   Future<void> _pickResume() async {
//     FilePickerResult? result = await FilePicker.platform
//         .pickFiles(type: FileType.custom, allowedExtensions: [
//       'pdf',
//       'docx',
//       'doc',
//     ]);
//     if (result != null) {
//       setState(() {
//         resumeFile = File(result.files.single.path!);
//       });
//     }
//   }
//
//   void _proceedToRegistration() async {
//     if (fullName.text.isNotEmpty &&
//         years.text.isNotEmpty &&
//         _selectedDepartment != null &&
//         resumeFile != null &&
//         photoFile != null) {
//       ConsultantRegisterRequest consultant = ConsultantRegisterRequest(
//         fullName: fullName.text,
//         yearOfExperience: years.text,
//         department: _selectedDepartment!,
//         biography: bio.text,
//         email: '',
//         password: '',
//         resumePath: resumeFile!.path,
//         photoPath: photoFile!.path,
//       );
//       Navigator.pushNamed(
//         context,
//         ConsultantRegister.routeName,
//         arguments: consultant,
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
//     final authService =
//         GetIt.instance<AuthOnlineDS>(); // الحصول على AuthService المسجل
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: SingleChildScrollView(
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
//                   hint: 'enter your full name',
//                   label: 'Full Name',
//                   textInputType: TextInputType.text,
//                   validation: AppValidators.validateFullName,
//                   controller: fullName,
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.015,
//                 ),
//                 BuildTextField(
//                   hint: 'Years of Experience',
//                   label: 'Years of Experience',
//                   textInputType: TextInputType.number,
//                   validation: AppValidators.validateEmail,
//                   controller: years,
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.015,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 5),
//                   child: Text('Department/Specialization',
//                       style: GoogleFonts.inter(
//                           fontSize: 14, color: Colors.grey[700])),
//                 ),
//                 DropdownButtonFormField<String>(
//                   style: const TextStyle(color: Colors.black54)
//                       .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
//                   value: _selectedDepartment,
//                   items: [
//                     'Periodontics',
//                     'Orthodontics',
//                     'Pathology Dentistry',
//                     'Oral Surgery',
//                     'Operative Dentistry',
//                     'Other'
//                   ]
//                       .map((dep) =>
//                           DropdownMenuItem(value: dep, child: Text(dep)))
//                       .toList(),
//                   onChanged: (value) =>
//                       setState(() => _selectedDepartment = value),
//                   validator: (value) =>
//                       value == null ? 'Please select a department' : null,
//                   decoration: InputDecoration(
//                       filled: true,
//                       hintText: 'Select your department',
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5)),
//                       hintStyle: const TextStyle(color: Colors.grey)
//                           .copyWith(fontSize: 14)),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.015,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     _pickResume();
//                   },
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('Resume link'),
//                       Container(
//                         width: double.infinity,
//                         height: MediaQuery.of(context).size.height * 0.07,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.grey[200],
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(15),
//                           child: Text(
//                             resumeFile != null
//                                 ? resumeFile!.path.split('/').last
//                                 : 'No file selected',
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(fontSize: 18),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.015,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     _pickPhoto();
//                   },
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('choose profile photo'),
//                       Container(
//                         width: double.infinity,
//                         height: MediaQuery.of(context).size.height * 0.07,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.grey[200],
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(15),
//                           child: Text(
//                             photoFile != null
//                                 ? photoFile!.path.split('/').last
//                                 : 'No file selected',
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(fontSize: 18),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.015,
//                 ),
//                 BuildTextField(
//                   hint: 'Tell us about yourself briefly',
//                   label: 'Short Biography',
//                   textInputType: TextInputType.text,
//                   validation: AppValidators.validateEmail,
//                   controller: bio,
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
