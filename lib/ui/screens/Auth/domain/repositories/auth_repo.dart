import 'dart:io';
import '../../data/model/request/pass_request.dart';
import '../../data/model/response/login_response.dart';
import '../../data/model/response/pass_response.dart';
import '../api_result.dart';

abstract class AuthRepository {
  Future<Result<LoginResponse>> login(String email, String password);

  Future<Result<GenericResponseModel>> freshRegister(
      String fullName,
      String email,
      String password,
      String yearOfGraduation,
      String university,
      String department,
      );

  Future<Result<GenericResponseModel>> consultantRegister(
    String fullName,
    String email,
    String password,
    File resumePath,
    File photoPath,
    String yearOfExperience,
    String department,
    String biography,
  );

  Future<Result<GenericResponseModel>> forgetPassword(String email);

  Future<Result<GenericResponseModel>> resetPassword(
    String email,
    String token,
    String newPassword,
    String confirmPassword,
  );
}
