// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_doctor_profile_score_history_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetDoctorProfileScoreModelResponseImpl
    _$$GetDoctorProfileScoreModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetDoctorProfileScoreModelResponseImpl(
          value: json['value'] as bool?,
          data: json['data'] == null
              ? null
              : GetDoctorProfileScoreDataModelResponse.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$GetDoctorProfileScoreModelResponseImplToJson(
        _$GetDoctorProfileScoreModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.data,
    };

_$GetDoctorProfileScoreDataModelResponseImpl
    _$$GetDoctorProfileScoreDataModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetDoctorProfileScoreDataModelResponseImpl(
          currentPage: (json['current_page'] as num?)?.toInt(),
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => ScoreModel.fromJson(e as Map<String, dynamic>))
              .toList(),
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

Map<String, dynamic> _$$GetDoctorProfileScoreDataModelResponseImplToJson(
        _$GetDoctorProfileScoreDataModelResponseImpl instance) =>
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

_$ScoreModelImpl _$$ScoreModelImplFromJson(Map<String, dynamic> json) =>
    _$ScoreModelImpl(
      id: (json['id'] as num?)?.toInt(),
      score: json['score'] as String?,
      action: json['action'] as String?,
      doctor: json['doctor'] == null
          ? null
          : DoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
      updateAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$ScoreModelImplToJson(_$ScoreModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'score': instance.score,
      'action': instance.action,
      'doctor': instance.doctor,
      'updated_at': instance.updateAt,
    };
