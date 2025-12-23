import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/core/networking/api_error_model.dart';
import 'package:team_7/features/auth/data/models/request_holder_signup.dart';
import 'package:team_7/features/auth/data/models/sign_in_request_model.dart';
import 'package:team_7/features/auth/data/models/user_model.dart';
import 'package:team_7/features/auth/domain/repository/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit(this._authRepo) : super(AuthInitial());

  Future<void> signUp(RequestHolderSignup requestHolderSignup) async {
    emit(AuthLoading());

    final result = await _authRepo.signup(
      requestHolderSignup: requestHolderSignup,
    );

    result.when(
      onSuccess: (userModel) {
        emit(AuthSuccess(userModel));
      },
      onError: (error) {
        emit(AuthError(error));
      },
    );
  }

  Future<void> login(SignInRequestModel signinRequestModel) async {
    emit(AuthLoading());

    final result = await _authRepo.login(
      signinRequestModel: signinRequestModel,
    );
    result.when(
      onSuccess: (userModel) {
        emit(AuthSuccess(userModel));
      },
      onError: (error) {
        emit(AuthError(error));
      },
    );
  }
}
