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
  const ResetPassword({super.key});
  static const String routeName = 'resetpassword';

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ResetPasswordCubit cubit = getIt();
  String token = ''; // يفترض أن ترسله من صفحة التحقق

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    token = ModalRoute.of(context)?.settings.arguments as String? ?? '';
  }

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      final newPassword = password.text.trim();
      final confirmPassword = confirmpassword.text.trim();

      // Get the email and token (you should pass this from the ForgotPassword or other relevant screens)
      final email = ''; // Get this value from somewhere
      final token = ''; // Get this value from somewhere

      final request = ResetPasswordRequest(
        email: email,
        token: token,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      cubit.resetPassword(
          request); // Pass the ResetPasswordRequest object to the cubit
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is BaseLoadingState) {
            hideLoading(context);
            showMessage(context,
                body: 'Password reset successfully!',
                posButtonTitle: 'OK',
                onPosButtonClick: () =>
                    Navigator.pushReplacementNamed(context, Login.routeName));
          } else if (state is BaseErrorState) {
            hideLoading(context);
            showMessage(context,
                body: state.failures.errorMessage, posButtonTitle: 'OK');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Reset Password',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                AppTextField(
                  hintText: 'enter your new password',
                  text: 'New Password',
                  validator: (value) {
                    if (value != password.text) return "Passwords do not match";
                    return null;
                  },
                  controller: password,
                  obscureText: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                AppTextField(
                  hintText: 'confirm password',
                  text: 'Confirm Password',
                  validator: (value) {
                    if (value != password.text) return "Passwords do not match";
                    return null;
                  },
                  controller: confirmpassword,
                  obscureText: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                AppButton(text: 'Reset Password', onTap: _resetPassword),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
