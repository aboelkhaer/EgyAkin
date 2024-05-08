// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_current_doctor_patients_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetDoctorPatientsModelResponseImpl
    _$$GetDoctorPatientsModelResponseImplFromJson(Map<String, dynamic> json) =>
        _$GetDoctorPatientsModelResponseImpl(
          value: json['value'] as bool?,
          verified: json['verified'] as bool?,
          scoreValue: json['score_value'] as String?,
          patientCount: json['patient_count'] as String?,
          data: json['data'] == null
              ? null
              : GetDoctorPatientsDataModelResponse.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$GetDoctorPatientsModelResponseImplToJson(
        _$GetDoctorPatientsModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'verified': instance.verified,
      'score_value': instance.scoreValue,
      'patient_count': instance.patientCount,
      'data': instance.data,
    };

_$GetDoctorPatientsDataModelResponseImpl
    _$$GetDoctorPatientsDataModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetDoctorPatientsDataModelResponseImpl(
          currentPage: json['current_page'] as int?,
          data: (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  PatientHomeDataModel.fromJson(e as Map<String, dynamic>))
              .toList(),
          firstPageUrl: json['first_page_url'] as String?,
          from: json['from'] as int?,
          lastPage: json['last_page'] as int?,
          lastPageUrl: json['last_page_url'] as String?,
          links: (json['links'] as List<dynamic>?)
              ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
              .toList(),
          nextPageUrl: json['next_page_url'] as String?,
          path: json['path'] as String?,
          perPage: json['perPage'] as int?,
          prevPageUrl: json['prev_page_url'] as String?,
          to: json['to'] as int?,
          total: json['total'] as int?,
        );

Map<String, dynamic> _$$GetDoctorPatientsDataModelResponseImplToJson(
        _$GetDoctorPatientsDataModelResponseImpl instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
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
