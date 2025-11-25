import 'package:team_7/core/networking/api_error_model.dart';

class ApiErrorFactory {
  static ApiErrorModel get defaultError => ApiErrorModel(
    status: ApiStatus(
      timestamp: DateTime.now().toIso8601String(),
      errorCode: 400,
      errorMessage: "Something went wrong",
    ),
  );
}
