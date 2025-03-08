// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_group_details_in_community_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetGroupDetailsInCommunityModelResponseImpl
    _$$GetGroupDetailsInCommunityModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetGroupDetailsInCommunityModelResponseImpl(
          data: json['data'] == null
              ? null
              : GetGroupDetailsInCommunityDataModelResponse.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$GetGroupDetailsInCommunityModelResponseImplToJson(
        _$GetGroupDetailsInCommunityModelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$GetGroupDetailsInCommunityDataModelResponseImpl
    _$$GetGroupDetailsInCommunityDataModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetGroupDetailsInCommunityDataModelResponseImpl(
          group: json['group'] == null
              ? null
              : GroupModel.fromJson(json['group'] as Map<String, dynamic>),
          posts: json['posts'] == null
              ? null
              : GetPostsCommunityDataModelResponse.fromJson(
                  json['posts'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$GetGroupDetailsInCommunityDataModelResponseImplToJson(
        _$GetGroupDetailsInCommunityDataModelResponseImpl instance) =>
    <String, dynamic>{
      'group': instance.group,
      'posts': instance.posts,
    };
