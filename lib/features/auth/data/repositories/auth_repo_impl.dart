import 'package:team_7/core/networking/api_result.dart';
import 'package:team_7/features/auth/data/models/request_holder_signup.dart';
import 'package:team_7/features/auth/data/models/sign_in_request_model.dart';
import 'package:team_7/features/auth/data/models/user_model.dart';
import 'package:team_7/features/auth/domain/repository/auth_data_source.dart';
import 'package:team_7/features/auth/domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSource _authDataSource;

  AuthRepoImpl(this._authDataSource);

  @override
  Future<ApiResult<UserModel>> signup({
    required RequestHolderSignup requestHolderSignup,
  }) async {
    try {
      final currentUser = await _authDataSource.createUserWithEmailAndPassword(
        email: requestHolderSignup.email.trim(),
        password: requestHolderSignup.password,
      );
      return ApiResult.success(UserModel.fromFirebaseUser(currentUser));
    } catch (e) {
      return ApiResult.error(e);
    }
  }

  @override
  Future<ApiResult<UserModel>> login({
    required SignInRequestModel signinRequestModel,
  }) async {
    try {
      final currentUser = await _authDataSource.signInWithEmailAndPassword(
        email: signinRequestModel.email.trim(),
        password: signinRequestModel.password,
      );

      return ApiResult.success(UserModel.fromFirebaseUser(currentUser));
    } catch (e) {
      return ApiResult.error(e);
    }
  }

  @override
  Future<ApiResult<void>> signOut() async {
    try {
      await _authDataSource.signOut();
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.error(e);
    }
  }
}
