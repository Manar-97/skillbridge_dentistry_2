import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/api/api_services.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/request/login_request.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/request/pass_request.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/request/register_request.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/login_response.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/pass_response.dart';
import 'auth_ds.dart';

@Injectable(as: AuthOnlineDS)
class AuthOnlineDSImpl implements AuthOnlineDS {
  final ApiServices _apiServices;

  AuthOnlineDSImpl(this._apiServices);
  @override
  Future<GenericResponseModel> forgetPassword(String email) {
    return _apiServices.forgetPassword(ForgetPasswordRequest(email: email));
  }

  @override
  Future<LoginResponse> login(String email, String password) async {
    return _apiServices.login(LoginRequest(email: email, password: password));
  }

  @override
  Future<GenericResponseModel> registerConsultant(
    String fullName,
    String email,
    String password,
    File resumePath,
    File photoPath,
    String yearOfExperience,
    String department,
    String biography,
  ) async {
    final request = ConsultantRegisterRequest(
      fullName: fullName,
      email: email,
      password: password,
      resumePath: resumePath,
      yearOfExperience: yearOfExperience,
      department: department,
      biography: biography,
      photoPath: photoPath,
    );
    return await _apiServices.registerConsultant(request);
  }

  @override
  Future<GenericResponseModel> registerFreshGraduate(
    String fullName,
    String email,
    String password,
    String yearOfGraduation,
    String university,
    String department,
  ) async {
    final request = FreshGraduateRegisterRequest(
      fullName: fullName,
      email: email,
      password: password,
      yearOfGraduation: yearOfGraduation,
      university: university,
      department: department,
    );
    return await _apiServices.registerFreshGraduate(request);
  }

  @override
  Future<GenericResponseModel> resetPassword(
    String email,
    String token,
    String newPassword,
    String confirmPassword,
  ) async {
    final request = ResetPasswordRequest(
        email: email,
        token: token,
        newPassword: newPassword,
        confirmPassword: confirmPassword);
    return await _apiServices.resetPassword(request);
  }
}
