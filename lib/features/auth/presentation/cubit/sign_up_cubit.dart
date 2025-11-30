import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/features/auth/domain/usecases/sign_up_us.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUC _signUpUseCase;

  SignUpCubit(this._signUpUseCase) : super(SignUpState());

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    emit(state.copyWith(
      status: SignUpStatus.loading,
      errorMessage: null,
    ));

    final result = await _signUpUseCase.call(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
    );

    result.when(
      onSuccess: (data) {
        emit(state.copyWith(
          status: SignUpStatus.success,
          userData: data,
          errorMessage: null,
        ));
      },
      onError: (error) {
        emit(state.copyWith(
          status: SignUpStatus.error,
          errorMessage: error.status.errorMessage,
        ));
      },
    );
  }
}



