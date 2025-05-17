// lib/ui/screens/Auth/presentation/password/verify/verify_code_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillbridge_dentistry/ui/base/failures/failures.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/pass_response.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/repositories/auth_repo.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  final AuthRepository authRepository;

  VerifyCodeCubit(this.authRepository) : super(VerifyCodeInitial());

  Future<void> verifyCode(GenericResponseModel request) async {
    emit(VerifyCodeLoading());
    // final result = await authRepository.verifyCode(request);
    //
    // result.fold(
    //       (failure) => emit(VerifyCodeError(failure)),
    //       (response) => emit(VerifyCodeSuccess(response)),
    // );
  }
}

abstract class VerifyCodeState {}

class VerifyCodeInitial extends VerifyCodeState {}

class VerifyCodeLoading extends VerifyCodeState {}

class VerifyCodeSuccess extends VerifyCodeState {
  final GenericResponseModel response;
  VerifyCodeSuccess(this.response);
}

class VerifyCodeError extends VerifyCodeState {
  final String message;
  VerifyCodeError(this.message);
}
