import 'package:freezed_annotation/freezed_annotation.dart';
part 'send_email_for_verification_model_response.freezed.dart';
part 'send_email_for_verification_model_response.g.dart';

@freezed
class SendEmailForVerificationModelResponse
    with _$SendEmailForVerificationModelResponse {
  const factory SendEmailForVerificationModelResponse({
    bool? success,
  }) = _SendEmailForVerificationModelResponse;
  factory SendEmailForVerificationModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SendEmailForVerificationModelResponseFromJson(json);
}
