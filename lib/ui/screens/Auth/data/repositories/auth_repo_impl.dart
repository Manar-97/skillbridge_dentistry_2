import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/user.dart';
import '../../data/model/response/general_response.dart';
import '../../domain/api_result.dart';
import '../../domain/repositories/auth_repo.dart';
import '../model/response/auth_response.dart';
import 'auth_ds/auth_ds.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthOnlineDS authOnlineDS;
  final AuthOfflineDS authOfflineDS;

  AuthRepositoryImpl(this.authOnlineDS, this.authOfflineDS);

  @override
  Future<Result<AuthResponse>> login(String email, String password) async {
    try {
      final response = await authOnlineDS.login(email, password);
      await authOfflineDS.saveToken(response.token);
      return Success(response);
    } on DioException catch (e) {
      return ServerFailure.fromDioError(e);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }

  @override
  Future<Result<AuthResponse>> freshRegister(
    String fullName,
    String email,
    String password,
    String yearOfGraduation,
    String university,
    String department,
  ) async {
    try {
      final response = await authOnlineDS.registerFreshGraduate(
        fullName,
        email,
        password,
        yearOfGraduation,
        university,
        department,
      );
      await authOfflineDS.saveToken(response.token);
      return Success(response);
    } on DioException catch (e) {
      return ServerFailure.fromDioError(e);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }

  @override
  Future<Result<AuthResponse>> consultantRegister(
    String fullName,
    String email,
    String password,
    File resumePath,
    File photoPath,
    String yearOfExperience,
    String department,
    String biography,
  ) async {
    try {
      final response = await authOnlineDS.registerConsultant(
        fullName,
        email,
        password,
        resumePath,
        photoPath,
        yearOfExperience,
        department,
        biography,
      );
      await authOfflineDS.saveToken(response.token);
      return Success(response);
    } on DioException catch (e) {
      return ServerFailure.fromDioError(e);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }

  @override
  Future<Result<GenericResponseModel>> forgetPassword(String email) async {
    try {
      final response = await authOnlineDS.forgetPassword(email);
      return Success(response);
    } on DioException catch (e) {
      return ServerFailure.fromDioError(e);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }

  @override
  Future<Result<GenericResponseModel>> resetPassword(
    String email,
    String otp,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      final response = await authOnlineDS.resetPassword(
        email,
        otp,
        newPassword,
        confirmPassword,
      );
      return Success(response);
    } on DioException catch (e) {
      return ServerFailure.fromDioError(e);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }

  @override
  Future<Result<GenericResponseModel>> verifyOtp(
    String email,
    String otp,
  ) async {
    print('Repository verifyOtp called with: email=$email, otp=$otp');
    try {
      final response = await authOnlineDS.verifyOtp(email, otp);
      return Success(response);
    } on DioException catch (e) {
      return ServerFailure.fromDioError(e);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }

  @override
  Future<Result<UserModel?>> fetchUserProfile() async {
    try {
      final response = await authOnlineDS.fetchUserProfile();
      return Success(response);
    } on DioException catch (e) {
      return ServerFailure.fromDioError(e);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }
}
