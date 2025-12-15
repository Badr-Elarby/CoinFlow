import 'package:json_annotation/json_annotation.dart';

part 'api_error_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiErrorModel {
  final ApiStatus status;

  ApiErrorModel({required this.status});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  String get errorMessage => status.errorMessage;

  int get errorCode => status.errorCode;
}

@JsonSerializable()
class ApiStatus {
  final String timestamp;

  @JsonKey(name: 'error_code')
  final int errorCode;

  @JsonKey(name: 'error_message')
  final String errorMessage;

  ApiStatus({
    required this.timestamp,
    required this.errorCode,
    required this.errorMessage,
  });

  factory ApiStatus.fromJson(Map<String, dynamic> json) =>
      _$ApiStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ApiStatusToJson(this);
}
