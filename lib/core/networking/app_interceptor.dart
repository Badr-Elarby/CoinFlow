import 'package:dio/dio.dart';
import 'package:team_7/core/networking/api_constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppInterceptor {
  final Dio dio;

  AppInterceptor(this.dio);

  void addAuthInterceptor() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (ApiConstants.apiKey.isNotEmpty) {
            options.headers['x-cg-demo-api-key'] = ApiConstants.apiKey;
          }
          return handler.next(options);
        },
      ),
    );
  }

  void addRetryInterceptor({int maxRetries = 3}) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          int retryCount = error.requestOptions.extra['retryCount'] ?? 0;
          if (retryCount < maxRetries && shouldRetry(error)) {
            retryCount++;
            error.requestOptions.extra['retryCount'] = retryCount;
            final delay = Duration(milliseconds: 1000 * retryCount);
            await Future.delayed(delay);
            try {
              final response = await dio.fetch(error.requestOptions);
              return handler.resolve(response);
            } catch (e) {
              return handler.next(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  bool shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError ||
        (error.response?.statusCode != null &&
            error.response!.statusCode! >= 500);
  }

  void addDioInterceptor() {
    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}
