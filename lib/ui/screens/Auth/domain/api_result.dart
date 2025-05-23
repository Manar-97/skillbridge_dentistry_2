import 'package:dio/dio.dart';
import 'error_message.dart';

sealed class Result<T> {}

class Success<T> implements Result<T> {
  T? data;
  Success(this.data);
}

class ServerFailure<T> implements Result<T> {
  String? message;
  ServerFailure(this.message);
  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(ErrorMessage.connectionTimeOut);
      case DioExceptionType.sendTimeout:
        return ServerFailure(ErrorMessage.sendingTimeOut);
      case DioExceptionType.receiveTimeout:
        return ServerFailure(ErrorMessage.connectionTimeOut);
      case DioExceptionType.badCertificate:
        return ServerFailure(ErrorMessage.badCertificateError);
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          e.response!.statusCode!,
          e.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(ErrorMessage.cancelError);
      case DioExceptionType.connectionError:
        return ServerFailure(ErrorMessage.connectionError);
      case DioExceptionType.unknown:
        return ServerFailure(ErrorMessage.unKnown);
      default:
        return ServerFailure(ErrorMessage.defaultError);
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400) {
      return ServerFailure("Reset code is invalid or has expired");
    }
    if (statusCode == 401) {
      return ServerFailure("Incorrect email or password");
    } else if (statusCode == 409) {
      return ServerFailure('User already exists');
    } else if (statusCode == 404) {
      return ServerFailure(ErrorMessage.requestNotFount);
    } else if (statusCode >= 500) {
      return ServerFailure(ErrorMessage.serverFailure);
    }

    // ✨ التعامل مع message سواء كانت داخل error أو مباشرة
    if (response is Map) {
      if (response.containsKey('error') &&
          response['error'] is Map &&
          response['error']['message'] != null) {
        return ServerFailure(response['error']['message'].toString());
      } else if (response.containsKey('message')) {
        return ServerFailure(response['message'].toString());
      }
    }

    return ServerFailure(ErrorMessage.unKnown);
  }
}
