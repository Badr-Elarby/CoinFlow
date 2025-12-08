part of 'sign_up_cubit.dart';

sealed class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final UserModel userModel;

  SignUpSuccess(this.userModel);
}

class SignUpError extends SignUpState {
  final ApiErrorModel errorMessage;

  SignUpError(this.errorMessage);
}