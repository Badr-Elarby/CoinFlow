import 'package:team_7/core/networking/api_result.dart';
import 'package:team_7/core/networking/firebase_error_handler.dart';
import 'package:team_7/features/auth/data/sources/auth_data_source.dart';
import 'package:team_7/features/auth/domain/repository/sign_up_repo.dart';

class SignUpRepoImpl implements SignUpRepo {
  final AuthDataSource _authDataSource;

  SignUpRepoImpl(this._authDataSource);

  @override
  Future<ApiResult<Map<String, dynamic>>> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    try {
      final userModel = await _authDataSource.signUpWithEmailAndPassword(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phone: phone,
      );
      return ApiResult.success(userModel.toJson());
    } catch (e) {
      final errorModel = FirebaseErrorHandler.handle(e);
      return ApiResult.error(errorModel);
    }
  }
}

