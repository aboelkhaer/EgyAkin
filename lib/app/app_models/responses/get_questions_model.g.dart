// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_questions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetQuestionsModelResponse _$GetQuestionsModelResponseFromJson(
        Map<String, dynamic> json) =>
    GetQuestionsModelResponse(
      baseQuestionModel: (json['data'] as List<dynamic>?)
          ?.map((e) => BaseQuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..value = json['value'] as bool?;

Map<String, dynamic> _$GetQuestionsModelResponseToJson(
        GetQuestionsModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.baseQuestionModel,
    };
