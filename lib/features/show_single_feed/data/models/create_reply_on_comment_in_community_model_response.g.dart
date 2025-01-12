// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_reply_on_comment_in_community_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateReplyOnCommentInCommunityModelResponseImpl
    _$$CreateReplyOnCommentInCommunityModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$CreateReplyOnCommentInCommunityModelResponseImpl(
          message: json['message'] as String?,
          data: json['data'] == null
              ? null
              : CreateCommentOnPostInCommunityDataModelResponse.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$CreateReplyOnCommentInCommunityModelResponseImplToJson(
        _$CreateReplyOnCommentInCommunityModelResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
