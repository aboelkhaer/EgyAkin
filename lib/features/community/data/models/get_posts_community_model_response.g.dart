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
          currentPage: _parseInt(json['current_page']),
          firstPageUrl: json['first_page_url'] as String?,
          from: _parseInt(json['from']),
          lastPage: _parseInt(json['last_page']),
          lastPageUrl: json['last_page_url'] as String?,
          nextPageUrl: json['next_page_url'] as String?,
          path: json['path'] as String?,
          perPage: _parseInt(json['perPage']),
          prevPageUrl: json['prev_page_url'] as String?,
          to: _parseInt(json['to']),
          total: _parseInt(json['total']),
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
      id: _parseInt(json['id']),
      content: json['content'] as String?,
      mediaType: json['media_type'] as String?,
      mediaPath: (json['media_path'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      visibility: json['visibility'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      likesCount: _parseInt(json['likes_count']),
      commentsCount: _parseInt(json['comments_count']),
      isSaved: json['isSaved'] as bool?,
      isLiked: json['isLiked'] as bool?,
      existingMediaPath: (json['existing_media_path'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      group: json['group'] == null
          ? null
          : GroupDetails.fromJson(json['group'] as Map<String, dynamic>),
      doctor: json['doctor'] == null
          ? null
          : DoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
      poll: json['poll'] == null
          ? null
          : PollModelResponse.fromJson(json['poll'] as Map<String, dynamic>),
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
      'existing_media_path': instance.existingMediaPath,
      'group': instance.group,
      'doctor': instance.doctor,
      'poll': instance.poll,
    };

_$PollModelResponseImpl _$$PollModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PollModelResponseImpl(
      id: _parseInt(json['id']),
      content: json['content'] as String?,
      feedPostId: _parseInt(json['feed_post_id']),
      question: json['question'] as String?,
      allowAddOptions: json['allow_add_options'] as bool?,
      allowMultipleChoice: json['allow_multiple_choice'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) =>
              PollOptionsModelResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PollModelResponseImplToJson(
        _$PollModelResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'feed_post_id': instance.feedPostId,
      'question': instance.question,
      'allow_add_options': instance.allowAddOptions,
      'allow_multiple_choice': instance.allowMultipleChoice,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'options': instance.options,
    };

_$PollOptionsModelResponseImpl _$$PollOptionsModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PollOptionsModelResponseImpl(
      id: _parseInt(json['id']),
      pollId: _parseInt(json['poll_id']),
      optionText: json['option_text'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      votesCount: _parseInt(json['votes_count']),
      isVoted: json['is_voted'] as bool?,
    );

Map<String, dynamic> _$$PollOptionsModelResponseImplToJson(
        _$PollOptionsModelResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'poll_id': instance.pollId,
      'option_text': instance.optionText,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'votes_count': instance.votesCount,
      'is_voted': instance.isVoted,
    };

_$GroupDetailsImpl _$$GroupDetailsImplFromJson(Map<String, dynamic> json) =>
    _$GroupDetailsImpl(
      id: _parseInt(json['id']),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$GroupDetailsImplToJson(_$GroupDetailsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
