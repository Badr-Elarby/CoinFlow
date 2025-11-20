import 'package:dio/dio.dart';
import 'package:team_7/core/networking/api_error_codes.dart';
import 'package:team_7/core/networking/api_error_factory.dart';
import 'package:team_7/core/networking/api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return _createError(
            ApiErrorCode.connectionError.code,
            "Connection to server failed",
          );

        case DioExceptionType.cancel:
          return _createError(
            ApiErrorCode.requestCancelled.code,
            "Request to the server was cancelled",
          );

        case DioExceptionType.connectionTimeout:
          return _createError(
            ApiErrorCode.timeout.code,
            "Connection timeout with the server",
          );

        case DioExceptionType.unknown:
          return _handleUnknownError(error);

        case DioExceptionType.receiveTimeout:
          return _createError(
            ApiErrorCode.timeout.code,
            "Receive timeout in connection with the server",
          );

        case DioExceptionType.badResponse:
          return _handleBadResponse(error.response);

        case DioExceptionType.sendTimeout:
          return _createError(
            ApiErrorCode.timeout.code,
            "Send timeout in connection with the server",
          );

        case DioExceptionType.badCertificate:
          return _createError(
            ApiErrorCode.badCertificate.code,
            "SSL certificate verification failed",
          );
      }
    } else {
      return ApiErrorFactory.defaultError;
    }
  }

  static ApiErrorModel _createError(int code, String message) {
    return ApiErrorFactory.createError(code, message);
  }

  static ApiErrorModel _handleBadResponse(Response? response) {
    if (response?.data == null) {
      return _createError(response?.statusCode ?? 500, "Unknown server error");
    }

    final data = response!.data;

    if (data is! Map<String, dynamic>) {
      return _createError(
        response.statusCode ?? 500,
        "Invalid response format",
      );
    }

    try {
      if (data.containsKey('status')) {
        return ApiErrorModel.fromJson(data);
      }

      final errorCode = response.statusCode ?? 500;
      final errorMessage = data['message'] as String?;

      return ApiErrorFactory.createError(errorCode, errorMessage);
    } catch (e) {
      return _createError(
        response.statusCode ?? 500,
        "Failed to parse error response",
      );
    }
  }

  static ApiErrorModel _handleUnknownError(DioException error) {
    return _createError(
      ApiErrorCode.serviceUnavailable.code,
      "Unexpected error occurred",
    );
  }
}
