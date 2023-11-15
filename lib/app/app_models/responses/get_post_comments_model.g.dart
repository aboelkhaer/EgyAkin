// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_post_comments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPostCommentsModelResponse _$GetPostCommentsModelResponseFromJson(
        Map<String, dynamic> json) =>
    GetPostCommentsModelResponse(
      baseCommentModel: (json['data'] as List<dynamic>?)
          ?.map((e) => BaseCommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..value = json['value'] as bool?;

Map<String, dynamic> _$GetPostCommentsModelResponseToJson(
        GetPostCommentsModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.baseCommentModel,
    };
