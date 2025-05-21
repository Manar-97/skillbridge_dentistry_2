import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/request/verifyOTP_request.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/auth_response.dart';
import '../../../../utils/core/shared_pref_hepler.dart';
import '../model/request/login_request.dart';
import '../model/request/pass_request.dart';
import '../model/request/register_request.dart';
import '../model/response/general_response.dart';
import '../model/response/user.dart';
import '../repositories/auth_ds/auth_ds.dart';
import 'api_services.dart';

@Injectable(as: ApiServices)
class ApiServicesImpl implements ApiServices {
  final Dio _dio;
  final AuthOfflineDS authOfflineDS; // أضيفي هذا المتغير
  final String baseUrl = 'http://skillbridge1.runasp.net/api/auth';

  ApiServicesImpl(this._dio, this.authOfflineDS);

  @override
  @override
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        '$baseUrl/login',
        data: request.toJson(),
      );
      final loginResponse = AuthResponse.fromJson(response.data);

      // تخزين بيانات المستخدم كاملة في SharedPreferences
      await SharedPrefHelper.saveUser(loginResponse.user);
      await SharedPrefHelper.setSecureString(
        'token',
        loginResponse.token,
      ); // يحفظ التوكن الرسمي في التخزين الآمن

      return loginResponse;
    } catch (e) {
      if (e is DioException) {
        print('Login error: ${e.response?.data}');
      } else {
        print('Login error: $e');
      }
      rethrow;
    }
  }

  @override
  Future<AuthResponse> registerConsultant(
    ConsultantRegisterRequest request,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'Email': request.email,
        'Password': request.password,
        'FullName': request.fullName,
        'YearOfExperience': request.yearOfExperience,
        'Department': request.department,
        'ShortBiography': request.biography,
        'Photo': await MultipartFile.fromFile(
          request.photoPath.path,
          filename: 'photo.jpg',
        ),
        'ResumeLink': await MultipartFile.fromFile(
          request.resumePath.path,
          filename: 'resume.pdf',
        ),
      });
      final response = await _dio.post(
        '$baseUrl/register/consultant',
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
      if (response.data is String) {
        // return AuthResponse(message: response.data);
        throw Exception('Register Consultant failed: ${response.data}');
      }
      return AuthResponse.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        print('Register Consultant error: ${e.response?.data}');
      } else {
        print('Register Consultant error: $e');
      }
      rethrow;
    }
  }

  @override
  Future<AuthResponse> registerFreshGraduate(
    FreshGraduateRegisterRequest request,
  ) async {
    try {
      final response = await _dio.post(
        '$baseUrl/register-freshgraduate',
        data: request.toJson(),
      );

      if (response.data is String) {
        // return AuthResponse(message: response.data);
        throw Exception('Register Fresh Graduate failed: ${response.data}');
      }
      return AuthResponse.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        print('Register Fresh Graduate error: ${e.response?.data}');
      } else {
        print('Register Fresh Graduate error: $e');
      }
      rethrow;
    }
  }

  @override
  Future<GenericResponseModel> forgetPassword(
    ForgetPasswordRequest request,
  ) async {
    try {
      if (kDebugMode) {
        print('ForgetPasswordRequest: ${request.toJson()}');
      }
      final response = await _dio.post(
        '$baseUrl/forget-password',
        data: request.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      // ✅ إذا كانت الاستجابة عبارة عن رسالة نصية
      if (response.data is String) {
        return GenericResponseModel(message: response.data);
      }
      if (kDebugMode) {
        print('ForgetPassword Response: ${response.data}');
      }

      // ✅ استجابة بصيغة JSON
      return GenericResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;

      if (statusCode == 400 || statusCode == 404) {
        // ⛔️ إيميل غير موجود أو طلب غير صحيح
        final errorMessage = e.response?.data['message'] ?? 'حدث خطأ غير متوقع';
        throw Exception(errorMessage);
      }

      print('Forget Password error: ${e.response?.data}');
      throw Exception('حدث خطأ بالخادم: ${e.response?.statusCode}');
    } catch (e) {
      print('Forget Password general error: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  @override
  Future<GenericResponseModel> resetPassword(
    ResetPasswordRequest request,
  ) async {
    try {
      final response = await _dio.post(
        '$baseUrl/reset-password',
        data: request.toJson(), // هنا لازم يكون الtoken داخل ال JSON body
      );

      if (response.data is String) {
        return GenericResponseModel(message: response.data);
      }

      return GenericResponseModel.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        print('Reset Password error: ${e.response?.data}');
      } else {
        print('Reset Password error: $e');
      }
      rethrow;
    }
  }

  @override
  Future<GenericResponseModel> verifyOtp(VerifyOtpRequest request) async {
    try {
      print('Sending verifyOtp data: ${request.toJson()}');
      final response = await _dio.post(
        '$baseUrl/verify-otp',
        data: request.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.data is String) {
        return GenericResponseModel(message: response.data);
      }

      return GenericResponseModel.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        print('Verify OTP error: ${e.response?.data}');
      } else {
        print('Verify OTP error: $e');
      }
      rethrow;
    }
  }

  @override
  Future<UserModel?> fetchUserProfile() async {
    try {
      String? token = await SharedPrefHelper.getSecureString('token');
      if (token == null) return null;

      final response = await _dio.get(
        '$baseUrl/profile',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        // افترض ان الداتا بترجع JSON user
        return UserModel.fromJson(response.data);
      } else {
        // تعامل مع الخطأ
        return null;
      }
    } catch (e) {
      print('Error fetching profile: $e');
      return null;
    }
  }
}
