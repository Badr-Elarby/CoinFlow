import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/features/auth/domain/repository/sign_up_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepo _signUpRepo;

  SignUpCubit(this._signUpRepo) : super(SignUpInitial());

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    emit(SignUpLoading());

    final result = await _signUpRepo.signup(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
    );

    result.when(
      onSuccess: (data) {
        emit(SignUpSuccess(data));
      },
      onError: (error) {
        emit(SignUpError(error.status.errorMessage));
      },
    );
  }
}