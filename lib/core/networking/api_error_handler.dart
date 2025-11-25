import 'package:dio/dio.dart';
import 'package:team_7/core/networking/api_error_factory.dart';
import 'package:team_7/core/networking/api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.badCertificate:
          return ApiErrorModel(
            status: ApiStatus(
              timestamp: DateTime.now().toIso8601String(),
              errorCode: 400,
              errorMessage: "Bad certificate",
            ),
          );
        case DioExceptionType.badResponse:
          return _handleError(error.response?.data);
        case DioExceptionType.connectionError:
          return ApiErrorModel(
            status: ApiStatus(
              timestamp: DateTime.now().toIso8601String(),
              errorCode: 500,
              errorMessage: "Connection to server failed",
            ),
          );

        case DioExceptionType.cancel:
          return ApiErrorModel(
            status: ApiStatus(
              timestamp: DateTime.now().toIso8601String(),
              errorCode: 400,
              errorMessage: "Request to the server was cancelled",
            ),
          );

        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(
            status: ApiStatus(
              timestamp: DateTime.now().toIso8601String(),
              errorCode: 408,
              errorMessage: "Connection timeout with the server",
            ),
          );

        case DioExceptionType.unknown:
          return ApiErrorModel(
            status: ApiStatus(
              timestamp: DateTime.now().toIso8601String(),
              errorCode: 500,
              errorMessage: "Unknown error occurred",
            ),
          );

        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
            status: ApiStatus(
              timestamp: DateTime.now().toIso8601String(),
              errorCode: 408,
              errorMessage: "Receive timeout in connection with the server",
            ),
          );

        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
            status: ApiStatus(
              timestamp: DateTime.now().toIso8601String(),
              errorCode: 408,
              errorMessage: "Send timeout in connection with the server",
            ),
          );
      }
    } else {
      return ApiErrorFactory.defaultError;
    }
  }

  static ApiErrorModel _handleError(dynamic data) {
    if (data is Map<String, dynamic>) {
      return ApiErrorModel(
        status: ApiStatus(
          timestamp: DateTime.now().toIso8601String(),
          errorCode: data['code'] ?? 500,
          errorMessage: data['message'] ?? "Unknown error occurred",
        ),
      );
    }

    return ApiErrorFactory.defaultError;
  }
}
