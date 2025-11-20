import 'package:dio/dio.dart';
import 'package:team_7/core/networking/api_constant.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      addAuthInterceptor();
      addRetryInterceptor();
      addLoggingInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addLoggingInterceptor() {
    dio?.interceptors.add(
      LogInterceptor(responseBody: true, requestBody: true),
    );
  }

  static void addRetryInterceptor() {
    dio?.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          if (_shouldRetry(error)) {
            try {
              final options = error.requestOptions;
              await Future.delayed(const Duration(seconds: 2));
              final response = await dio!.request(
                options.path,
                data: options.data,
                queryParameters: options.queryParameters,
                options: Options(
                  method: options.method,
                  headers: options.headers,
                ),
              );
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

  static void addAuthInterceptor() {
    dio?.interceptors.add(
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

  static bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError ||
        (error.response?.statusCode == 429) ||
        (error.response?.statusCode == 503);
  }
}
