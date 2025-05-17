import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/login/VM/login_cubit_state.dart';
import 'package:skillbridge_dentistry/ui/utils/widgets/appButton.dart';
import '../../../../../utils/widgets/app_field.dart';
import '../../../../consultant_flow/main_consul_screen.dart';
import '../../../../splash_and_onboarding/persona/persona.dart';
import '../../paswword/forgetpassword/forgetpassword.dart';
import '../VM/login_vm.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const String routeName = 'login';
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _submit(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(email.text, password.text);
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(
              context,
              MainConsultantScreen.routeName,arguments: {}
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
            print(state.message);
          }
        },
        builder:
            (context, state) => Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      Text(
                        'Welcome Back',
                        style: GoogleFonts.getFont(
                          'Inter',
                          color: const Color(0xFF5D9F99),
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      Text(
                        'Login to your account',
                        style: GoogleFonts.getFont(
                          'Inter',
                          color: const Color(0xFF898989),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      AppTextField(
                        text: 'Email',
                        hintText: 'Enter your email',
                        controller: email,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Email is required';
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      AppTextField(
                        text: 'Password',
                        hintText: 'Enter password',
                        controller: password,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Password  is required';
                          return null;
                        },
                        obscureText: true,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ForgotPassword.routeName,
                          );
                        },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'Forget Password?',
                            style: GoogleFonts.getFont(
                              'Inter',
                              color: const Color(0xFF5D9F99),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      state is AuthLoading
                          ? const Center(child: CircularProgressIndicator())
                          : AppButton(
                            text: 'Login',
                            onTap: () => _submit(context),
                          ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: GoogleFonts.getFont(
                              'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PersonaScreen.routeName,
                              );
                            },
                            child: Text(
                              ' Sign up',
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
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
