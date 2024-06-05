// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_patient_history_for_add_patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetPatientHistoryForAddPatientModelResponseImpl
    _$$GetPatientHistoryForAddPatientModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetPatientHistoryForAddPatientModelResponseImpl(
          value: json['value'] as bool?,
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$GetPatientHistoryForAddPatientModelResponseImplToJson(
        _$GetPatientHistoryForAddPatientModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.data,
    };

_$QuestionModelImpl _$$QuestionModelImplFromJson(Map<String, dynamic> json) =>
    _$QuestionModelImpl(
      id: json['id'] as int?,
      question: json['question'] as String?,
      values: json['values'] as List<dynamic>?,
      type: json['type'] as String?,
      keyboardType: json['keyboard_type'] as String?,
      mandatory: json['mandatory'] as bool?,
      updatedAt: json['updated_at'] as String?,
      answer: json['answer'],
    );

Map<String, dynamic> _$$QuestionModelImplToJson(_$QuestionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'values': instance.values,
      'type': instance.type,
      'keyboard_type': instance.keyboardType,
      'mandatory': instance.mandatory,
      'updated_at': instance.updatedAt,
      'answer': instance.answer,
    };
