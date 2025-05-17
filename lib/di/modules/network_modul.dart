import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../ui/base/data/utils/dio_utils.dart';

@module
abstract class NetworkModules {
  @LazySingleton()
  InternetConnectionChecker getInternetConnectionChecker() =>
      InternetConnectionChecker.createInstance();

  @LazySingleton()
  Dio getDio() => DioUtils.init();
}
