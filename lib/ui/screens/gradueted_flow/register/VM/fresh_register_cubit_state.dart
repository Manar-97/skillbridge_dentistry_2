sealed class RegisterFreshGraduatedCubitState {}

class InitReg extends RegisterFreshGraduatedCubitState {}

class LoadingReg extends RegisterFreshGraduatedCubitState {}

class SuccessReg extends RegisterFreshGraduatedCubitState {}

class FailReg extends RegisterFreshGraduatedCubitState {
  String? error;
  FailReg({this.error});
}

class HideLoadingDialog extends RegisterFreshGraduatedCubitState {}

class NavigateToLogin extends RegisterFreshGraduatedCubitState {}

class ErrorInField extends RegisterFreshGraduatedCubitState {}
