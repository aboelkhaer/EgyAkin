// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_recommendations_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetRecommendationsModelResponseImpl
    _$$GetRecommendationsModelResponseImplFromJson(Map<String, dynamic> json) =>
        _$GetRecommendationsModelResponseImpl(
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => GetRecommendationsDataModelResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$GetRecommendationsModelResponseImplToJson(
        _$GetRecommendationsModelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$GetRecommendationsDataModelResponseImpl
    _$$GetRecommendationsDataModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetRecommendationsDataModelResponseImpl(
          id: (json['id'] as num?)?.toInt(),
          patientId: (json['patient_id'] as num?)?.toInt(),
          doseName: json['dose_name'] as String?,
          createdAt: json['created_at'] as String?,
          updatedAt: json['updated_at'] as String?,
          dose: json['dose'] as String?,
          route: json['route'] as String?,
          frequency: json['frequency'] as String?,
          duration: json['duration'] as String?,
          type: json['type'] as String?,
          content: json['content'] as String?,
        );

Map<String, dynamic> _$$GetRecommendationsDataModelResponseImplToJson(
        _$GetRecommendationsDataModelResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient_id': instance.patientId,
      'dose_name': instance.doseName,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'dose': instance.dose,
      'route': instance.route,
      'frequency': instance.frequency,
      'duration': instance.duration,
      'type': instance.type,
      'content': instance.content,
    };
