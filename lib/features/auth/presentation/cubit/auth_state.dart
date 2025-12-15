part of 'auth_cubit.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel userModel;

  AuthSuccess(this.userModel);
}

class AuthError extends AuthState {
  final ApiErrorModel errorMessage;

  AuthError(this.errorMessage);
}
