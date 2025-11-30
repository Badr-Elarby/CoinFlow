part of 'sign_up_cubit.dart';

sealed class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final Map<String, dynamic> userData;

  SignUpSuccess(this.userData);
}

class SignUpError extends SignUpState {
  final String errorMessage;

  SignUpError(this.errorMessage);
}