import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/general_response.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import '../repositories/auth_repo.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepository authRepository;

  ResetPasswordUseCase(this.authRepository);

  Future<Result<GenericResponseModel>> call(
    String email,
    String otp,
    String newPassword,
    String rePassword,
  ) async {
    return await authRepository.resetPassword(
      email,
      otp,
      newPassword,
      rePassword,
    );
  }
}
