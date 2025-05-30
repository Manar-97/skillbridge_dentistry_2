import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/api/api_services.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/request/login_request.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/request/pass_request.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/request/register_request.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/request/verifyOTP_request.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/general_response.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/user.dart';
import '../../model/response/auth_response.dart';
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
  Future<AuthResponse> login(String email, String password) async {
    return _apiServices.login(LoginRequest(email: email, password: password));
  }

  @override
  Future<AuthResponse> registerConsultant(
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
      yearsOfExperience: yearOfExperience,
      department: department,
      biography: biography,
      photoPath: photoPath,
    );
    return await _apiServices.registerConsultant(request);
  }

  @override
  Future<AuthResponse> registerFreshGraduate(
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
    String otp,
    String newPassword,
    String confirmPassword,
  ) async {
    final request = ResetPasswordRequest(
      email: email,
      otp: otp,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    return await _apiServices.resetPassword(request);
  }

  @override
  Future<GenericResponseModel> verifyOtp(String email, String otp) async {
    final request = VerifyOtpRequest(email: email, otp: otp);
    return await _apiServices.verifyOtp(request);
  }

  @override
  Future<UserModel?> fetchUserProfile() async {
    return await _apiServices.fetchUserProfile();
  }
}
