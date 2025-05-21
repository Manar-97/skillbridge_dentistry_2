// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/login/UI/login.dart';
// import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/paswword/resetpassword/resetpassword_vm.dart';
// import 'package:skillbridge_dentistry/ui/utils/dialog_utils.dart';
// import 'package:skillbridge_dentistry/ui/utils/widgets/appButton.dart';
// import '../../../../../../di/di.dart';
// import '../../../../../utils/widgets/app_field.dart';
// import '../../../data/model/request/pass_request.dart';
//
// class ResetPassword extends StatefulWidget {
//   const ResetPassword({super.key, required this.email, required this.otpCode});
//   final String email;
//   final String otpCode;
//   static const String routeName = 'resetpassword';
//
//   @override
//   State<ResetPassword> createState() => _ResetPasswordState();
// }
//
// class _ResetPasswordState extends State<ResetPassword> {
//   final TextEditingController password = TextEditingController();
//   final TextEditingController confirmpassword = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final ResetPasswordCubit cubit = getIt();
//
//   void _resetPassword() {
//     if (_formKey.currentState!.validate()) {
//       final newPassword = password.text.trim();
//       final confirmPassword = confirmpassword.text.trim();
//
//       final request = ResetPasswordRequest(
//         email: widget.email,
//         otp: widget.otpCode,
//         newPassword: newPassword,
//         confirmPassword: confirmPassword,
//       );
//
//       cubit.resetPassword(request);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
//         listener: (context, state) {
//           if (state is BaseLoadingState) {
//             showLoading(context);
//           } else if (state is BaseSuccessState) {
//             hideLoading(context);
//             showMessage(
//               context,
//               body: 'Password reset successfully!',
//               posButtonTitle: 'OK',
//               onPosButtonClick: () {
//                 Navigator.pushReplacementNamed(context, Login.routeName);
//               },
//             );
//           } else if (state is BaseErrorState) {
//             hideLoading(context);
//             showMessage(context, body: state.message, posButtonTitle: 'OK');
//           }
//         },
//         builder:
//             (context, state) => Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Reset Password',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.getFont(
//                         'Inter',
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.05),
//                     AppTextField(
//                       hintText: 'Enter your new password',
//                       text: 'New Password',
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Password cannot be empty';
//                         }
//                         if (value.length < 6) {
//                           return 'Password must be at least 6 characters';
//                         }
//                         return null;
//                       },
//                       controller: password,
//                       obscureText: true,
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                     AppTextField(
//                       hintText: 'Confirm password',
//                       text: 'Confirm Password',
//                       validator: (value) {
//                         if (value != password.text) {
//                           return "Passwords do not match";
//                         }
//                         return null;
//                       },
//                       controller: confirmpassword,
//                       obscureText: true,
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.1),
//                     AppButton(text: 'Reset Password', onTap: _resetPassword),
//                   ],
//                 ),
//               ),
//             ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/login/UI/login.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/paswword/resetpassword/resetpassword_vm.dart';
import 'package:skillbridge_dentistry/ui/utils/dialog_utils.dart';
import 'package:skillbridge_dentistry/ui/utils/widgets/appButton.dart';
import '../../../../../../di/di.dart';
import '../../../../../utils/widgets/app_field.dart';
import '../../../data/model/request/pass_request.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.email, required this.otpCode});

  final String email;
  final String otpCode;

  static const String routeName = 'resetpassword';

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  void _resetPassword() {
    if (_formKey.currentState!.validate() && !_isProcessing) {
      final request = ResetPasswordRequest(
        email: widget.email,
        otp: widget.otpCode,
        newPassword: password.text.trim(),
        confirmPassword: confirmpassword.text.trim(),
      );
      context.read<ResetPasswordCubit>().resetPassword(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is BaseLoadingState) {
            setState(() => _isProcessing = true);
            showLoading(context);
          } else if (state is BaseSuccessState) {
            setState(() => _isProcessing = false);
            hideLoading(context);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Success'),
                  content: Text('Password reset successfully!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pop(); // خطوة 1: تغلق رسالة الـ Dialog
                        Navigator.pushReplacementNamed(
                          context,
                          Login.routeName,
                        ); // خطوة 2: تنقل الشاشة
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else if (state is BaseErrorState) {
            setState(() => _isProcessing = false);
            hideLoading(context);
            showMessage(context, body: state.message, posButtonTitle: 'OK');
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Reset Password',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  AppTextField(
                    hintText: 'Enter your new password',
                    text: 'New Password',
                    controller: password,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      if (!RegExp(
                        r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$',
                      ).hasMatch(value)) {
                        return 'Password must include upper case, number and special character';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    hintText: 'Confirm password',
                    text: 'Confirm Password',
                    controller: confirmpassword,
                    obscureText: true,
                    validator: (value) {
                      if (value != password.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  AppButton(
                    text: _isProcessing ? 'Please wait...' : 'Reset Password',
                    onTap: _isProcessing ? null : _resetPassword,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
