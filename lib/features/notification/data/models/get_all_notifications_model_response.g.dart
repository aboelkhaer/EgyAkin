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
          recentRecords: json['recentRecords'] == null
              ? null
              : RecentNotificationForPagenationModel.fromJson(
                  json['recentRecords'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$GetAllNotificationsModelResponseImplToJson(
        _$GetAllNotificationsModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'unreadCount': instance.unreadCount,
      'todayRecords': instance.todayRecords,
      'recentRecords': instance.recentRecords,
    };

_$RecentNotificationForPagenationModelImpl
    _$$RecentNotificationForPagenationModelImplFromJson(
            Map<String, dynamic> json) =>
        _$RecentNotificationForPagenationModelImpl(
          data: (json['data'] as List<dynamic>?)
              ?.map(
                  (e) => NotificationsModel.fromJson(e as Map<String, dynamic>))
              .toList(),
          currentPage: (json['current_page'] as num?)?.toInt(),
          firstPageUrl: json['first_page_url'] as String?,
          from: (json['from'] as num?)?.toInt(),
          lastPage: (json['last_page'] as num?)?.toInt(),
          lastPageUrl: json['last_page_url'] as String?,
          links: (json['links'] as List<dynamic>?)
              ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
              .toList(),
          nextPageUrl: json['next_page_url'] as String?,
          path: json['path'] as String?,
          perPage: (json['perPage'] as num?)?.toInt(),
          prevPageUrl: json['prev_page_url'] as String?,
          to: (json['to'] as num?)?.toInt(),
          total: (json['total'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$RecentNotificationForPagenationModelImplToJson(
        _$RecentNotificationForPagenationModelImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'current_page': instance.currentPage,
      'first_page_url': instance.firstPageUrl,
      'from': instance.from,
      'last_page': instance.lastPage,
      'last_page_url': instance.lastPageUrl,
      'links': instance.links,
      'next_page_url': instance.nextPageUrl,
      'path': instance.path,
      'perPage': instance.perPage,
      'prev_page_url': instance.prevPageUrl,
      'to': instance.to,
      'total': instance.total,
    };

_$NotificationsModelImpl _$$NotificationsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationsModelImpl(
      id: (json['id'] as num?)?.toInt(),
      read: json['read'] as bool?,
      type: json['type'] as String?,
      content: json['content'] as String?,
      typeId: json['type_id'] as String?,
      createdAt: json['created_at'] as String?,
      patient: json['patient'] == null
          ? null
          : PatientNotificationModel.fromJson(
              json['patient'] as Map<String, dynamic>),
      typeDoctor: json['type_doctor'] == null
          ? null
          : TypeDoctorForNotificationModel.fromJson(
              json['type_doctor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$NotificationsModelImplToJson(
        _$NotificationsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'read': instance.read,
      'type': instance.type,
      'content': instance.content,
      'type_id': instance.typeId,
      'created_at': instance.createdAt,
      'patient': instance.patient,
      'type_doctor': instance.typeDoctor,
    };

_$TypeDoctorForNotificationModelImpl
    _$$TypeDoctorForNotificationModelImplFromJson(Map<String, dynamic> json) =>
        _$TypeDoctorForNotificationModelImpl(
          id: (json['id'] as num?)?.toInt(),
          firstName: json['name'] as String?,
          lastName: json['lname'] as String?,
          workingplace: json['workingplace'] as String?,
          image: json['image'] as String?,
          isSyndicateCardRequired: json['isSyndicateCardRequired'] as String?,
        );

Map<String, dynamic> _$$TypeDoctorForNotificationModelImplToJson(
        _$TypeDoctorForNotificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.firstName,
      'lname': instance.lastName,
      'workingplace': instance.workingplace,
      'image': instance.image,
      'isSyndicateCardRequired': instance.isSyndicateCardRequired,
    };

_$PatientNotificationModelImpl _$$PatientNotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PatientNotificationModelImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      hospital: json['hospital'] as String?,
      governorate: json['governorate'] as String?,
      doctor: json['doctor'] == null
          ? null
          : DoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
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

_$SectionsNotificationDataModelImpl
    _$$SectionsNotificationDataModelImplFromJson(Map<String, dynamic> json) =>
        _$SectionsNotificationDataModelImpl(
          id: (json['id'] as num?)?.toInt(),
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

_$LinkImpl _$$LinkImplFromJson(Map<String, dynamic> json) => _$LinkImpl(
      url: json['url'],
      label: json['label'] as String,
      active: json['active'] as bool,
    );

Map<String, dynamic> _$$LinkImplToJson(_$LinkImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'label': instance.label,
      'active': instance.active,
    };
