import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/general_response.dart';
import '../model/request/login_request.dart';
import '../model/request/pass_request.dart';
import '../model/request/register_request.dart';
import '../model/request/verifyOTP_request.dart';
import '../model/response/auth_response.dart';
import '../model/response/user.dart';

abstract class ApiServices {
  Future<AuthResponse> registerConsultant(ConsultantRegisterRequest request);

  Future<AuthResponse> registerFreshGraduate(
    FreshGraduateRegisterRequest request,
  );

  Future<GenericResponseModel> forgetPassword(ForgetPasswordRequest request);

  Future<AuthResponse> login(LoginRequest request);

  Future<GenericResponseModel> resetPassword(ResetPasswordRequest request);

  Future<GenericResponseModel> verifyOtp(VerifyOtpRequest request);

  Future<UserModel?> fetchUserProfile();
}
