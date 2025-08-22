// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_patient_recommendation_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreatePatientRecommendationModelResponseImpl
    _$$CreatePatientRecommendationModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$CreatePatientRecommendationModelResponseImpl(
          message: json['message'] as String?,
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => GetRecommendationsDataModelResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$CreatePatientRecommendationModelResponseImplToJson(
        _$CreatePatientRecommendationModelResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
