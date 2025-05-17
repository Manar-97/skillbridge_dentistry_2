import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/paswword/resetpassword/resetpassword.dart';
import 'package:skillbridge_dentistry/ui/utils/widgets/appButton.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({super.key});
  static const String routeName = 'verifycode';

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final formKey = GlobalKey<FormState>();

  late String email;
  String? verificationCode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    email = ModalRoute.of(context)!.settings.arguments as String;
  }

  void _verifyCode() async {
    if (verificationCode == null || verificationCode!.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the full code')),
      );
      return;
    }

    // TODO: Replace with actual API call to verify the code
    final bool apiResponse = true; // pretend API says OK

    if (apiResponse) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          title: Text("Success"),
          content: Text("Code verified. Redirecting..."),
        ),
      );

      await Future.delayed(const Duration(seconds: 5));

      if (context.mounted) {
        Navigator.pop(context); // Close dialog
        Navigator.pushNamed(
          context,
          ResetPassword.routeName,
          arguments: {
            'email': email,
            'token': verificationCode!,
          },
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid code, please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Check your email',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'We sent a code, please enter it',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont('Inter',
                    fontSize: 16, color: const Color(0xFF929292)),
              ),
              const SizedBox(height: 30),
              OtpTextField(
                borderRadius: BorderRadius.circular(4),
                numberOfFields: 4,
                fieldHeight: 45,
                fieldWidth: 55,
                borderColor: const Color(0xFF929292),
                showFieldAsBox: true,
                onCodeChanged: (String code) {},
                onSubmit: (String code) {
                  setState(() {
                    verificationCode = code;
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Haven’t got the email yet?',
                    style: GoogleFonts.getFont('Inter',
                        color: const Color(0xFF929292),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Trigger resend code logic if needed
                    },
                    child: Text(
                      ' Resend code',
                      style: GoogleFonts.getFont('Inter',
                          color: const Color(0xFF5D9F99),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              AppButton(
                text: 'Verify Code',
                onTap: _verifyCode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
