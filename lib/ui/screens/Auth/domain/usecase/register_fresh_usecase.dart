import 'package:injectable/injectable.dart';
import '../../data/model/response/auth_response.dart';
import '../api_result.dart';
import '../repositories/auth_repo.dart';

@injectable
class RegisterFreshGraduatedUseCase {
  final AuthRepository repository;

  RegisterFreshGraduatedUseCase(this.repository);

  Future<Result<AuthResponse>> call(
    String fullName,
    String email,
    String password,
    String yearOfGraduation,
    String university,
    String department,
  ) {
    return repository.freshRegister(
        fullName, email, password, yearOfGraduation, university, department);
  }
}
