import 'package:team_7/core/networking/api_result.dart';

abstract class SignUpRepo {
  Future<ApiResult<Map<String, dynamic>>> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  });
}