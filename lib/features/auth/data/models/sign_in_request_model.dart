import 'package:json_annotation/json_annotation.dart';

part 'sign_in_request_model.g.dart';

@JsonSerializable()
class SignInRequestModel {
  final String email;
  final String password;

  SignInRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() => _$SignInRequestModelToJson(this);
}
