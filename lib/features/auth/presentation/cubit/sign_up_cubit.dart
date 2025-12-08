import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/core/networking/api_error_model.dart';
import 'package:team_7/features/auth/data/models/request_holder_signup.dart';
import 'package:team_7/features/auth/data/models/user_model.dart';
import 'package:team_7/features/auth/domain/repository/auth_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepo _authRepo;

  SignUpCubit(this._authRepo) : super(SignUpInitial());

  Future<void> signUp(RequestHolderSignup requestHolderSignup) async {
    emit(SignUpLoading());

    final result = await _authRepo.signup(
      requestHolderSignup: requestHolderSignup,
    );

    result.when(
      onSuccess: (userModel) {
        emit(SignUpSuccess(userModel));
      },
      onError: (error) {
        emit(SignUpError(error));
      },
    );
  }
}