// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_inbox_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetInboxModelResponseImpl _$$GetInboxModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetInboxModelResponseImpl(
      value: json['value'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : InboxDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetInboxModelResponseImplToJson(
        _$GetInboxModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
      'data': instance.data,
    };

_$InboxDataModelImpl _$$InboxDataModelImplFromJson(Map<String, dynamic> json) =>
    _$InboxDataModelImpl(
      filter: json['filter'] as String?,
      counts: json['counts'] == null
          ? null
          : InboxCountsModel.fromJson(json['counts'] as Map<String, dynamic>),
      sectionCounts: json['section_counts'] == null
          ? null
          : InboxSectionCountsModel.fromJson(
              json['section_counts'] as Map<String, dynamic>),
      totalUnread: _flexibleIntFromJson(json['total_unread']),
      filterTitles: (json['filter_titles'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      sectionTitles: (json['section_titles'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => InboxItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : InboxPaginatorMetaModel.fromJson(
              json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$InboxDataModelImplToJson(
        _$InboxDataModelImpl instance) =>
    <String, dynamic>{
      'filter': instance.filter,
      'counts': instance.counts,
      'section_counts': instance.sectionCounts,
      'total_unread': instance.totalUnread,
      'filter_titles': instance.filterTitles,
      'section_titles': instance.sectionTitles,
      'items': instance.items,
      'meta': instance.meta,
    };

_$InboxCountsModelImpl _$$InboxCountsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$InboxCountsModelImpl(
      all: _flexibleIntFromJson(json['all']),
      doctors: _flexibleIntFromJson(json['doctors']),
      people: _flexibleIntFromJson(json['people']),
      patients: _flexibleIntFromJson(json['patients']),
      groups: _flexibleIntFromJson(json['groups']),
      socialGroups: _flexibleIntFromJson(json['social_groups']),
      consults: _flexibleIntFromJson(json['consults']),
    );

Map<String, dynamic> _$$InboxCountsModelImplToJson(
        _$InboxCountsModelImpl instance) =>
    <String, dynamic>{
      'all': instance.all,
      'doctors': instance.doctors,
      'people': instance.people,
      'patients': instance.patients,
      'groups': instance.groups,
      'social_groups': instance.socialGroups,
      'consults': instance.consults,
    };

_$InboxSectionCountsModelImpl _$$InboxSectionCountsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$InboxSectionCountsModelImpl(
      priority: _flexibleIntFromJson(json['priority']),
      earlier: _flexibleIntFromJson(json['earlier']),
    );

Map<String, dynamic> _$$InboxSectionCountsModelImplToJson(
        _$InboxSectionCountsModelImpl instance) =>
    <String, dynamic>{
      'priority': instance.priority,
      'earlier': instance.earlier,
    };

_$InboxItemModelImpl _$$InboxItemModelImplFromJson(Map<String, dynamic> json) =>
    _$InboxItemModelImpl(
      source: json['source'] as String?,
      id: (json['id'] as num?)?.toInt(),
      chatType: json['chat_type'] as String?,
      contextId: _flexibleIntFromJson(json['context_id']),
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      counterpart: json['counterpart'] == null
          ? null
          : ChatUserModel.fromJson(json['counterpart'] as Map<String, dynamic>),
      image: json['image'] as String?,
      isUrgent: _flexibleBoolFromJson(json['is_urgent']),
      unreadCount: _flexibleIntFromJson(json['unread_count']),
      section: json['section'] as String?,
      lastMessage: json['last_message'] == null
          ? null
          : InboxLastMessageModel.fromJson(
              json['last_message'] as Map<String, dynamic>),
      isOpen: _flexibleBoolFromJson(json['is_open']),
      direction: json['direction'] as String?,
      lastActivityAt: json['last_activity_at'] as String?,
    );

Map<String, dynamic> _$$InboxItemModelImplToJson(
        _$InboxItemModelImpl instance) =>
    <String, dynamic>{
      'source': instance.source,
      'id': instance.id,
      'chat_type': instance.chatType,
      'context_id': instance.contextId,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'counterpart': instance.counterpart,
      'image': instance.image,
      'is_urgent': instance.isUrgent,
      'unread_count': instance.unreadCount,
      'section': instance.section,
      'last_message': instance.lastMessage,
      'is_open': instance.isOpen,
      'direction': instance.direction,
      'last_activity_at': instance.lastActivityAt,
    };

_$InboxLastMessageModelImpl _$$InboxLastMessageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$InboxLastMessageModelImpl(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      content: json['content'] as String?,
      senderId: _flexibleIntFromJson(json['sender_id']),
      isMine: _flexibleBoolFromJson(json['is_mine']),
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => ChatAttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$InboxLastMessageModelImplToJson(
        _$InboxLastMessageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'content': instance.content,
      'sender_id': instance.senderId,
      'is_mine': instance.isMine,
      'status': instance.status,
      'created_at': instance.createdAt,
      'attachments': instance.attachments,
    };

_$InboxPaginatorMetaModelImpl _$$InboxPaginatorMetaModelImplFromJson(
        Map<String, dynamic> json) =>
    _$InboxPaginatorMetaModelImpl(
      currentPage: _flexibleIntFromJson(json['current_page']),
      perPage: _flexibleIntFromJson(json['per_page']),
      total: _flexibleIntFromJson(json['total']),
      lastPage: _flexibleIntFromJson(json['last_page']),
    );

Map<String, dynamic> _$$InboxPaginatorMetaModelImplToJson(
        _$InboxPaginatorMetaModelImpl instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'per_page': instance.perPage,
      'total': instance.total,
      'last_page': instance.lastPage,
    };
