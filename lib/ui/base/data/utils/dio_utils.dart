import 'package:dio/dio.dart';

///https://ecommerce.routemisr.com

class DioUtils {
  static Dio init() {
    final dio = Dio(BaseOptions(
      baseUrl: 'http://skillbridge1.runasp.net',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(minutes: 5),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ));
    dio.interceptors.add(LoggingInterceptors());
    return dio;
  }
}

extension ResponseExtention on Response {
  bool get isSuccessful =>
      statusCode != null && statusCode! >= 200 && statusCode! < 300;
}

class LoggingInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.uri}');
    if (options.data != null) print('DATA: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE[${response.statusCode}] => BODY: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.uri}');
    print('ERROR MESSAGE: ${err.message}');
    super.onError(err, handler);
  }
}
