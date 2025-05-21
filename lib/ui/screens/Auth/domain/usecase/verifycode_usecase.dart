import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/general_response.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import '../repositories/auth_repo.dart';

@injectable
class VerifyOtpUseCase {
  final AuthRepository authRepository;

  VerifyOtpUseCase(this.authRepository);

  Future<Result<GenericResponseModel>> call(String email, String otp) async {
    return await authRepository.verifyOtp(email, otp);
  }
}
