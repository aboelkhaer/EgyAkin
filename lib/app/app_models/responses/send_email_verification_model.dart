import '../../../exports.dart';

part 'send_email_verification_model.g.dart';

@JsonSerializable()
class SendEmailVerificationModelResponse {
  @JsonKey(name: 'success')
  bool? success;
  SendEmailVerificationModelResponse({required this.success});
  factory SendEmailVerificationModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SendEmailVerificationModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SendEmailVerificationModelResponseToJson(this);
}
