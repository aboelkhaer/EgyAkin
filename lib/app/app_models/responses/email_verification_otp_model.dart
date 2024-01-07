import '../../../exports.dart';

part 'email_verification_otp_model.g.dart';

@JsonSerializable()
class EmailVerificationOTPModelResponse {
  @JsonKey(name: 'success')
  bool? success;
  EmailVerificationOTPModelResponse({required this.success});
  factory EmailVerificationOTPModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$EmailVerificationOTPModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$EmailVerificationOTPModelResponseToJson(this);
}
