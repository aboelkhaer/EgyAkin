// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_comment_on_post_in_community_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateCommentOnPostInCommunityModelResponseImpl
    _$$CreateCommentOnPostInCommunityModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$CreateCommentOnPostInCommunityModelResponseImpl(
          message: json['message'] as String?,
          data: json['data'] == null
              ? null
              : CreateCommentOnPostInCommunityDataModelResponse.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$CreateCommentOnPostInCommunityModelResponseImplToJson(
        _$CreateCommentOnPostInCommunityModelResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

_$CreateCommentOnPostInCommunityDataModelResponseImpl
    _$$CreateCommentOnPostInCommunityDataModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$CreateCommentOnPostInCommunityDataModelResponseImpl(
          id: (json['id'] as num?)?.toInt(),
          comment: json['comment'] as String?,
          doctorId: (json['doctor_id'] as num?)?.toInt(),
        );

Map<String, dynamic>
    _$$CreateCommentOnPostInCommunityDataModelResponseImplToJson(
            _$CreateCommentOnPostInCommunityDataModelResponseImpl instance) =>
        <String, dynamic>{
          'id': instance.id,
          'comment': instance.comment,
          'doctor_id': instance.doctorId,
        };
