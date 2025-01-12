// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_comments_in_community_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetCommentsInCommunityModelResponseImpl
    _$$GetCommentsInCommunityModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetCommentsInCommunityModelResponseImpl(
          value: json['value'] as bool?,
          data: json['data'] == null
              ? null
              : PostCommentsData.fromJson(json['data'] as Map<String, dynamic>),
          message: json['message'] as String?,
        );

Map<String, dynamic> _$$GetCommentsInCommunityModelResponseImplToJson(
        _$GetCommentsInCommunityModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.data,
      'message': instance.message,
    };

_$PostCommentsDataImpl _$$PostCommentsDataImplFromJson(
        Map<String, dynamic> json) =>
    _$PostCommentsDataImpl(
      currentPage: (json['current_page'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              CommentModelInCommunity.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstPageUrl: json['first_page_url'] as String?,
      from: (json['from'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
      lastPageUrl: json['last_page_url'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPageUrl: json['next_page_url'] as String?,
      path: json['path'] as String?,
      perPage: (json['per_page'] as num?)?.toInt(),
      prevPageUrl: json['prev_page_url'] as String?,
      to: (json['to'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PostCommentsDataImplToJson(
        _$PostCommentsDataImpl instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
      'first_page_url': instance.firstPageUrl,
      'from': instance.from,
      'last_page': instance.lastPage,
      'last_page_url': instance.lastPageUrl,
      'links': instance.links,
      'next_page_url': instance.nextPageUrl,
      'path': instance.path,
      'per_page': instance.perPage,
      'prev_page_url': instance.prevPageUrl,
      'to': instance.to,
      'total': instance.total,
    };

_$CommentModelInCommunityImpl _$$CommentModelInCommunityImplFromJson(
        Map<String, dynamic> json) =>
    _$CommentModelInCommunityImpl(
      id: (json['id'] as num?)?.toInt(),
      feedPostId: (json['feed_post_id'] as num?)?.toInt(),
      doctorId: (json['doctor_id'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      parentId: (json['parent_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      likesCount: (json['likes_count'] as num?)?.toInt(),
      repliesCount: (json['replies_count'] as num?)?.toInt(),
      isLiked: json['isLiked'] as bool?,
      doctor: json['doctor'] == null
          ? null
          : DoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
      replies: (json['replies'] as List<dynamic>?)
          ?.map((e) =>
              CommentModelInCommunity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CommentModelInCommunityImplToJson(
        _$CommentModelInCommunityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'feed_post_id': instance.feedPostId,
      'doctor_id': instance.doctorId,
      'comment': instance.comment,
      'parent_id': instance.parentId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'likes_count': instance.likesCount,
      'replies_count': instance.repliesCount,
      'isLiked': instance.isLiked,
      'doctor': instance.doctor,
      'replies': instance.replies,
    };
