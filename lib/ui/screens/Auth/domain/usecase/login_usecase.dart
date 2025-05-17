import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import '../../data/model/response/login_response.dart';
import '../repositories/auth_repo.dart';

@injectable
class LoginUseCase {
  AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<Result<LoginResponse>> call(
      String email, String password) async {
    return await authRepository.login(email, password);
  }
}
