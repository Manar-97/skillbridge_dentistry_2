import 'dart:io';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/login_response.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/pass_response.dart';

abstract class AuthOnlineDS {
  Future<GenericResponseModel> registerConsultant(
      String fullName,
      String email,
      String password,
      File resumePath,
      File photoPath,
      String yearOfExperience,
      String department,
      String biography);

  Future<GenericResponseModel> registerFreshGraduate(
      String fullName,
      String email,
      String password,
      String yearOfGraduation,
      String university,
      String department,
      );

  Future<GenericResponseModel> forgetPassword(String email);

  Future<LoginResponse> login(String email, String password);

  Future<GenericResponseModel> resetPassword(
    String email,
    String token,
    String newPassword,
    String confirmPassword,
  );
}

abstract class AuthOfflineDS {
  Future<void> saveToken(String token);
  Future<void> deleteToken();
  Future<String> getToken();
}
