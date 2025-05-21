import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/request/pass_request.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/general_response.dart';
import '../../../domain/api_result.dart';
import '../../../domain/repositories/auth_repo.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepository authRepository;

  @factoryMethod
  ForgetPasswordCubit(this.authRepository) : super(ForgetPasswordInitial());

  Future<void> forgetPassword(ForgetPasswordRequest request) async {
    emit(ForgetLoadingState());
    final Result<GenericResponseModel> result = await authRepository
        .forgetPassword(request.email);
    print('Sending email to reset password: ${request.email}');
    result is Success<GenericResponseModel>
        ? emit(ForgetSuccessState(result.data!))
        : emit(
          ForgetErrorState(
            (result as ServerFailure).message ?? "Unknown error",
          ),
        );
  }
}

abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetLoadingState extends ForgetPasswordState {}

class ForgetSuccessState extends ForgetPasswordState {
  final GenericResponseModel response;

  ForgetSuccessState(this.response);
}

class ForgetErrorState extends ForgetPasswordState {
  final String message;
  ForgetErrorState(this.message);
}
