import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/request/pass_request.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/pass_response.dart';
import '../../../domain/api_result.dart';
import '../../../domain/repositories/auth_repo.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepository authRepository;

  @factoryMethod
  ForgetPasswordCubit(this.authRepository) : super(ForgetPasswordInitial());

  Future<void> forgetPassword(ForgetPasswordRequest request) async {
    emit(BaseLoadingState());
    final Result<GenericResponseModel> result = await authRepository
        .forgetPassword(request.email!);
    result is Success<GenericResponseModel>
        ? emit(BaseSuccessState(result.data!))
        : emit(
          BaseErrorState((result as ServerFailure).message ?? "Unknown error"),
        );
  }
}

abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class BaseLoadingState extends ForgetPasswordState {}

class BaseSuccessState extends ForgetPasswordState {
  final GenericResponseModel response;

  BaseSuccessState(this.response);
}

class BaseErrorState extends ForgetPasswordState {
  final String message;
  BaseErrorState(this.message);
}
