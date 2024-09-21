// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'verify_user_email_model_response.freezed.dart';
part 'verify_user_email_model_response.g.dart';

@freezed
class VerifyUserEmailModelResponse with _$VerifyUserEmailModelResponse {
  const factory VerifyUserEmailModelResponse({
    String? message,
  }) = _VerifyUserEmailModelResponse;
  factory VerifyUserEmailModelResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyUserEmailModelResponseFromJson(json);
}
