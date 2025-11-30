part of 'sign_up_cubit.dart';

enum SignUpStatus {
  initial,
  loading,
  success,
  error,
}

class SignUpState {
  final SignUpStatus status;
  final String? errorMessage;
  final Map<String, dynamic>? userData;

  SignUpState({
    this.status = SignUpStatus.initial,
    this.errorMessage,
    this.userData,
  });

  SignUpState copyWith({
    SignUpStatus? status,
    String? errorMessage,
    Map<String, dynamic>? userData,
  }) {
    return SignUpState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      userData: userData ?? this.userData,
    );
  }
}



