import 'package:dio/dio.dart';
import 'package:team_7/core/networking/api_constant.dart';
import 'package:team_7/core/networking/app_interceptor.dart';

class DioFactory {
  DioFactory._();

  static Dio? _dio;

  static Dio getDio() {
    if (_dio == null) {
      Duration timeOut = const Duration(seconds: 30);

      final dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: timeOut,
          receiveTimeout: timeOut,
        ),
      );
      dio
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;

      final appInterceptor = AppInterceptor(dio);
      appInterceptor.addAuthInterceptor();
      appInterceptor.addRetryInterceptor(maxRetries: 3);
      appInterceptor.addDioInterceptor();

      _dio = dio;
    }

    return _dio!;
  }
}
