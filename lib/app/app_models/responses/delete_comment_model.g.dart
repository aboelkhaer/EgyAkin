// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteCommentModelResponse _$DeleteCommentModelResponseFromJson(
        Map<String, dynamic> json) =>
    DeleteCommentModelResponse(
      message: json['message'] as String?,
    )..value = json['value'] as bool?;

Map<String, dynamic> _$DeleteCommentModelResponseToJson(
        DeleteCommentModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
    };
