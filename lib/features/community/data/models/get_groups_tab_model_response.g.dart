// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_groups_tab_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetGroupsTabModelResponseImpl _$$GetGroupsTabModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetGroupsTabModelResponseImpl(
      data: json['data'] == null
          ? null
          : LatestGroupsData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$GetGroupsTabModelResponseImplToJson(
        _$GetGroupsTabModelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
    };

_$LatestGroupsDataImpl _$$LatestGroupsDataImplFromJson(
        Map<String, dynamic> json) =>
    _$LatestGroupsDataImpl(
      latestGroups: (json['latest_groups'] as List<dynamic>?)
          ?.map((e) => GroupModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      randomPosts: json['random_posts'] == null
          ? null
          : GetPostsCommunityDataModelResponse.fromJson(
              json['random_posts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LatestGroupsDataImplToJson(
        _$LatestGroupsDataImpl instance) =>
    <String, dynamic>{
      'latest_groups': instance.latestGroups,
      'random_posts': instance.randomPosts,
    };

_$GroupModelImpl _$$GroupModelImplFromJson(Map<String, dynamic> json) =>
    _$GroupModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      headerPicture: json['header_picture'] as String?,
      groupImage: json['group_image'] as String?,
      isHasPendingInvitations: json['has_pending_invitations'] as bool?,
      privacy: json['privacy'] as String?,
      ownerId: (json['owner_id'] as num?)?.toInt(),
      invitationId: (json['invitation_id'] as num?)?.toInt(),
      memberCount: (json['member_count'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      userStatus: json['user_status'] as String?,
      owner: json['owner'] == null
          ? null
          : DoctorModel.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GroupModelImplToJson(_$GroupModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'header_picture': instance.headerPicture,
      'group_image': instance.groupImage,
      'has_pending_invitations': instance.isHasPendingInvitations,
      'privacy': instance.privacy,
      'owner_id': instance.ownerId,
      'invitation_id': instance.invitationId,
      'member_count': instance.memberCount,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'user_status': instance.userStatus,
      'owner': instance.owner,
    };
