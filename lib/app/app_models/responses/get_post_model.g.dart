// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPostsModelResponse _$GetPostsModelResponseFromJson(
        Map<String, dynamic> json) =>
    GetPostsModelResponse(
      basePostModel: (json['data'] as List<dynamic>?)
          ?.map((e) => BasePostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..value = json['value'] as bool?;

Map<String, dynamic> _$GetPostsModelResponseToJson(
        GetPostsModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.basePostModel,
    };
