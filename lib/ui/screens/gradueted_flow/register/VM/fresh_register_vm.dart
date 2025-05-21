import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/usecase/register_fresh_usecase.dart';
import '../../../Auth/data/model/response/auth_response.dart';
import '../../../Auth/domain/api_result.dart';

@injectable
class RegisterFreshGraduatedCubit
    extends Cubit<RegisterFreshGraduatedCubitState> {
  RegisterFreshGraduatedUseCase registerFreshGraduatedUseCase;
  @factoryMethod
  RegisterFreshGraduatedCubit(this.registerFreshGraduatedUseCase)
    : super(RegisterFreshGraduatedInitial());

  Future<void> registerFreshGraduated(
    String fullName,
    String email,
    String password,
    String yearOfGraduation,
    String university,
    String department,
  ) async {
    emit(AuthLoading());
    final Result<AuthResponse> result = await registerFreshGraduatedUseCase(
      fullName,
      email,
      password,
      yearOfGraduation,
      university,
      department,
    );
    result is Success<AuthResponse>
        ? emit(AuthSuccess(result.data!))
        : emit(
          AuthFailure((result as ServerFailure).message ?? "Unknown error"),
        );
  }
}

abstract class RegisterFreshGraduatedCubitState {}

class RegisterFreshGraduatedInitial extends RegisterFreshGraduatedCubitState {}

class AuthLoading extends RegisterFreshGraduatedCubitState {}

class AuthSuccess extends RegisterFreshGraduatedCubitState {
  final AuthResponse freshGraduatedRegistResponse;
  AuthSuccess(this.freshGraduatedRegistResponse);
}

class AuthFailure extends RegisterFreshGraduatedCubitState {
  final String message;
  AuthFailure(this.message);
}
