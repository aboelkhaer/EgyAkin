import '../../../../exports.dart';

part 'add_contact_us_model.g.dart';

@JsonSerializable()
class AddContactUsModelResponse extends BaseResponse {
  @JsonKey(name: 'message')
  String? message;

  AddContactUsModelResponse({
    this.message,
  });

  factory AddContactUsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$AddContactUsModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AddContactUsModelResponseToJson(this);
}
