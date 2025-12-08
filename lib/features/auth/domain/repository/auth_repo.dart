import 'package:team_7/core/networking/api_result.dart';
import 'package:team_7/features/auth/data/models/request_holder_signup.dart';
import 'package:team_7/features/auth/data/models/user_model.dart';

abstract class AuthRepo {
  Future<ApiResult<UserModel>> signup({
    required RequestHolderSignup requestHolderSignup,
  });

  // Future<ApiResult<UserModel?>> getCurrentUser();

  Future<ApiResult<void>> signOut();
}
