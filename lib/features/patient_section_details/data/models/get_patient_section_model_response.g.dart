// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_patient_section_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetPatientSectionDetailsModelResponseImpl
    _$$GetPatientSectionDetailsModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetPatientSectionDetailsModelResponseImpl(
          value: json['value'] as bool?,
          aiMode: json['ai_mode'] as String?,
          aiHint: json['ai_hint'] as String?,
          aiVoiceTime: (json['ai_voice_time'] as num?)?.toInt(),
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$GetPatientSectionDetailsModelResponseImplToJson(
        _$GetPatientSectionDetailsModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'ai_mode': instance.aiMode,
      'ai_hint': instance.aiHint,
      'ai_voice_time': instance.aiVoiceTime,
      'data': instance.data,
    };
