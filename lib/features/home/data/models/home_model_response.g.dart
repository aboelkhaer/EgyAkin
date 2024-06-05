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
      doctorPatientCount: json['doctor_patient_count'] as String?,
      allPatientCount: json['all_patient_count'] as String?,
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
      'doctor_patient_count': instance.doctorPatientCount,
      'all_patient_count': instance.allPatientCount,
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
      topDoctors: (json['topDoctors'] as List<dynamic>?)
          ?.map((e) => DoctorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      posts: (json['posts'] as List<dynamic>?)
          ?.map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$HomeDataModelResponseImplToJson(
        _$HomeDataModelResponseImpl instance) =>
    <String, dynamic>{
      'all_patients': instance.allPatients,
      'current_patient': instance.currentPatients,
      'topDoctors': instance.topDoctors,
      'posts': instance.posts,
    };

_$PatientHomeDataModelImpl _$$PatientHomeDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PatientHomeDataModelImpl(
      id: json['id'] as int?,
      name: json['name'] as String?,
      hospital: json['hospital'] as String?,
      updatedAt: json['updated_at'] as String?,
      doctor: json['doctor'] == null
          ? null
          : DoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
      sections: json['sections'] == null
          ? null
          : SectionHomeDataModel.fromJson(
              json['sections'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PatientHomeDataModelImplToJson(
        _$PatientHomeDataModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hospital': instance.hospital,
      'updated_at': instance.updatedAt,
      'doctor': instance.doctor,
      'sections': instance.sections,
    };

_$SectionHomeDataModelImpl _$$SectionHomeDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SectionHomeDataModelImpl(
      patientId: json['patient_id'] as int?,
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
