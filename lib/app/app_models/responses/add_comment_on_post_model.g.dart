// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment_on_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCommentOnPostModelResponse _$AddCommentOnPostModelResponseFromJson(
        Map<String, dynamic> json) =>
    AddCommentOnPostModelResponse(
      message: json['message'] as String?,
    )..value = json['value'] as bool?;

Map<String, dynamic> _$AddCommentOnPostModelResponseToJson(
        AddCommentOnPostModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
    };
