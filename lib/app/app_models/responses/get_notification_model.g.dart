// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNotificationModelResponse _$GetNotificationModelResponseFromJson(
        Map<String, dynamic> json) =>
    GetNotificationModelResponse(
      baseNotificationModel: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => BaseNotificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      unreadCount: (json['unreadCount'] as num?)?.toInt(),
    )..value = json['value'] as bool?;

Map<String, dynamic> _$GetNotificationModelResponseToJson(
        GetNotificationModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.baseNotificationModel,
      'unreadCount': instance.unreadCount,
    };
