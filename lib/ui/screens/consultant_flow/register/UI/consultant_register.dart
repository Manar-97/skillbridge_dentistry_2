import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../utils/widgets/appButton.dart';
import '../../../../utils/widgets/app_field.dart';
import '../../../Auth/presentation/login/UI/login.dart';
import '../../main_consul_screen.dart';
import '../VM/consultant_register_vm.dart';

class ConsultantRegister extends StatefulWidget {
  const ConsultantRegister({super.key});
  static const String routeName = 'consultantRegister';

  @override
  State<ConsultantRegister> createState() => _ConsultantRegisterState();
}

class _ConsultantRegisterState extends State<ConsultantRegister> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController rePassword = TextEditingController();
  final TextEditingController yearOfExperience = TextEditingController();
  final TextEditingController biography = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? resumePath;
  File? photoPath;
  String? department;
  final ImagePicker _picker = ImagePicker();

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  void _submit(BuildContext context) {
    if (formKey.currentState!.validate() &&
        photoPath != null &&
        resumePath != null &&
        department != null) {
      context.read<RegisterConsultantCubit>().registerConsultant(
        fullName.text,
        email.text,
        password.text,
        resumePath!,
        photoPath!,
        yearOfExperience.text,
        department!,
        biography.text,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields.")),
      );
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    fullName.dispose();
    yearOfExperience.dispose();
    biography.dispose();
    rePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegisterConsultantCubit, RegisterConsultantCubitState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(
              context,
              MainConsultantScreen.routeName,
              arguments: {'fullName': fullName.text, 'email': email.text},
            );
          } else if (state is AuthFailure) {
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text('Error'),
                    content: Text(state.message),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          }
        },
        builder:
            (context, state) => Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Text(
                    'Register',
                    style: GoogleFonts.getFont(
                      'Inter',
                      color: const Color(0xFF5D9F99),
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  Text(
                    'Create your new account',
                    style: GoogleFonts.getFont(
                      'Inter',
                      color: const Color(0xFF898989),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  _buildInputFields(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  state is AuthLoading
                      ? const Center(child: CircularProgressIndicator())
                      : AppButton(
                        text: 'Sign Up',
                        onTap: () => _submit(context),
                      ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            Login.routeName,
                          );
                        },
                        child: Text(
                          ' Sign in',
                          style: GoogleFonts.getFont(
                            'Inter',
                            color: const Color(0xFF5D9F99),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ],
              ),
            ),
      ),
    );
  }

  Widget _buildInputFields() {
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                hintText: 'enter your full name',
                text: 'Full Name',
                validator:
                    (value) =>
                        (value == null || value.isEmpty)
                            ? "Please enter your full name"
                            : null,
                controller: fullName,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              AppTextField(
                hintText: 'enter your email',
                text: 'E-mail',
                validator:
                    (value) =>
                        (value == null || value.isEmpty)
                            ? "Please enter an email"
                            : null,
                controller: email,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AppTextField(
                hintText: 'enter your password',
                text: 'Password',
                validator: passwordValidator,
                controller: password,
                obscureText: true,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AppTextField(
                hintText: 'Years of Experience',
                text: 'Years of Experience',
                validator:
                    (value) =>
                        (value == null || value.isEmpty)
                            ? "Please enter years of experience"
                            : null,
                controller: yearOfExperience,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Department/Specialization',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              DropdownButtonFormField<String>(
                style: const TextStyle(
                  color: Colors.black54,
                ).copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                value: department,
                items:
                    [
                          'Periodontics',
                          'Orthodontics',
                          'Pathology Dentistry',
                          'Oral Surgery',
                          'Operative Dentistry',
                          'Other',
                        ]
                        .map(
                          (dep) =>
                              DropdownMenuItem(value: dep, child: Text(dep)),
                        )
                        .toList(),
                onChanged: (value) => setState(() => department = value!),
                validator:
                    (value) =>
                        value == null ? 'Please select a department' : null,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Select your department',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ).copyWith(fontSize: 14),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              GestureDetector(
                onTap: () {
                  _pickResume();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Resume link'),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          resumePath != null
                              ? resumePath!.path.split('/').last
                              : 'No file selected',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              GestureDetector(
                onTap: () {
                  _pickPhoto();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('choose profile photo'),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          photoPath != null
                              ? photoPath!.path.split('/').last
                              : 'No file selected',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              AppTextField(
                hintText: 'Tell us about yourself briefly',
                text: 'Short Biography',
                validator:
                    (value) =>
                        (value == null || value.isEmpty)
                            ? "Please enter short bio"
                            : null,
                controller: biography,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickPhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        photoPath = File(image.path);
      });
    }
  }

  Future<void> _pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'doc'],
    );
    if (result != null) {
      setState(() {
        resumePath = File(result.files.single.path!);
      });
    }
  }
}
