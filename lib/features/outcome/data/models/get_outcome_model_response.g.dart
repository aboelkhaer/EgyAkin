// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_outcome_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetOutcomeModelResponseImpl _$$GetOutcomeModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetOutcomeModelResponseImpl(
      value: json['value'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      aiMode: json['ai_mode'] as String?,
      aiHint: json['ai_hint'] as String?,
      aiVoiceTime: (json['ai_voice_time'] as num?)?.toInt(),
      submitter: json['Submitter'] == null
          ? null
          : OutcomeSubmitterModel.fromJson(
              json['Submitter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetOutcomeModelResponseImplToJson(
        _$GetOutcomeModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.data,
      'ai_mode': instance.aiMode,
      'ai_hint': instance.aiHint,
      'ai_voice_time': instance.aiVoiceTime,
      'Submitter': instance.submitter,
    };

_$OutcomeSubmitterModelImpl _$$OutcomeSubmitterModelImplFromJson(
        Map<String, dynamic> json) =>
    _$OutcomeSubmitterModelImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$OutcomeSubmitterModelImplToJson(
        _$OutcomeSubmitterModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };
