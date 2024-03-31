// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelResponseImpl _$$NotificationModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelResponseImpl(
      value: json['value'] as bool?,
      unreadCount: json['unreadCount'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              NotificationDataModelResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$NotificationModelResponseImplToJson(
        _$NotificationModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'unreadCount': instance.unreadCount,
      'data': instance.data,
    };

_$NotificationDataModelResponseImpl
    _$$NotificationDataModelResponseImplFromJson(Map<String, dynamic> json) =>
        _$NotificationDataModelResponseImpl(
          id: json['id'] as int?,
          type: json['type'] as String?,
          read: json['read'] as bool?,
          createdAt: json['created_at'] as String?,
          patient: json['patient'] == null
              ? null
              : PatientNotificationDataModelResponse.fromJson(
                  json['patient'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$NotificationDataModelResponseImplToJson(
        _$NotificationDataModelResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'read': instance.read,
      'created_at': instance.createdAt,
      'patient': instance.patient,
    };

_$PatientNotificationDataModelResponseImpl
    _$$PatientNotificationDataModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$PatientNotificationDataModelResponseImpl(
          id: json['id'] as int?,
          name: json['name'] as String?,
          hospital: json['hospital'] as String?,
          governorate: json['governorate'] as String?,
          doctor: json['doctor'] == null
              ? null
              : DoctorNotificationDataModelResponse.fromJson(
                  json['doctor'] as Map<String, dynamic>),
          sections: json['sections'] == null
              ? null
              : SectionsNotificationDataModelResponse.fromJson(
                  json['sections'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$PatientNotificationDataModelResponseImplToJson(
        _$PatientNotificationDataModelResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hospital': instance.hospital,
      'governorate': instance.governorate,
      'doctor': instance.doctor,
      'sections': instance.sections,
    };

_$DoctorNotificationDataModelResponseImpl
    _$$DoctorNotificationDataModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$DoctorNotificationDataModelResponseImpl(
          id: json['id'] as int?,
          firstName: json['name'] as String?,
          lastName: json['lname'] as String?,
          workingplace: json['workingplace'] as String?,
        );

Map<String, dynamic> _$$DoctorNotificationDataModelResponseImplToJson(
        _$DoctorNotificationDataModelResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.firstName,
      'lname': instance.lastName,
      'workingplace': instance.workingplace,
    };

_$SectionsNotificationDataModelResponseImpl
    _$$SectionsNotificationDataModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$SectionsNotificationDataModelResponseImpl(
          id: json['id'] as int?,
          submitStatus: json['submit_status'] as bool?,
          outcomeStatus: json['outcome_status'] as bool?,
          workingplace: json['workingplace'] as String?,
        );

Map<String, dynamic> _$$SectionsNotificationDataModelResponseImplToJson(
        _$SectionsNotificationDataModelResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'submit_status': instance.submitStatus,
      'outcome_status': instance.outcomeStatus,
      'workingplace': instance.workingplace,
    };
