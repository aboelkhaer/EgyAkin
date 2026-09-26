// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/inbox/data/models/get_inbox_model_response.dart';

/// `GET /chat/conversations` list envelope (incl. `?archived=1`).
/// Shape: `{ value, message, data: { counts, data: [...], links, meta } }`.
class ChatConversationsListModelResponse {
  final bool? value;
  final String? message;
  final ChatConversationsListData? data;

  const ChatConversationsListModelResponse({
    this.value,
    this.message,
    this.data,
  });

  factory ChatConversationsListModelResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    final raw = json['data'];
    return ChatConversationsListModelResponse(
      value: json['value'] is bool ? json['value'] as bool : null,
      message: json['message']?.toString(),
      data: raw is Map<String, dynamic>
          ? ChatConversationsListData.fromJson(raw)
          : (raw is Map
              ? ChatConversationsListData.fromJson(
                  Map<String, dynamic>.from(raw),
                )
              : null),
    );
  }

  List<ChatConversationListItemModel> get items => data?.items ?? const [];

  bool get hasMore {
    final meta = data?.meta;
    if (meta == null) return false;
    final current = meta.currentPage ?? 1;
    final last = meta.lastPage ?? current;
    return current < last;
  }
}

class ChatConversationsListData {
  final InboxCountsModel? counts;
  final List<ChatConversationListItemModel> items;
  final ChatPaginatorMeta? meta;

  const ChatConversationsListData({
    this.counts,
    this.items = const [],
    this.meta,
  });

  factory ChatConversationsListData.fromJson(Map<String, dynamic> json) {
    final rawItems = json['data'];
    final items = <ChatConversationListItemModel>[];
    if (rawItems is List) {
      for (final row in rawItems) {
        if (row is Map<String, dynamic>) {
          items.add(ChatConversationListItemModel.fromJson(row));
        } else if (row is Map) {
          items.add(
            ChatConversationListItemModel.fromJson(
              Map<String, dynamic>.from(row),
            ),
          );
        }
      }
    }

    ChatPaginatorMeta? meta;
    final rawMeta = json['meta'];
    if (rawMeta is Map<String, dynamic>) {
      meta = ChatPaginatorMeta.fromJson(rawMeta);
    } else if (rawMeta is Map) {
      meta = ChatPaginatorMeta.fromJson(Map<String, dynamic>.from(rawMeta));
    }

    InboxCountsModel? counts;
    final rawCounts = json['counts'];
    if (rawCounts is Map<String, dynamic>) {
      counts = InboxCountsModel.fromJson(rawCounts);
    } else if (rawCounts is Map) {
      counts = InboxCountsModel.fromJson(Map<String, dynamic>.from(rawCounts));
    }

    return ChatConversationsListData(
      counts: counts,
      items: items,
      meta: meta,
    );
  }
}

/// One row from `GET /chat/conversations` (normal or archived).
class ChatConversationListItemModel {
  final int? id;
  final String? type;
  final int? contextId;
  final String? name;
  final String? title;
  final String? subtitle;
  final String? image;
  final bool? isArchived;
  final bool? isPinned;
  final bool? isMuted;
  final int? unreadCount;
  final ChatUserModel? counterpart;
  final InboxLastMessageModel? lastMessage;
  final String? lastActivityAt;
  final List<ChatUserModel>? participants;
  final String? updatedAt;
  final String? createdAt;

  const ChatConversationListItemModel({
    this.id,
    this.type,
    this.contextId,
    this.name,
    this.title,
    this.subtitle,
    this.image,
    this.isArchived,
    this.isPinned,
    this.isMuted,
    this.unreadCount,
    this.counterpart,
    this.lastMessage,
    this.lastActivityAt,
    this.participants,
    this.updatedAt,
    this.createdAt,
  });

  factory ChatConversationListItemModel.fromJson(Map<String, dynamic> json) {
    int? asInt(Object? v) {
      if (v == null) return null;
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) return int.tryParse(v.trim());
      return null;
    }

    bool? asBool(Object? v) {
      if (v == null) return null;
      if (v is bool) return v;
      if (v is num) return v != 0;
      if (v is String) {
        final n = v.trim().toLowerCase();
        if (n == 'true' || n == '1') return true;
        if (n == 'false' || n == '0') return false;
      }
      return null;
    }

    ChatUserModel? counterpart;
    final rawCounterpart = json['counterpart'] ?? json['peer'] ?? json['user'];
    if (rawCounterpart is Map<String, dynamic>) {
      counterpart = ChatUserModel.fromJson(rawCounterpart);
    } else if (rawCounterpart is Map) {
      counterpart =
          ChatUserModel.fromJson(Map<String, dynamic>.from(rawCounterpart));
    }

    InboxLastMessageModel? lastMessage;
    final rawLast = json['last_message'];
    if (rawLast is Map<String, dynamic>) {
      lastMessage = InboxLastMessageModel.fromJson(rawLast);
    } else if (rawLast is Map) {
      lastMessage =
          InboxLastMessageModel.fromJson(Map<String, dynamic>.from(rawLast));
    }

    List<ChatUserModel>? participants;
    final rawParticipants = json['participants'];
    if (rawParticipants is List) {
      participants = [
        for (final p in rawParticipants)
          if (p is Map<String, dynamic>)
            ChatUserModel.fromJson(p)
          else if (p is Map)
            ChatUserModel.fromJson(Map<String, dynamic>.from(p)),
      ];
    }

    return ChatConversationListItemModel(
      id: asInt(json['id']),
      type: (json['type'] ?? json['chat_type'])?.toString(),
      contextId: asInt(json['context_id']),
      name: json['name']?.toString(),
      title: json['title']?.toString(),
      subtitle: json['subtitle']?.toString(),
      image: json['image']?.toString(),
      isArchived: asBool(json['is_archived']),
      isPinned: asBool(json['is_pinned'] ?? json['pinned']),
      isMuted: asBool(json['is_muted'] ?? json['muted']),
      unreadCount: asInt(json['unread_count']),
      counterpart: counterpart,
      lastMessage: lastMessage,
      lastActivityAt: (json['last_activity_at'] ?? json['updated_at'])
          ?.toString(),
      participants: participants,
      updatedAt: json['updated_at']?.toString(),
      createdAt: json['created_at']?.toString(),
    );
  }
}
