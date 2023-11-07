// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCommentModelResponse _$AddCommentModelResponseFromJson(
        Map<String, dynamic> json) =>
    AddCommentModelResponse(
      message: json['message'] as String?,
    )..value = json['value'] as bool?;

Map<String, dynamic> _$AddCommentModelResponseToJson(
        AddCommentModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
    };
