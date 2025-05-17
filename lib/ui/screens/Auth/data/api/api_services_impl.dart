import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../model/request/login_request.dart';
import '../model/request/pass_request.dart';
import '../model/request/register_request.dart';
import '../model/response/login_response.dart';
import '../model/response/pass_response.dart';
import '../repositories/auth_ds/auth_ds.dart';
import 'api_services.dart';

@Injectable(as: ApiServices)
class ApiServicesImpl implements ApiServices {
  final Dio _dio;
  final AuthOfflineDS authOfflineDS; // أضيفي هذا المتغير
  final String baseUrl = 'http://skillbridge1.runasp.net/api/auth';

  ApiServicesImpl(this._dio, this.authOfflineDS);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        '$baseUrl/login',
        data: request.toJson(),
      );
      final loginResponse = LoginResponse.fromJson(response.data);
      await authOfflineDS.saveToken(
        loginResponse.token,
      ); // الـ ! تعني: "أنا متأكد إنها ليست null"
      // اختبار قراءة التوكين بعد التخزين
      final token = await authOfflineDS.getToken();
      print('Read token after saving: $token');
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
  Future<GenericResponseModel> registerConsultant(
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
          request.photoPath!.path,
          filename: 'photo.jpg',
        ),
        'ResumeLink': await MultipartFile.fromFile(
          request.resumePath!.path,
          filename: 'resume.pdf',
        ),
      });

      final response = await _dio.post(
        '$baseUrl/register/consultant',
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      if (response.data is String) {
        return GenericResponseModel(message: response.data);
      }

      return GenericResponseModel.fromJson(response.data);
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
  Future<GenericResponseModel> registerFreshGraduate(
    FreshGraduateRegisterRequest request,
  ) async {
    try {
      final response = await _dio.post(
        '$baseUrl/register-freshgraduate',
        data: request.toJson(),
      );

      if (response.data is String) {
        return GenericResponseModel(message: response.data);
      }

      return GenericResponseModel.fromJson(response.data);
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
      final response = await _dio.post(
        '$baseUrl/forget-password',
        queryParameters: {'email': request.email}, // هتبعت الإيميل هنا
      );

      if (response.data is String) {
        return GenericResponseModel(message: response.data);
      }

      return GenericResponseModel.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        print('Forget Password error: ${e.response?.data}');
      } else {
        print('Forget Password error: $e');
      }
      rethrow;
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
}
