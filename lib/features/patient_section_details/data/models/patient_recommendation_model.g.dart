// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_recommendation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PatientRecommendationModelImpl _$$PatientRecommendationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PatientRecommendationModelImpl(
      id: json['id'] as String,
      doseName: json['doseName'] as String?,
      dose: json['dose'] as String?,
      route: json['route'] as String?,
      frequency: json['frequency'] as String?,
      duration: json['duration'] as String?,
      type: json['type'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$$PatientRecommendationModelImplToJson(
        _$PatientRecommendationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doseName': instance.doseName,
      'dose': instance.dose,
      'route': instance.route,
      'frequency': instance.frequency,
      'duration': instance.duration,
      'type': instance.type,
      'content': instance.content,
    };
