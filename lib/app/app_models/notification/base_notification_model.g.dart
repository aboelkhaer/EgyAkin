// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseNotificationModel _$BaseNotificationModelFromJson(
        Map<String, dynamic> json) =>
    BaseNotificationModel(
      id: json['id'] as int?,
      read: json['read'] as bool?,
      patientId: json['patient_id'] as int?,
      createdAt: json['created_at'] as String?,
      basePatientModel: json['patient'] == null
          ? null
          : BasePatientModel.fromJson(json['patient'] as Map<String, dynamic>),
    )..type = json['type'] as String?;

Map<String, dynamic> _$BaseNotificationModelToJson(
        BaseNotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'read': instance.read,
      'type': instance.type,
      'patient_id': instance.patientId,
      'created_at': instance.createdAt,
      'patient': instance.basePatientModel,
    };
