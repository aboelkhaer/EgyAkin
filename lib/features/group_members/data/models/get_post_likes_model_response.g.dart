// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_post_likes_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetPostLikesModelResponseImpl _$$GetPostLikesModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetPostLikesModelResponseImpl(
      data: json['data'] == null
          ? null
          : MembersDataModelResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetPostLikesModelResponseImplToJson(
        _$GetPostLikesModelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
