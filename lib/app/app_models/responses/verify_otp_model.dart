import '../../../exports.dart';

part 'verify_otp_model.g.dart';

@JsonSerializable()
class VerifyOTPModelResponse {
  @JsonKey(name: 'success')
  bool? success;
  VerifyOTPModelResponse({required this.success});
  factory VerifyOTPModelResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyOTPModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOTPModelResponseToJson(this);
}
