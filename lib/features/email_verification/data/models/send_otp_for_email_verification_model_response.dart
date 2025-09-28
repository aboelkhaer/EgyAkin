import 'package:freezed_annotation/freezed_annotation.dart';
part 'send_otp_for_email_verification_model_response.freezed.dart';
part 'send_otp_for_email_verification_model_response.g.dart';

@freezed
class SendOTPForEmailVerificationModelResponse
    with _$SendOTPForEmailVerificationModelResponse {
  const factory SendOTPForEmailVerificationModelResponse({
    bool? success,
    String? message,
  }) = _SendOTPForEmailVerificationModelResponse;
  factory SendOTPForEmailVerificationModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SendOTPForEmailVerificationModelResponseFromJson(json);
}
