import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/request/verifyOTP_request.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/general_response.dart';
import '../../../domain/api_result.dart';
import '../../../domain/repositories/auth_repo.dart';

@injectable
class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final AuthRepository authRepository;

  @factoryMethod
  VerifyOtpCubit(this.authRepository) : super(VerifyOtpInitial());

  Future<void> verifyOtp(VerifyOtpRequest request) async {
    print('VerifyOtpCubit: email=${request.email}, otp=${request.otp}');
    emit(BaseLoadingState());
    final Result<GenericResponseModel> result = await authRepository.verifyOtp(
      request.email,
      request.otp,
    );
    result is Success<GenericResponseModel>
        ? emit(BaseSuccessState(result.data!))
        : emit(
          BaseErrorState((result as ServerFailure).message ?? "Unknown error"),
        );
  }
}

abstract class VerifyOtpState {}

class VerifyOtpInitial extends VerifyOtpState {}

class BaseLoadingState extends VerifyOtpState {}

class BaseSuccessState extends VerifyOtpState {
  final GenericResponseModel response;

  BaseSuccessState(this.response);
}

class BaseErrorState extends VerifyOtpState {
  final String message;
  BaseErrorState(this.message);
}
