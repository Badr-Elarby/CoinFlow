import 'package:firebase_auth/firebase_auth.dart';
import 'package:team_7/core/networking/api_error_model.dart';

class FirebaseErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is FirebaseAuthException) {
      return _handleFirebaseAuthException(error);
    } else if (error is Exception) {
      return ApiErrorModel(
        status: ApiStatus(
          timestamp: DateTime.now().toIso8601String(),
          errorCode: 400,
          errorMessage: error.toString().replaceFirst('Exception: ', ''),
        ),
      );
    } else {
      return ApiErrorModel(
        status: ApiStatus(
          timestamp: DateTime.now().toIso8601String(),
          errorCode: 500,
          errorMessage: 'An unexpected error occurred.',
        ),
      );
    }
  }

  static ApiErrorModel _handleFirebaseAuthException(FirebaseAuthException e) {
    String errorMessage;
    int errorCode;

    switch (e.code) {
      case 'weak-password':
        errorMessage = 'The password provided is too weak.';
        errorCode = 400;
        break;
      case 'email-already-in-use':
        errorMessage = 'An account already exists for this email.';
        errorCode = 409;
        break;
      case 'invalid-email':
        errorMessage = 'The email address is invalid.';
        errorCode = 400;
        break;
      case 'operation-not-allowed':
        errorMessage = 'Email/password accounts are not enabled.';
        errorCode = 403;
        break;
      case 'user-not-found':
        errorMessage = 'No user found with this email.';
        errorCode = 404;
        break;
      case 'wrong-password':
        errorMessage = 'Incorrect password.';
        errorCode = 401;
        break;
      case 'user-disabled':
        errorMessage = 'This account has been disabled.';
        errorCode = 403;
        break;
      case 'too-many-requests':
        errorMessage = 'Too many requests. Please try again later.';
        errorCode = 429;
        break;
      case 'network-request-failed':
        errorMessage = 'Network error. Please check your connection.';
        errorCode = 500;
        break;
      case 'invalid-credential':
        errorMessage = 'Invalid credentials provided.';
        errorCode = 401;
        break;
      default:
        errorMessage = e.message ?? 'An authentication error occurred.';
        errorCode = 500;
    }

    return ApiErrorModel(
      status: ApiStatus(
        timestamp: DateTime.now().toIso8601String(),
        errorCode: errorCode,
        errorMessage: errorMessage,
      ),
    );
  }
}


