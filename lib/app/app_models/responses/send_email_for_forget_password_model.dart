import '../../../exports.dart';

part 'send_email_for_forget_password_model.g.dart';

@JsonSerializable()
class SendEmailForForgetPasswordModelResponse {
  @JsonKey(name: 'success')
  bool? success;
  SendEmailForForgetPasswordModelResponse({required this.success});
  factory SendEmailForForgetPasswordModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SendEmailForForgetPasswordModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SendEmailForForgetPasswordModelResponseToJson(this);
}
