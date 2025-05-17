import 'dart:io';
import 'package:injectable/injectable.dart';
import '../../data/model/response/pass_response.dart';
import '../api_result.dart';
import '../repositories/auth_repo.dart';

@injectable
class RegisterConsultantUseCase {
  final AuthRepository repository;

  RegisterConsultantUseCase(this.repository);

  Future<Result<GenericResponseModel>> call(
    String fullName,
    String email,
    String password,
    File resumePath,
    File photoPath,
    String yearOfExperience,
    String department,
    String biography,
  ) {
    return repository.consultantRegister(
      fullName,
      email,
      password,
      resumePath,
      photoPath,
      yearOfExperience,
      department,
      biography,
    );
  }
}
