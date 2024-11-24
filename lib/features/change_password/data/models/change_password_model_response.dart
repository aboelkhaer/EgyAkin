// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'change_password_model_response.freezed.dart';
part 'change_password_model_response.g.dart';

@freezed
class ChangePasswordModelResponse with _$ChangePasswordModelResponse {
  const factory ChangePasswordModelResponse({
    String? message,
  }) = _ChangePasswordModelResponse;
  factory ChangePasswordModelResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordModelResponseFromJson(json);
}
