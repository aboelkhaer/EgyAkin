import '../../../exports.dart';

part 'update_notifications_model.g.dart';

@JsonSerializable()
class UpdateNotificationsModelResponse extends BaseResponse {
  @JsonKey(name: 'message')
  String? message;
  UpdateNotificationsModelResponse({required this.message});
  factory UpdateNotificationsModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateNotificationsModelResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$UpdateNotificationsModelResponseToJson(this);
}
