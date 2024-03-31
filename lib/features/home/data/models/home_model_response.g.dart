// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeModelResponseImpl _$$HomeModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$HomeModelResponseImpl(
      value: json['value'] as bool?,
      verified: json['verified'] as bool?,
      unreadCount: json['unreadCount'] as String?,
      patientCount: json['patient_count'] as String?,
      scoreValue: json['score_value'] as String?,
      role: json['role'] as String?,
      data: json['data'] == null
          ? null
          : HomeDataModelResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$HomeModelResponseImplToJson(
        _$HomeModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'verified': instance.verified,
      'unreadCount': instance.unreadCount,
      'patient_count': instance.patientCount,
      'score_value': instance.scoreValue,
      'role': instance.role,
      'data': instance.data,
    };

_$HomeDataModelResponseImpl _$$HomeDataModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$HomeDataModelResponseImpl(
      allPatients: (json['all_patients'] as List<dynamic>?)
          ?.map((e) => PatientHomeDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPatients: (json['current_patient'] as List<dynamic>?)
          ?.map((e) => PatientHomeDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      posts: (json['posts'] as List<dynamic>?)
          ?.map((e) => PostHomeDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$HomeDataModelResponseImplToJson(
        _$HomeDataModelResponseImpl instance) =>
    <String, dynamic>{
      'all_patients': instance.allPatients,
      'current_patient': instance.currentPatients,
      'posts': instance.posts,
    };

_$PatientHomeDataModelImpl _$$PatientHomeDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PatientHomeDataModelImpl(
      id: json['id'] as int?,
      doctorId: json['doctor_id'] as String?,
      name: json['name'] as String?,
      hospital: json['hospital'] as String?,
      updatedAt: json['updated_at'] as String?,
      doctor: json['doctor'] == null
          ? null
          : DoctorHomeDataModel.fromJson(
              json['doctor'] as Map<String, dynamic>),
      sections: json['sections'] == null
          ? null
          : SectionHomeDataModel.fromJson(
              json['sections'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PatientHomeDataModelImplToJson(
        _$PatientHomeDataModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctor_id': instance.doctorId,
      'name': instance.name,
      'hospital': instance.hospital,
      'updated_at': instance.updatedAt,
      'doctor': instance.doctor,
      'sections': instance.sections,
    };

_$DoctorHomeDataModelImpl _$$DoctorHomeDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DoctorHomeDataModelImpl(
      id: json['id'] as int?,
      firstName: json['name'] as String?,
      lastName: json['lname'] as String?,
    );

Map<String, dynamic> _$$DoctorHomeDataModelImplToJson(
        _$DoctorHomeDataModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.firstName,
      'lname': instance.lastName,
    };

_$SectionHomeDataModelImpl _$$SectionHomeDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SectionHomeDataModelImpl(
      patientId: json['patient_id'] as String?,
      submitStatus: json['submit_status'] as bool?,
      outcomeStatus: json['outcome_status'] as bool?,
    );

Map<String, dynamic> _$$SectionHomeDataModelImplToJson(
        _$SectionHomeDataModelImpl instance) =>
    <String, dynamic>{
      'patient_id': instance.patientId,
      'submit_status': instance.submitStatus,
      'outcome_status': instance.outcomeStatus,
    };

_$PostHomeDataModelImpl _$$PostHomeDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PostHomeDataModelImpl(
      id: json['id'] as int?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      image: json['image'] as String?,
      hidden: json['hidden'] as bool?,
      doctorId: json['doctor_id'] as String?,
      updatedAt: json['updated_at'] as String?,
      doctor: json['doctor'] == null
          ? null
          : DoctorHomeDataModel.fromJson(
              json['doctor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PostHomeDataModelImplToJson(
        _$PostHomeDataModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'image': instance.image,
      'hidden': instance.hidden,
      'doctor_id': instance.doctorId,
      'updated_at': instance.updatedAt,
      'doctor': instance.doctor,
    };
