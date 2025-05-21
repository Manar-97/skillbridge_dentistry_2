import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/request/pass_request.dart';
import '../../../data/model/response/general_response.dart';
import '../../../domain/api_result.dart';
import '../../../domain/repositories/auth_repo.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository authRepository;

  ResetPasswordCubit(this.authRepository) : super(ResetPasswordInitial());

  Future<void> resetPassword(ResetPasswordRequest request) async {
    emit(BaseLoadingState());
    final Result<GenericResponseModel> result = await authRepository
        .resetPassword(
          request.email!,
          request.otp!,
          request.newPassword!,
          request.confirmPassword!,
        );
    result is Success<GenericResponseModel>
        ? emit(BaseSuccessState(result.data!))
        : emit(
          BaseErrorState((result as ServerFailure).message ?? "Unknown error"),
        );
  }
}

abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class BaseLoadingState extends ResetPasswordState {}

class BaseSuccessState extends ResetPasswordState {
  final GenericResponseModel response;

  BaseSuccessState(this.response);
}

class BaseErrorState extends ResetPasswordState {
  final String message;

  BaseErrorState(this.message);
}
