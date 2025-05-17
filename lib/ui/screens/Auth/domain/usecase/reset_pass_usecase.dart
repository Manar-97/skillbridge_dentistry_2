import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/pass_response.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import '../repositories/auth_repo.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepository authRepository;

  ResetPasswordUseCase(this.authRepository);

  Future<Result<GenericResponseModel>> call(
    String rePassword,
    String newPassword,
    String email,
    String token,
  ) async {
    return await authRepository.resetPassword(
        rePassword, newPassword, email, token);
  }
}
