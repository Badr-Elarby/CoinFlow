import 'package:json_annotation/json_annotation.dart';

part 'request_holder_signup.g.dart';

@JsonSerializable()
class RequestHolderSignup {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;

  RequestHolderSignup({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
  });

  factory RequestHolderSignup.fromJson(Map<String, dynamic> json) =>
      _$RequestHolderSignupFromJson(json);

  Map<String, dynamic> toJson() => _$RequestHolderSignupToJson(this);
}
