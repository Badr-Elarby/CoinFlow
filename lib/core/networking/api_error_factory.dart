import 'package:team_7/core/networking/api_error_codes.dart';
import 'package:team_7/core/networking/api_error_model.dart';

class ApiErrorFactory {
  static ApiErrorModel get defaultError => ApiErrorModel(
    status: ApiStatus(
      timestamp: DateTime.now().toIso8601String(),
      errorCode: 400,
      errorMessage: "Something went wrong",
    ),
  );

  static ApiErrorModel createError(int code, String? message) {
    final errorMessage = message ?? errorMessages[code] ?? "An error occurred.";
    return ApiErrorModel(
      status: ApiStatus(
        timestamp: DateTime.now().toIso8601String(),
        errorCode: code,
        errorMessage: errorMessage,
      ),
    );
  }
}
