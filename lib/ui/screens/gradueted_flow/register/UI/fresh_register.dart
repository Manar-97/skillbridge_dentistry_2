import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/mains_dentist_creen.dart';
import '../../../../utils/widgets/appButton.dart';
import '../../../../utils/widgets/app_field.dart';
import '../../../Auth/presentation/login/UI/login.dart';
import '../VM/fresh_register_vm.dart';

class FreshGraduatedRegister extends StatefulWidget {
  const FreshGraduatedRegister({super.key});
  static const String routeName = 'register';
  @override
  State<FreshGraduatedRegister> createState() => _FreshGraduatedRegisterState();
}

class _FreshGraduatedRegisterState extends State<FreshGraduatedRegister> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController rePassword = TextEditingController();
  final TextEditingController yearOfGraduation = TextEditingController();
  String? university;
  String? department;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _submit(BuildContext context) {
    if (formKey.currentState!.validate() &&
        university != null &&
        department != null) {
      context.read<RegisterFreshGraduatedCubit>().registerFreshGraduated(
        fullName.text,
        email.text,
        password.text,
        yearOfGraduation.text,
        university!,
        department!,
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
    yearOfGraduation.dispose();
    rePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<
        RegisterFreshGraduatedCubit,
        RegisterFreshGraduatedCubitState
      >(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(
              context,
              MainDentistScreen.routeName,
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
                      fontWeight: FontWeight.w500,
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
                          Navigator.pushNamed(context, Login.routeName);
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
                hintText: 'enter your name',
                text: 'Full Name',
                validator:
                    (value) =>
                        value == null ? "Please select a department" : null,
                controller: fullName,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              AppTextField(
                hintText: 'enter your email',
                text: 'E-mail',
                validator:
                    (value) =>
                        value == null ? "Please select a department" : null,
                controller: email,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AppTextField(
                hintText: 'enter your password',
                text: 'Password',
                validator:
                    (value) =>
                        value == null ? "Please select a department" : null,
                controller: password,
                obscureText: true,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AppTextField(
                hintText: 'enter your answer',
                text: 'Years of Graduation',
                validator:
                    (value) =>
                        value == null ? "Please select a department" : null,
                controller: yearOfGraduation,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'University',
                  style: GoogleFonts.getFont(
                    'Inter',
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
              ),
              DropdownButtonFormField<String>(
                style: const TextStyle(
                  color: Colors.black54,
                ).copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                value: university,
                items:
                    ['MUST', 'O6U', 'Elahram', 'Other']
                        .map(
                          (university) => DropdownMenuItem(
                            value: university,
                            child: Text(university),
                          ),
                        )
                        .toList(),
                onChanged: (value) => setState(() => university = value!),
                validator:
                    (value) =>
                        value == null ? 'Please select a university' : null,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Select your University',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ).copyWith(fontSize: 14),
                ),
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
                          'Pathology Dentistry',
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
            ],
          ),
        ),
      ),
    );
  }
}
