// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiErrorModel _$ApiErrorModelFromJson(Map<String, dynamic> json) =>
    ApiErrorModel(
      status: ApiStatus.fromJson(json['status'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiErrorModelToJson(ApiErrorModel instance) =>
    <String, dynamic>{'status': instance.status.toJson()};

ApiStatus _$ApiStatusFromJson(Map<String, dynamic> json) => ApiStatus(
  timestamp: json['timestamp'] as String,
  errorCode: (json['error_code'] as num).toInt(),
  errorMessage: json['error_message'] as String,
);

Map<String, dynamic> _$ApiStatusToJson(ApiStatus instance) => <String, dynamic>{
  'timestamp': instance.timestamp,
  'error_code': instance.errorCode,
  'error_message': instance.errorMessage,
};
