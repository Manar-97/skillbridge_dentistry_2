import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillbridge_dentistry/ui/base/failures/failures.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/request/pass_request.dart';

import '../../../domain/repositories/auth_repo.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository authRepository;

  ResetPasswordCubit(this.authRepository) : super(ResetPasswordInitial());

  void resetPassword(ResetPasswordRequest request) async {
    emit(BaseLoadingState());
    // final result = await authRepository.resetPassword(request);
    //
    //   result.fold(
    //     (failure) => emit(BaseErrorState(failures: failure)),
    //     (response) => emit(BaseSuccessState(response)),
    //   );
  }
}

abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class BaseLoadingState extends ResetPasswordState {}

class BaseSuccessState extends ResetPasswordState {
  final dynamic response;

  BaseSuccessState(this.response);
}

class BaseErrorState extends ResetPasswordState {
  final failures;

  BaseErrorState({required this.failures});
}
