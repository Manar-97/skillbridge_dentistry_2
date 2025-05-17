import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/login_response.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/pass_response.dart';
import '../model/request/login_request.dart';
import '../model/request/pass_request.dart';
import '../model/request/register_request.dart';

abstract class ApiServices {
  Future<GenericResponseModel> registerConsultant(
      ConsultantRegisterRequest request);

  Future<GenericResponseModel> registerFreshGraduate(
      FreshGraduateRegisterRequest request);

  Future<GenericResponseModel> forgetPassword(ForgetPasswordRequest request);

  Future<LoginResponse> login(LoginRequest request);

  Future<GenericResponseModel> resetPassword(ResetPasswordRequest request);
}
