import 'package:team_7/core/networking/api_result.dart';
import 'package:team_7/features/auth/domain/repository/sign_up_repo.dart';

class SignUpUC {
  final SignUpRepo repository;

  SignUpUC(this.repository);

  Future<ApiResult<Map<String, dynamic>>> call({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    return await repository.signup(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
    );
  }
}
