import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/paswword/verifycode/verifycode_vm.dart';
import 'package:skillbridge_dentistry/ui/utils/dialog_utils.dart';
import 'package:skillbridge_dentistry/ui/utils/widgets/appButton.dart';
import '../../../data/model/request/pass_request.dart';
import '../../../data/model/request/verifyOTP_request.dart';
import '../forgetpassword/forgetpassword_vm.dart';
import '../resetpassword/resetpassword.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({super.key, required this.email});
  final String email;
  static const String routeName = 'verifycode';

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final formKey = GlobalKey<FormState>();
  late String otpCode = '';

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final args = ModalRoute.of(context)?.settings.arguments;
  //   print('===========================args: $args');
  //   if (args != null && args is String && args.isNotEmpty) {
  //     widget.email = args;
  //     print('✅ Received email in VerifyCode: $email');
  //   } else {
  //     email = null;
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Email not received. Please try again.')),
  //       );
  //       Navigator.pop(context);
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();

    // لو تأكدت من ان الايميل فاضي، ارجع للخلف مع رسالة
    if (widget.email.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email not received. Please try again.'),
          ),
        );
        Navigator.pop(context);
      });
    }
  }

  void _submitOtp() {
    if (otpCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a 6-digit OTP code')),
      );
      return;
    }
    context.read<VerifyOtpCubit>().verifyOtp(
      VerifyOtpRequest(email: widget.email, otp: otpCode),
    );
  }

  void _resendCode() {
    final request = ForgetPasswordRequest(email: widget.email);
    context.read<ForgetPasswordCubit>().forgetPassword(request);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('OTP has been resent')));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
          listener: (context, state) {
            if (state is BaseLoadingState) {
              showLoading(context);
            } else if (state is BaseSuccessState) {
              hideLoading(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          ResetPassword(email: widget.email, otpCode: otpCode),
                ),
              );
            } else if (state is BaseErrorState) {
              hideLoading(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder:
              (context, state) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight:
                            MediaQuery.of(context).size.height -
                            32, // padding compensation
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 40),
                            Text(
                              'Check your email',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'We sent a code, please enter it',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: const Color(0xFF929292),
                              ),
                            ),
                            const SizedBox(height: 30),
                            OtpTextField(
                              borderRadius: BorderRadius.circular(4),
                              numberOfFields: 6,
                              fieldHeight: 45,
                              borderColor: const Color(0xFF929292),
                              showFieldAsBox: true,
                              onSubmit: (String code) {
                                setState(() {
                                  otpCode = code;
                                });
                                _submitOtp();
                              },
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Haven’t got the email yet?',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF929292),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _resendCode,
                                  child: Text(
                                    ' Resend code',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF5D9F99),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            AppButton(
                              text: 'Verify Code',
                              onTap: () {
                                if (otpCode.length != 6) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Please enter a 6-digit OTP code',
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                _submitOtp();
                              },
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
