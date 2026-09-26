// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatEnvelopeModelImpl _$$ChatEnvelopeModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatEnvelopeModelImpl(
      value: json['value'] as bool?,
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$$ChatEnvelopeModelImplToJson(
        _$ChatEnvelopeModelImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
      'data': instance.data,
    };

_$ChatUserModelImpl _$$ChatUserModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatUserModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      lname: json['lname'] as String?,
      image: json['image'] as String?,
      specialty: json['specialty'] as String?,
      workingplace: json['workingplace'] as String?,
      isSyndicateCardRequired: json['isSyndicateCardRequired'] as String?,
      role: json['role'] as String?,
      joinedAt: json['joined_at'] as String?,
      muteNotifications: _flexibleBoolFromJson(json['mute_notifications']),
    );

Map<String, dynamic> _$$ChatUserModelImplToJson(_$ChatUserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lname': instance.lname,
      'image': instance.image,
      'specialty': instance.specialty,
      'workingplace': instance.workingplace,
      'isSyndicateCardRequired': instance.isSyndicateCardRequired,
      'role': instance.role,
      'joined_at': instance.joinedAt,
      'mute_notifications': instance.muteNotifications,
    };

_$ChatAttachmentModelImpl _$$ChatAttachmentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatAttachmentModelImpl(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      originalName: json['original_name'] as String?,
      mimeType: json['mime_type'] as String?,
      sizeBytes: _flexibleIntFromJson(json['size_bytes']),
      durationSeconds: _flexibleIntFromJson(json['duration_seconds']),
      url: _attachmentUrlFromJson(json['url']),
    );

Map<String, dynamic> _$$ChatAttachmentModelImplToJson(
        _$ChatAttachmentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'original_name': instance.originalName,
      'mime_type': instance.mimeType,
      'size_bytes': instance.sizeBytes,
      'duration_seconds': instance.durationSeconds,
      'url': instance.url,
    };

_$ChatReactionModelImpl _$$ChatReactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatReactionModelImpl(
      emoji: json['emoji'] as String?,
      count: _flexibleIntFromJson(json['count']),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => ChatUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ChatReactionModelImplToJson(
        _$ChatReactionModelImpl instance) =>
    <String, dynamic>{
      'emoji': instance.emoji,
      'count': instance.count,
      'users': instance.users,
    };

_$ChatReplyToModelImpl _$$ChatReplyToModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatReplyToModelImpl(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      content: json['content'] as String?,
      senderId: _flexibleIntFromJson(json['sender_id']),
      sender: json['sender'] == null
          ? null
          : ChatUserModel.fromJson(json['sender'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatReplyToModelImplToJson(
        _$ChatReplyToModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'content': instance.content,
      'sender_id': instance.senderId,
      'sender': instance.sender,
    };

_$ChatDeliveryReceiptModelImpl _$$ChatDeliveryReceiptModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatDeliveryReceiptModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      lname: json['lname'] as String?,
      image: json['image'] as String?,
      specialty: json['specialty'] as String?,
      workingplace: json['workingplace'] as String?,
      isSyndicateCardRequired: json['isSyndicateCardRequired'] as String?,
      deliveredAt: json['delivered_at'] as String?,
      readAt: json['read_at'] as String?,
    );

Map<String, dynamic> _$$ChatDeliveryReceiptModelImplToJson(
        _$ChatDeliveryReceiptModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lname': instance.lname,
      'image': instance.image,
      'specialty': instance.specialty,
      'workingplace': instance.workingplace,
      'isSyndicateCardRequired': instance.isSyndicateCardRequired,
      'delivered_at': instance.deliveredAt,
      'read_at': instance.readAt,
    };

_$ChatMessageModelImpl _$$ChatMessageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageModelImpl(
      id: (json['id'] as num?)?.toInt(),
      conversationId: _flexibleIntFromJson(json['conversation_id']),
      sender: json['sender'] == null
          ? null
          : ChatUserModel.fromJson(json['sender'] as Map<String, dynamic>),
      type: json['type'] as String?,
      systemEvent: json['system_event'] as String?,
      content: json['content'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => ChatAttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      replyTo: json['reply_to'] == null
          ? null
          : ChatReplyToModel.fromJson(json['reply_to'] as Map<String, dynamic>),
      reads: (json['reads'] as List<dynamic>?)
          ?.map((e) => ChatUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      readsCount: _flexibleIntFromJson(json['reads_count']),
      reactions: (json['reactions'] as List<dynamic>?)
          ?.map((e) => ChatReactionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      deliveredToCount: _flexibleIntFromJson(json['delivered_to_count']),
      seenByCount: _flexibleIntFromJson(json['seen_by_count']),
      delivery: (json['delivery'] as List<dynamic>?)
          ?.map((e) =>
              ChatDeliveryReceiptModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isDeleted: _flexibleBoolFromJson(json['is_deleted']),
      isEdited: _flexibleBoolFromJson(json['is_edited']),
      isForwarded: _flexibleBoolFromJson(json['is_forwarded']),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$ChatMessageModelImplToJson(
        _$ChatMessageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversation_id': instance.conversationId,
      'sender': instance.sender,
      'type': instance.type,
      'system_event': instance.systemEvent,
      'content': instance.content,
      'attachments': instance.attachments,
      'reply_to': instance.replyTo,
      'reads': instance.reads,
      'reads_count': instance.readsCount,
      'reactions': instance.reactions,
      'status': instance.status,
      'delivered_to_count': instance.deliveredToCount,
      'seen_by_count': instance.seenByCount,
      'delivery': instance.delivery,
      'is_deleted': instance.isDeleted,
      'is_edited': instance.isEdited,
      'is_forwarded': instance.isForwarded,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_$ChatMessagesListModelResponseImpl
    _$$ChatMessagesListModelResponseImplFromJson(Map<String, dynamic> json) =>
        _$ChatMessagesListModelResponseImpl(
          value: json['value'] as bool?,
          message: json['message'] as String?,
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>))
              .toList(),
          hasMore: _flexibleBoolFromJson(json['has_more']),
          conversationId: _flexibleIntFromJson(json['conversation_id']),
        );

Map<String, dynamic> _$$ChatMessagesListModelResponseImplToJson(
        _$ChatMessagesListModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
      'data': instance.data,
      'has_more': instance.hasMore,
      'conversation_id': instance.conversationId,
    };

_$ChatMessageEnvelopeModelResponseImpl
    _$$ChatMessageEnvelopeModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$ChatMessageEnvelopeModelResponseImpl(
          value: json['value'] as bool?,
          message: json['message'] as String?,
          data: json['data'] == null
              ? null
              : ChatMessageModel.fromJson(json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$ChatMessageEnvelopeModelResponseImplToJson(
        _$ChatMessageEnvelopeModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
      'data': instance.data,
    };

_$ChatReactionsEnvelopeModelResponseImpl
    _$$ChatReactionsEnvelopeModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$ChatReactionsEnvelopeModelResponseImpl(
          value: json['value'] as bool?,
          message: json['message'] as String?,
          data: json['data'] == null
              ? null
              : ChatReactionsDataModel.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$ChatReactionsEnvelopeModelResponseImplToJson(
        _$ChatReactionsEnvelopeModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
      'data': instance.data,
    };

_$ChatReactionsDataModelImpl _$$ChatReactionsDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatReactionsDataModelImpl(
      reactions: (json['reactions'] as List<dynamic>?)
          ?.map((e) => ChatReactionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ChatReactionsDataModelImplToJson(
        _$ChatReactionsDataModelImpl instance) =>
    <String, dynamic>{
      'reactions': instance.reactions,
    };

_$ChatUsersSearchModelResponseImpl _$$ChatUsersSearchModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatUsersSearchModelResponseImpl(
      value: json['value'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ChatUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ChatUsersSearchModelResponseImplToJson(
        _$ChatUsersSearchModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
      'data': instance.data,
    };

_$ChatPaginatorMetaImpl _$$ChatPaginatorMetaImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatPaginatorMetaImpl(
      currentPage: _flexibleIntFromJson(json['current_page']),
      perPage: _flexibleIntFromJson(json['per_page']),
      total: _flexibleIntFromJson(json['total']),
      lastPage: _flexibleIntFromJson(json['last_page']),
    );

Map<String, dynamic> _$$ChatPaginatorMetaImplToJson(
        _$ChatPaginatorMetaImpl instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'per_page': instance.perPage,
      'total': instance.total,
      'last_page': instance.lastPage,
    };

_$ChatMessageSearchHitImpl _$$ChatMessageSearchHitImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageSearchHitImpl(
      messageId: _flexibleIntFromJson(json['message_id']),
      conversationId: _flexibleIntFromJson(json['conversation_id']),
      chatType: json['chat_type'] as String?,
      contextId: _flexibleIntFromJson(json['context_id']),
      conversationTitle: json['conversation_title'] as String?,
      sender: json['sender'] == null
          ? null
          : ChatUserModel.fromJson(json['sender'] as Map<String, dynamic>),
      content: json['content'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$ChatMessageSearchHitImplToJson(
        _$ChatMessageSearchHitImpl instance) =>
    <String, dynamic>{
      'message_id': instance.messageId,
      'conversation_id': instance.conversationId,
      'chat_type': instance.chatType,
      'context_id': instance.contextId,
      'conversation_title': instance.conversationTitle,
      'sender': instance.sender,
      'content': instance.content,
      'created_at': instance.createdAt,
    };

_$ChatConversationModelImpl _$$ChatConversationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatConversationModelImpl(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      contextId: _flexibleIntFromJson(json['context_id']),
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      createdBy: _flexibleIntFromJson(json['created_by']),
      creator: json['creator'] == null
          ? null
          : ChatUserModel.fromJson(json['creator'] as Map<String, dynamic>),
      myRole: json['my_role'] as String?,
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => ChatUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$ChatConversationModelImplToJson(
        _$ChatConversationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'context_id': instance.contextId,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'created_by': instance.createdBy,
      'creator': instance.creator,
      'my_role': instance.myRole,
      'participants': instance.participants,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_$ChatConversationEnvelopeModelResponseImpl
    _$$ChatConversationEnvelopeModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$ChatConversationEnvelopeModelResponseImpl(
          value: json['value'] as bool?,
          message: json['message'] as String?,
          data: json['data'] == null
              ? null
              : ChatConversationModel.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$ChatConversationEnvelopeModelResponseImplToJson(
        _$ChatConversationEnvelopeModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
      'data': instance.data,
    };

_$AblyTokenRequestModelImpl _$$AblyTokenRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AblyTokenRequestModelImpl(
      keyName: json['keyName'] as String?,
      ttl: _flexibleIntFromJson(json['ttl']),
      capability: json['capability'] as String?,
      clientId: json['clientId'] as String?,
      timestamp: _flexibleIntFromJson(json['timestamp']),
      nonce: json['nonce'] as String?,
      mac: json['mac'] as String?,
    );

Map<String, dynamic> _$$AblyTokenRequestModelImplToJson(
        _$AblyTokenRequestModelImpl instance) =>
    <String, dynamic>{
      'keyName': instance.keyName,
      'ttl': instance.ttl,
      'capability': instance.capability,
      'clientId': instance.clientId,
      'timestamp': instance.timestamp,
      'nonce': instance.nonce,
      'mac': instance.mac,
    };
