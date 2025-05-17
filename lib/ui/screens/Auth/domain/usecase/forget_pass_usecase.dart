import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/pass_response.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import '../repositories/auth_repo.dart';

@injectable
class ForgetPasswordUseCase {
  final AuthRepository authRepository;

  ForgetPasswordUseCase(this.authRepository);

  Future<Result<GenericResponseModel>> call(String email) async {
    return await authRepository.forgetPassword(email);
  }
}
