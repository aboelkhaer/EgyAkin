// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_post_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeletePostCommentModelResponse _$DeletePostCommentModelResponseFromJson(
        Map<String, dynamic> json) =>
    DeletePostCommentModelResponse(
      message: json['message'] as String?,
    )..value = json['value'] as bool?;

Map<String, dynamic> _$DeletePostCommentModelResponseToJson(
        DeletePostCommentModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
    };
