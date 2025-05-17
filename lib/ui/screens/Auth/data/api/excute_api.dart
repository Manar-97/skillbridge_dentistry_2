import 'package:dio/dio.dart';
import '../../domain/api_result.dart';

Future<Result<T>> executeApiCall<T>(Future<T> Function() apiCall) async {
  try {
    final response = await apiCall.call();
    return Success(response);
  } catch (e) {
    if (e is DioException) {
      return ServerFailure.fromDioError(e);
    }
    return ServerFailure(e.toString());
  }
}
