// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_comments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCommentstModelResponse _$GetCommentstModelResponseFromJson(
        Map<String, dynamic> json) =>
    GetCommentstModelResponse(
      baseCommentModel: (json['data'] as List<dynamic>?)
          ?.map((e) => BaseCommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..value = json['value'] as bool?;

Map<String, dynamic> _$GetCommentstModelResponseToJson(
        GetCommentstModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.baseCommentModel,
    };
