// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseQuestionModel _$BaseQuestionModelFromJson(Map<String, dynamic> json) =>
    BaseQuestionModel(
      id: json['id'] as int?,
      question: json['question'] as String?,
      values: json['values'] as List<dynamic>?,
      type: json['type'] as String?,
      keyboardType: json['keyboard_type'] as String?,
      mandatory: json['mandatory'] as bool?,
      updatedAt: json['updated_at'] as String?,
      answer: json['answer'],
    );

Map<String, dynamic> _$BaseQuestionModelToJson(BaseQuestionModel instance) =>
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
