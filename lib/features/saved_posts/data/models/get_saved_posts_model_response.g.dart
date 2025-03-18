// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_saved_posts_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetSavedPostsModelResponseImpl _$$GetSavedPostsModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetSavedPostsModelResponseImpl(
      data: json['data'] == null
          ? null
          : GetPostsCommunityDataModelResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetSavedPostsModelResponseImplToJson(
        _$GetSavedPostsModelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
