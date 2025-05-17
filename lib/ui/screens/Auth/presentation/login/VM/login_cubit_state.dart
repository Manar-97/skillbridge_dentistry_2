import '../../../data/model/login_response_entity.dart';

sealed class LoginScreenState {}

class InitialScreenState extends LoginScreenState {}

class LoadingState extends LoginScreenState {}

class CloseDialog extends LoginScreenState {}

class EmptyFiledState extends LoginScreenState {}

class RememberMeBoxCheckedState extends LoginScreenState {
  bool isChecked;
  RememberMeBoxCheckedState(this.isChecked);
}

class LoginErrorState extends LoginScreenState {
  String? message;
  LoginErrorState(this.message);
}

class NavigateToForgetPasswordScreenState extends LoginScreenState {}

class LoginSuccessState extends LoginScreenState {
  UserEntity? user;
  LoginSuccessState(this.user);
}

class NavigateToSignUp extends LoginScreenState {}

class ChangePasswordVisibilityState extends LoginScreenState {
  bool isObscureText;
  ChangePasswordVisibilityState(this.isObscureText);
}
