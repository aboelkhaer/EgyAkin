import '../../../exports.dart';

part 'logout_response.g.dart';

@JsonSerializable()
class LogoutModel extends BaseResponse {
  @JsonKey(name: 'message')
  String? message;
  LogoutModel({required this.message});
  factory LogoutModel.fromJson(Map<String, dynamic> json) =>
      _$LogoutModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LogoutModelToJson(this);
}
