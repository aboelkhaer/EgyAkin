// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_notifications_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetAllNotificationsModelResponseImpl
    _$$GetAllNotificationsModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetAllNotificationsModelResponseImpl(
          value: json['value'] as bool?,
          unreadCount: json['unreadCount'] as String?,
          todayRecords: (json['todayRecords'] as List<dynamic>?)
              ?.map(
                  (e) => NotificationsModel.fromJson(e as Map<String, dynamic>))
              .toList(),
          recentRecords: (json['recentRecords'] as List<dynamic>?)
              ?.map(
                  (e) => NotificationsModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$GetAllNotificationsModelResponseImplToJson(
        _$GetAllNotificationsModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'unreadCount': instance.unreadCount,
      'todayRecords': instance.todayRecords,
      'recentRecords': instance.recentRecords,
    };

_$NotificationsModelImpl _$$NotificationsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationsModelImpl(
      id: json['id'] as int?,
      read: json['read'] as bool?,
      type: json['type'] as String?,
      createdAt: json['created_at'] as String?,
      patient: json['patient'] == null
          ? null
          : PatientNotificationModel.fromJson(
              json['patient'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$NotificationsModelImplToJson(
        _$NotificationsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'read': instance.read,
      'type': instance.type,
      'created_at': instance.createdAt,
      'patient': instance.patient,
    };

_$PatientNotificationModelImpl _$$PatientNotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PatientNotificationModelImpl(
      id: json['id'] as int?,
      name: json['name'] as String?,
      hospital: json['hospital'] as String?,
      governorate: json['governorate'] as String?,
      doctor: json['doctor'] == null
          ? null
          : DoctorNotificationDataModel.fromJson(
              json['doctor'] as Map<String, dynamic>),
      sections: json['sections'] == null
          ? null
          : SectionsNotificationDataModel.fromJson(
              json['sections'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PatientNotificationModelImplToJson(
        _$PatientNotificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hospital': instance.hospital,
      'governorate': instance.governorate,
      'doctor': instance.doctor,
      'sections': instance.sections,
    };

_$DoctorNotificationDataModelImpl _$$DoctorNotificationDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DoctorNotificationDataModelImpl(
      id: json['id'] as int?,
      firstName: json['name'] as String?,
      lastName: json['lname'] as String?,
      workingplace: json['workingplace'] as String?,
    );

Map<String, dynamic> _$$DoctorNotificationDataModelImplToJson(
        _$DoctorNotificationDataModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.firstName,
      'lname': instance.lastName,
      'workingplace': instance.workingplace,
    };

_$SectionsNotificationDataModelImpl
    _$$SectionsNotificationDataModelImplFromJson(Map<String, dynamic> json) =>
        _$SectionsNotificationDataModelImpl(
          id: json['id'] as int?,
          submitStatus: json['submit_status'] as bool?,
          outcomeStatus: json['outcome_status'] as bool?,
          workingplace: json['workingplace'] as String?,
        );

Map<String, dynamic> _$$SectionsNotificationDataModelImplToJson(
        _$SectionsNotificationDataModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'submit_status': instance.submitStatus,
      'outcome_status': instance.outcomeStatus,
      'workingplace': instance.workingplace,
    };
