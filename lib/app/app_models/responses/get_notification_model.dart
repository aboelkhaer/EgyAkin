import '../../../exports.dart';

part 'get_notification_model.g.dart';

@JsonSerializable()
class GetNotificationModelResponse extends BaseResponse {
  @JsonKey(name: 'data')
  List<BaseNotificationModel>? baseNotificationModel;
  @JsonKey(name: 'unreadCount')
  int? unreadCount;

  GetNotificationModelResponse({
    this.baseNotificationModel,
    this.unreadCount,
  });

  factory GetNotificationModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetNotificationModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetNotificationModelResponseToJson(this);
}
