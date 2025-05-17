// import '../../../data/model/login_response_entity.dart';
// import '../../../domain/api_result.dart';
// import '../../../domain/usecase/login_usecase.dart';
// import 'login_action.dart';
// import 'login_cubit_state.dart';
// import 'login_vm.dart';
//
// class LoginActionHandler {
//   final LoginUseCase loginUseCase;
//   final LoginCubit loginViewModel;
//   late UserEntity user;
//   late String? errorMessage;
//   LoginActionHandler(this.loginUseCase, this.loginViewModel);
//
//   _changePasswordVisibility() {
//     loginViewModel.isObscureText = !loginViewModel.isObscureText;
//     loginViewModel
//         .emitState(ChangePasswordVisibilityState(loginViewModel.isObscureText));
//   }
//
//   void handleAction(LoginScreenActions action) {
//     switch (action) {
//       case LoginAction():
//         _login();
//         break;
//       case ForgetPasswordNavigatorAction():
//         _navigateToForgetPassword();
//         break;
//       case CheckedBoxAction():
//         _handleCheckboxAction(action);
//       case LoginFormInputValidate():
//         break;
//       case InitialScreenAction():
//         loginViewModel.emitState(InitialScreenState());
//       case ClickedSignUpButton():
//         _navigateToSignUp();
//         break;
//       case ChangePasswordVisibilityAction():
//         _changePasswordVisibility();
//         break;
//     }
//   }
//
//   void _login() async {
//     loginViewModel.emitState(LoadingState());
//     String email = loginViewModel.controllersManager.emailController.text;
//     String password = loginViewModel.controllersManager.passwordController.text;
//     final response = await loginUseCase.call(email, password);
//     switch (response) {
//       case Success():
//         {
//           user = response.data!.user!;
//           loginViewModel.emitState(CloseDialog());
//           loginViewModel.emitState(LoginSuccessState(user));
//           break;
//         }
//       case ServerFailure():
//         {
//           loginViewModel.emitState(CloseDialog());
//           loginViewModel.emitState(LoginErrorState(response.message));
//           break;
//         }
//     }
//   }
//
//   void _navigateToForgetPassword() {
//     loginViewModel.emitState(NavigateToForgetPasswordScreenState());
//   }
//
//   void _handleCheckboxAction(CheckedBoxAction action) {
//     loginViewModel.emitState(RememberMeBoxCheckedState(action.isBoxChecked));
//   }
//
//   void _navigateToSignUp() {
//     loginViewModel.emitState(NavigateToSignUp());
//     loginViewModel.emitState(InitialScreenState());
//   }
// }
