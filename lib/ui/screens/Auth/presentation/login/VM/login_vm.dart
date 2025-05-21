import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/auth_response.dart';
import '../../../data/repositories/auth_ds/auth_ds.dart';
import '../../../domain/api_result.dart';
import '../../../domain/usecase/login_usecase.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final AuthOfflineDS authOfflineDS;

  LoginCubit(this.loginUseCase, this.authOfflineDS) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final Result<AuthResponse> result = await loginUseCase(email, password);

    if (result is Success<AuthResponse>) {
      final token = result.data!.token ?? '';
      if (token.isNotEmpty) {
        await authOfflineDS.saveToken(token);
      } else {
        print('==================Token not found');
      }
      emit(AuthSuccess(result.data!));
    } else {
      emit(AuthFailure((result as ServerFailure).message ?? "Unknown error"));
    }
  }
}

// login_state.dart

abstract class LoginState {}

class LoginInitial extends LoginState {}

class AuthLoading extends LoginState {}

class AuthSuccess extends LoginState {
  final AuthResponse loginResponse;
  AuthSuccess(this.loginResponse);
}

class AuthFailure extends LoginState {
  final String message;
  AuthFailure(this.message);
}
