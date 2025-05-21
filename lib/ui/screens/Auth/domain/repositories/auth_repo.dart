import 'dart:io';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/auth_response.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/user.dart';
import '../../data/model/response/general_response.dart';
import '../api_result.dart';

abstract class AuthRepository {
  Future<Result<AuthResponse>> login(String email, String password);

  Future<Result<AuthResponse>> freshRegister(
    String fullName,
    String email,
    String password,
    String yearOfGraduation,
    String university,
    String department,
  );

  Future<Result<AuthResponse>> consultantRegister(
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
    String otp,
    String newPassword,
    String confirmPassword,
  );

  Future<Result<GenericResponseModel>> verifyOtp(String email, String otp);

  Future<Result<UserModel?>> fetchUserProfile();
}
