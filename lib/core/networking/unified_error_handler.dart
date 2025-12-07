import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:team_7/core/networking/api_error_model.dart';
import 'package:team_7/core/networking/api_error_factory.dart';

class UnifiedErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is ApiErrorModel) {
      return error;
    } else if (error is DioException) {
      return _handleDioException(error);
    } else if (error is FirebaseAuthException) {
      return _handleFirebaseAuthException(error);
    } else if (error is Exception) {
      return _handleGenericException(error);
    } else {
      return ApiErrorFactory.defaultError;
    }
  }

  static ApiErrorModel _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.badCertificate:
        return _createError(400, "Bad certificate");

      case DioExceptionType.badResponse:
        return _handleApiError(error.response!);

      case DioExceptionType.connectionError:
        return _createError(500, "Connection to server failed");

      case DioExceptionType.cancel:
        return _createError(400, "Request to the server was cancelled");

      case DioExceptionType.connectionTimeout:
        return _createError(408, "Connection timeout with the server");

      case DioExceptionType.receiveTimeout:
        return _createError(
          408,
          "Receive timeout in connection with the server",
        );

      case DioExceptionType.sendTimeout:
        return _createError(408, "Send timeout in connection with the server");

      case DioExceptionType.unknown:
        return _createError(500, error.message ?? "Unknown error occurred");
    }
  }

  static ApiErrorModel _handleApiError(Response response) {
    try {
      final status = response.data['status'];
      return ApiErrorModel(
        status: ApiStatus(
          timestamp: status['timestamp'],
          errorCode: status['error_code'],
          errorMessage: status['error_message'],
        ),
      );
    } catch (_) {
      return _createError(
        response.statusCode ?? 500,
        response.statusMessage ?? "Server error",
      );
    }
  }

  static ApiErrorModel _handleFirebaseAuthException(FirebaseAuthException e) {
    final (errorCode, errorMessage) = switch (e.code) {
      'weak-password' => (400, 'The password provided is too weak.'),
      'email-already-in-use' => (
        409,
        'An account already exists for this email.',
      ),
      'invalid-email' => (400, 'The email address is invalid.'),
      'operation-not-allowed' => (
        403,
        'Email/password accounts are not enabled.',
      ),
      'user-not-found' => (404, 'No user found with this email.'),
      'wrong-password' => (401, 'Incorrect password.'),
      'user-disabled' => (403, 'This account has been disabled.'),
      'too-many-requests' => (
        429,
        'Too many requests. Please try again later.',
      ),
      'network-request-failed' => (
        500,
        'Network error. Please check your connection.',
      ),
      'invalid-credential' => (401, 'Invalid credentials provided.'),
      _ => (500, e.message ?? 'An authentication error occurred.'),
    };

    return _createError(errorCode, errorMessage);
  }

  static ApiErrorModel _handleGenericException(Exception error) {
    final message = error.toString().replaceFirst('Exception: ', '');
    return _createError(400, message);
  }

  static ApiErrorModel _createError(int code, String message) {
    return ApiErrorModel(
      status: ApiStatus(
        timestamp: DateTime.now().toIso8601String(),
        errorCode: code,
        errorMessage: message,
      ),
    );
  }
}
