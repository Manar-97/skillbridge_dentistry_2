import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/auth_response.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import '../repositories/auth_repo.dart';

@injectable
class LoginUseCase {
  AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<Result<AuthResponse>> call(String email, String password) async {
    return await authRepository.login(email, password);
  }
}
