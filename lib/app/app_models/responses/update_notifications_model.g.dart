// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_notifications_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateNotificationsModelResponse _$UpdateNotificationsModelResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateNotificationsModelResponse(
      message: json['message'] as String?,
    )..value = json['value'] as bool?;

Map<String, dynamic> _$UpdateNotificationsModelResponseToJson(
        UpdateNotificationsModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
    };
