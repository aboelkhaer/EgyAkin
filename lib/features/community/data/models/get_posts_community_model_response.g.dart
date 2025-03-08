// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_posts_community_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetPostsCommunityModelResponseImpl
    _$$GetPostsCommunityModelResponseImplFromJson(Map<String, dynamic> json) =>
        _$GetPostsCommunityModelResponseImpl(
          data: json['data'] == null
              ? null
              : GetPostsCommunityDataModelResponse.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$GetPostsCommunityModelResponseImplToJson(
        _$GetPostsCommunityModelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$GetPostsCommunityDataModelResponseImpl
    _$$GetPostsCommunityDataModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetPostsCommunityDataModelResponseImpl(
          data: (json['data'] as List<dynamic>?)
              ?.map(
                  (e) => PostCommunityModel.fromJson(e as Map<String, dynamic>))
              .toList(),
          currentPage: (json['current_page'] as num?)?.toInt(),
          firstPageUrl: json['first_page_url'] as String?,
          from: (json['from'] as num?)?.toInt(),
          lastPage: (json['last_page'] as num?)?.toInt(),
          lastPageUrl: json['last_page_url'] as String?,
          nextPageUrl: json['next_page_url'] as String?,
          path: json['path'] as String?,
          perPage: (json['perPage'] as num?)?.toInt(),
          prevPageUrl: json['prev_page_url'] as String?,
          to: (json['to'] as num?)?.toInt(),
          total: (json['total'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$GetPostsCommunityDataModelResponseImplToJson(
        _$GetPostsCommunityDataModelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'current_page': instance.currentPage,
      'first_page_url': instance.firstPageUrl,
      'from': instance.from,
      'last_page': instance.lastPage,
      'last_page_url': instance.lastPageUrl,
      'next_page_url': instance.nextPageUrl,
      'path': instance.path,
      'perPage': instance.perPage,
      'prev_page_url': instance.prevPageUrl,
      'to': instance.to,
      'total': instance.total,
    };

_$PostCommunityModelImpl _$$PostCommunityModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PostCommunityModelImpl(
      id: (json['id'] as num?)?.toInt(),
      content: json['content'] as String?,
      mediaType: json['media_type'] as String?,
      mediaPath: json['media_path'] as String?,
      visibility: json['visibility'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      likesCount: (json['likes_count'] as num?)?.toInt(),
      commentsCount: (json['comments_count'] as num?)?.toInt(),
      isSaved: json['isSaved'] as bool?,
      isLiked: json['isLiked'] as bool?,
      group: json['group'] == null
          ? null
          : GroupDetails.fromJson(json['group'] as Map<String, dynamic>),
      doctor: json['doctor'] == null
          ? null
          : DoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PostCommunityModelImplToJson(
        _$PostCommunityModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'media_type': instance.mediaType,
      'media_path': instance.mediaPath,
      'visibility': instance.visibility,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'likes_count': instance.likesCount,
      'comments_count': instance.commentsCount,
      'isSaved': instance.isSaved,
      'isLiked': instance.isLiked,
      'group': instance.group,
      'doctor': instance.doctor,
    };

_$GroupDetailsImpl _$$GroupDetailsImplFromJson(Map<String, dynamic> json) =>
    _$GroupDetailsImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$GroupDetailsImplToJson(_$GroupDetailsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
