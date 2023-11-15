import '../../../exports.dart';

part 'base_notification_model.g.dart';

@JsonSerializable(includeIfNull: true)
class BaseNotificationModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'read')
  bool? read;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'patient_id')
  int? patientId;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'patient')
  BasePatientModel? basePatientModel;

  BaseNotificationModel({
    this.id,
    this.read,
    this.patientId,
    this.createdAt,
    this.basePatientModel,
  });
  factory BaseNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$BaseNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseNotificationModelToJson(this);
}
