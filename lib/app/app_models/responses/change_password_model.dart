import '../../../exports.dart';

part 'change_password_model.g.dart';

@JsonSerializable()
class ChangePasswordModelResponse {
  @JsonKey(name: 'success')
  bool? success;
  ChangePasswordModelResponse({required this.success});
  factory ChangePasswordModelResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordModelResponseToJson(this);
}
