// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_post_by_id_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetPostByIdModelResponseImpl _$$GetPostByIdModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetPostByIdModelResponseImpl(
      value: json['value'] as bool?,
      data: json['data'] == null
          ? null
          : PostCommunityModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetPostByIdModelResponseImplToJson(
        _$GetPostByIdModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.data,
    };
