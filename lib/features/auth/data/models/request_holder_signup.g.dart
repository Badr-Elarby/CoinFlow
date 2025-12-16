// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_holder_signup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestHolderSignup _$RequestHolderSignupFromJson(Map<String, dynamic> json) =>
    RequestHolderSignup(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$RequestHolderSignupToJson(
  RequestHolderSignup instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'password': instance.password,
  'confirmPassword': instance.confirmPassword,
  'phone': instance.phone,
};
