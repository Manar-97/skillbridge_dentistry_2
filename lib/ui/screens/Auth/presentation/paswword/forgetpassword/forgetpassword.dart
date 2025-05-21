import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/utils/widgets/appButton.dart';
import '../../../../../utils/dialog_utils.dart';
import '../../../../../utils/widgets/app_field.dart';
import '../../../data/model/request/pass_request.dart';
import '../verifycode/verifycode.dart';
import 'forgetpassword_vm.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  static const String routeName = 'forgetpassword';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController email = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void _sendOPT() {
    if (formKey.currentState!.validate()) {
      final emailText = email.text.trim();
      print('================Email entered is: $emailText');
      print(
        '================Type of email is: ${emailText.runtimeType}',
      );
      final request = ForgetPasswordRequest(email: emailText);
      context.read<ForgetPasswordCubit>().forgetPassword(request);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter your email")));
    }
  }

  @override
  void dispose() {
    email.dispose(); // علشان تمنع تسريب الذاكرة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetLoadingState) {
            showLoading(context);
          } else if (state is ForgetSuccessState) {
            hideLoading(context);
            print("Navigating to VerifyCode with email: ${email.text.trim()}");
            if (!mounted) return;
            print("Navigating to VerifyCode with email: ${email.text.trim()}");
            Navigator.pushNamed(
              context,
              VerifyCode.routeName,
              arguments: email.text.trim(), // بتمرر هنا الإيميل
            );
          } else if (state is ForgetErrorState) {
            hideLoading(context);
            if (!mounted) return; // ✅ هنا كمان
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
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enter your email to\nreceive an OTP',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    AppTextField(
                      hintText: 'enter your email',
                      text: 'E-mail',
                      validator:
                          (value) =>
                              (value == null || value.isEmpty)
                                  ? "Please enter your email"
                                  : null,
                      controller: email,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    AppButton(text: 'Send OTP', onTap: () => _sendOPT()),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
