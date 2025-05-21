import 'dart:io';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/general_response.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/user.dart';

import '../../model/response/auth_response.dart';

abstract class AuthOnlineDS {
  Future<AuthResponse> registerConsultant(
    String fullName,
    String email,
    String password,
    File resumePath,
    File photoPath,
    String yearOfExperience,
    String department,
    String biography,
  );

  Future<AuthResponse> registerFreshGraduate(
    String fullName,
    String email,
    String password,
    String yearOfGraduation,
    String university,
    String department,
  );

  Future<GenericResponseModel> forgetPassword(String email);

  Future<AuthResponse> login(String email, String password);

  Future<GenericResponseModel> resetPassword(
    String email,
    String otp,
    String newPassword,
    String confirmPassword,
  );

  Future<GenericResponseModel> verifyOtp(String email, String otp);

  Future<UserModel?> fetchUserProfile();
}

abstract class AuthOfflineDS {
  Future<void> saveToken(String token);
  Future<void> deleteToken();
  Future<String> getToken();
}
