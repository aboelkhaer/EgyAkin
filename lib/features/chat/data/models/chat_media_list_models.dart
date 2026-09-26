import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';

/// Totals from media responses: `{ "image": 53, "voice": 20, "file": 4 }`.
class ChatMediaCountsModel {
  final int? image;
  final int? voice;
  final int? file;

  const ChatMediaCountsModel({
    this.image,
    this.voice,
    this.file,
  });

  factory ChatMediaCountsModel.fromJson(Map<String, dynamic> json) {
    return ChatMediaCountsModel(
      image: _asInt(json['image'] ?? json['images']),
      voice: _asInt(json['voice'] ?? json['voices']),
      file: _asInt(json['file'] ?? json['files'] ?? json['document']),
    );
  }
}

/// `GET /chat/conversations/{id}/media?type=image|voice|file`
/// Accepts flat `data: []` (+ `has_more`) or Laravel `{ data: { data, meta } }`,
/// and expands message-shaped rows that nest `attachments`.
class ChatMediaListModelResponse {
  final bool? value;
  final String? message;
  final List<ChatMediaItemModel> items;
  final bool? hasMore;
  final ChatPaginatorMeta? meta;
  final ChatMediaCountsModel? counts;

  const ChatMediaListModelResponse({
    this.value,
    this.message,
    this.items = const [],
    this.hasMore,
    this.meta,
    this.counts,
  });

  factory ChatMediaListModelResponse.fromJson(Map<String, dynamic> json) {
    final items = <ChatMediaItemModel>[];
    ChatPaginatorMeta? meta;
    ChatMediaCountsModel? counts;
    bool? hasMore;

    void parseMeta(Object? raw) {
      if (raw is Map<String, dynamic>) {
        meta = ChatPaginatorMeta.fromJson(raw);
      } else if (raw is Map) {
        meta = ChatPaginatorMeta.fromJson(Map<String, dynamic>.from(raw));
      }
    }

    void parseCounts(Object? raw) {
      if (raw is Map<String, dynamic>) {
        counts = ChatMediaCountsModel.fromJson(raw);
      } else if (raw is Map) {
        counts = ChatMediaCountsModel.fromJson(Map<String, dynamic>.from(raw));
      }
    }

    void parseList(Object? raw) {
      if (raw is! List) return;
      for (final row in raw) {
        if (row is Map<String, dynamic>) {
          items.addAll(ChatMediaItemModel.expandRow(row));
        } else if (row is Map) {
          items.addAll(
            ChatMediaItemModel.expandRow(Map<String, dynamic>.from(row)),
          );
        }
      }
    }

    final rawData = json['data'];
    parseCounts(json['counts']);
    if (rawData is List) {
      parseList(rawData);
      hasMore = _asBool(json['has_more']);
      parseMeta(json['meta']);
    } else if (rawData is Map) {
      final map = rawData is Map<String, dynamic>
          ? rawData
          : Map<String, dynamic>.from(rawData);
      parseList(map['data'] ?? map['items'] ?? map['media']);
      parseMeta(map['meta'] ?? json['meta']);
      hasMore = _asBool(map['has_more'] ?? json['has_more']);
      if (counts == null) parseCounts(map['counts']);
    } else {
      parseMeta(json['meta']);
      hasMore = _asBool(json['has_more']);
    }

    if (hasMore == null && meta != null) {
      final current = meta!.currentPage ?? 1;
      final last = meta!.lastPage ?? current;
      hasMore = current < last;
    }

    return ChatMediaListModelResponse(
      value: json['value'] is bool ? json['value'] as bool : null,
      message: json['message']?.toString(),
      items: items,
      hasMore: hasMore,
      meta: meta,
      counts: counts,
    );
  }
}

class ChatMediaItemModel {
  final int? id;
  final int? messageId;
  final String? type;
  final String? originalName;
  final String? mimeType;
  final int? sizeBytes;
  final String? url;
  final String? createdAt;
  final int? durationSeconds;
  final int? senderId;
  final String? senderName;
  final String? senderImageUrl;
  final String? senderInitials;

  const ChatMediaItemModel({
    this.id,
    this.messageId,
    this.type,
    this.originalName,
    this.mimeType,
    this.sizeBytes,
    this.url,
    this.createdAt,
    this.durationSeconds,
    this.senderId,
    this.senderName,
    this.senderImageUrl,
    this.senderInitials,
  });

  factory ChatMediaItemModel.fromJson(Map<String, dynamic> json) {
    final sender = _senderFromJson(json);
    return ChatMediaItemModel(
      id: _asInt(json['id']),
      messageId: _asInt(json['message_id'] ?? json['messageId']),
      type: json['type']?.toString(),
      originalName:
          (json['original_name'] ?? json['name'] ?? json['file_name'])
              ?.toString(),
      mimeType: (json['mime_type'] ?? json['mime'])?.toString(),
      sizeBytes: _asInt(json['size_bytes'] ?? json['size']),
      url: (json['url'] ?? json['path'] ?? json['file_url'])?.toString(),
      createdAt: (json['created_at'] ?? json['sent_at'])?.toString(),
      durationSeconds: _asInt(
        json['duration_seconds'] ??
            json['durationSeconds'] ??
            json['duration'],
      ),
      senderId: sender?.id ??
          _asInt(json['sender_id'] ?? json['user_id'] ?? json['userId']),
      senderName: _senderDisplayName(sender) ??
          (json['sender_name'] ?? json['user_name'])?.toString(),
      senderImageUrl: sender?.image ??
          (json['sender_image'] ??
                  json['sender_image_url'] ??
                  json['user_image'])
              ?.toString(),
      senderInitials: _senderInitials(sender),
    );
  }

  /// Supports attachment rows and message rows with nested attachments.
  static List<ChatMediaItemModel> expandRow(Map<String, dynamic> json) {
    final attachments = json['attachments'];
    if (attachments is List && attachments.isNotEmpty) {
      final messageId = _asInt(json['id']);
      final createdAt = json['created_at']?.toString();
      final sender = _senderFromJson(json);
      final senderId = sender?.id ??
          _asInt(json['sender_id'] ?? json['user_id'] ?? json['userId']);
      final senderName = _senderDisplayName(sender) ??
          (json['sender_name'] ?? json['user_name'])?.toString();
      final senderImage = sender?.image ??
          (json['sender_image'] ??
                  json['sender_image_url'] ??
                  json['user_image'])
              ?.toString();
      final senderInitials = _senderInitials(sender);
      final out = <ChatMediaItemModel>[];
      for (final a in attachments) {
        if (a is! Map) continue;
        final map = a is Map<String, dynamic>
            ? a
            : Map<String, dynamic>.from(a);
        final item = ChatMediaItemModel.fromJson(map);
        out.add(
          ChatMediaItemModel(
            id: item.id,
            messageId: item.messageId ?? messageId,
            type: item.type,
            originalName: item.originalName,
            mimeType: item.mimeType,
            sizeBytes: item.sizeBytes,
            url: item.url,
            createdAt: item.createdAt ?? createdAt,
            durationSeconds: item.durationSeconds,
            senderId: item.senderId ?? senderId,
            senderName: item.senderName ?? senderName,
            senderImageUrl: item.senderImageUrl ?? senderImage,
            senderInitials: item.senderInitials ?? senderInitials,
          ),
        );
      }
      return out;
    }

    // Nested single attachment object.
    final nested = json['attachment'];
    if (nested is Map) {
      final map = nested is Map<String, dynamic>
          ? nested
          : Map<String, dynamic>.from(nested);
      final item = ChatMediaItemModel.fromJson(map);
      final sender = _senderFromJson(json);
      return [
        ChatMediaItemModel(
          id: item.id,
          messageId: item.messageId ?? _asInt(json['message_id'] ?? json['id']),
          type: item.type ?? json['type']?.toString(),
          originalName: item.originalName,
          mimeType: item.mimeType,
          sizeBytes: item.sizeBytes,
          url: item.url,
          createdAt: item.createdAt ?? json['created_at']?.toString(),
          durationSeconds: item.durationSeconds,
          senderId: item.senderId ??
              sender?.id ??
              _asInt(json['sender_id'] ?? json['user_id']),
          senderName: item.senderName ??
              _senderDisplayName(sender) ??
              json['sender_name']?.toString(),
          senderImageUrl: item.senderImageUrl ??
              sender?.image ??
              json['sender_image']?.toString(),
          senderInitials: item.senderInitials ?? _senderInitials(sender),
        ),
      ];
    }

    return [ChatMediaItemModel.fromJson(json)];
  }

  ChatAttachmentModel toAttachmentModel() {
    return ChatAttachmentModel(
      id: id,
      type: type,
      originalName: originalName,
      mimeType: mimeType,
      sizeBytes: sizeBytes,
      url: url,
      durationSeconds: durationSeconds,
    );
  }
}

ChatUserModel? _senderFromJson(Map<String, dynamic> json) {
  final raw = json['sender'] ?? json['user'] ?? json['from'];
  if (raw is! Map) return null;
  final map =
      raw is Map<String, dynamic> ? raw : Map<String, dynamic>.from(raw);
  try {
    return ChatUserModel.fromJson(map);
  } catch (_) {
    return null;
  }
}

String? _senderDisplayName(ChatUserModel? user) {
  if (user == null) return null;
  final first = user.name?.trim() ?? '';
  final last = user.lname?.trim() ?? '';
  final name = [first, last].where((p) => p.isNotEmpty).join(' ').trim();
  return name.isEmpty ? null : name;
}

String? _senderInitials(ChatUserModel? user) {
  if (user == null) return null;
  final first = user.name?.trim();
  final last = user.lname?.trim();
  final a = (first != null && first.isNotEmpty) ? first[0] : '';
  final b = (last != null && last.isNotEmpty) ? last[0] : '';
  final initials = '$a$b'.toUpperCase();
  return initials.isEmpty ? null : initials;
}

int? _asInt(Object? v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v.trim());
  return null;
}

bool? _asBool(Object? v) {
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
