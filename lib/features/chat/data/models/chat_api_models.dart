// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_api_models.freezed.dart';
part 'chat_api_models.g.dart';

int? _flexibleIntFromJson(Object? value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value.trim());
  return null;
}

bool? _flexibleBoolFromJson(Object? value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final n = value.trim().toLowerCase();
    if (n == 'true' || n == '1') return true;
    if (n == 'false' || n == '0') return false;
  }
  return null;
}

/// REST `chat_type` values — required on most conversation routes.
abstract class ChatApiType {
  static const private = 'private';
  static const caseGroup = 'case_group';
  static const group = 'group';
  static const socialGroup = 'social_group';

  /// Maps any spelling the server, pushes or older builds use to one of the
  /// constants above. The server sends `individual` / `patients` and still
  /// accepts `private` / `case_group` in requests. Null when unknown.
  static String? fromApi(String? raw) {
    final t = raw?.trim().toLowerCase().replaceAll('-', '_');
    if (t == null || t.isEmpty) return null;
    switch (t) {
      case 'individual':
      case 'private':
      case 'private_chat':
      case 'direct':
      case 'dm':
      case 'one_to_one':
        return private;
      case 'patients':
      case 'case_group':
      case 'casegroup':
      case 'patient_group':
      case 'patientgroup':
      case 'patient':
      case 'case':
        return caseGroup;
      case 'social_group':
      case 'socialgroup':
      case 'social':
      case 'social_chat':
      case 'community_group':
        return socialGroup;
      case 'group':
      case 'adhoc_group':
      case 'group_chat':
      case 'ad_hoc':
      case 'adhoc':
        return group;
      default:
        return null;
    }
  }
}

@freezed
class ChatEnvelopeModel with _$ChatEnvelopeModel {
  const factory ChatEnvelopeModel({
    bool? value,
    String? message,
    dynamic data,
  }) = _ChatEnvelopeModel;

  factory ChatEnvelopeModel.fromJson(Map<String, dynamic> json) =>
      _$ChatEnvelopeModelFromJson(json);
}

@freezed
class ChatUserModel with _$ChatUserModel {
  const factory ChatUserModel({
    int? id,
    String? name,
    String? lname,
    String? image,
    String? specialty,
    String? workingplace,
    @JsonKey(name: 'isSyndicateCardRequired') String? isSyndicateCardRequired,
    String? role,
    @JsonKey(name: 'joined_at') String? joinedAt,
    @JsonKey(name: 'mute_notifications', fromJson: _flexibleBoolFromJson)
    bool? muteNotifications,
  }) = _ChatUserModel;

  factory ChatUserModel.fromJson(Map<String, dynamic> json) =>
      _$ChatUserModelFromJson(json);
}

@freezed
class ChatAttachmentModel with _$ChatAttachmentModel {
  const factory ChatAttachmentModel({
    int? id,
    String? type,
    @JsonKey(name: 'original_name') String? originalName,
    @JsonKey(name: 'mime_type') String? mimeType,
    @JsonKey(name: 'size_bytes', fromJson: _flexibleIntFromJson) int? sizeBytes,
    @JsonKey(name: 'duration_seconds', fromJson: _flexibleIntFromJson)
    int? durationSeconds,
    @JsonKey(fromJson: _attachmentUrlFromJson) String? url,
  }) = _ChatAttachmentModel;

  factory ChatAttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$ChatAttachmentModelFromJson(_normalizeAttachmentJson(json));
}

/// Ably / some REST payloads use path or file_url instead of url.
Map<String, dynamic> _normalizeAttachmentJson(Map<String, dynamic> json) {
  final normalized = Map<String, dynamic>.from(json);
  final existing = normalized['url']?.toString().trim();
  if (existing == null || existing.isEmpty) {
    final fallback = normalized['path'] ??
        normalized['file_url'] ??
        normalized['fileUrl'] ??
        normalized['signed_url'];
    if (fallback != null) {
      normalized['url'] = fallback.toString();
    }
  }
  return normalized;
}

String? _attachmentUrlFromJson(Object? value) {
  if (value == null) return null;
  final s = value.toString().trim();
  return s.isEmpty ? null : s;
}

@freezed
class ChatReactionModel with _$ChatReactionModel {
  const factory ChatReactionModel({
    String? emoji,
    @JsonKey(fromJson: _flexibleIntFromJson) int? count,
    List<ChatUserModel>? users,
  }) = _ChatReactionModel;

  factory ChatReactionModel.fromJson(Map<String, dynamic> json) =>
      _$ChatReactionModelFromJson(json);
}

@freezed
class ChatReplyToModel with _$ChatReplyToModel {
  const factory ChatReplyToModel({
    int? id,
    String? type,
    String? content,
    @JsonKey(name: 'sender_id', fromJson: _flexibleIntFromJson) int? senderId,
    ChatUserModel? sender,
  }) = _ChatReplyToModel;

  factory ChatReplyToModel.fromJson(Map<String, dynamic> json) =>
      _$ChatReplyToModelFromJson(json);
}

@freezed
class ChatDeliveryReceiptModel with _$ChatDeliveryReceiptModel {
  const factory ChatDeliveryReceiptModel({
    int? id,
    String? name,
    String? lname,
    String? image,
    String? specialty,
    String? workingplace,
    @JsonKey(name: 'isSyndicateCardRequired') String? isSyndicateCardRequired,
    @JsonKey(name: 'delivered_at') String? deliveredAt,
    @JsonKey(name: 'read_at') String? readAt,
  }) = _ChatDeliveryReceiptModel;

  factory ChatDeliveryReceiptModel.fromJson(Map<String, dynamic> json) =>
      _$ChatDeliveryReceiptModelFromJson(json);
}

@freezed
class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel({
    int? id,
    @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
    int? conversationId,
    ChatUserModel? sender,
    String? type,
    @JsonKey(name: 'system_event') String? systemEvent,
    String? content,
    List<ChatAttachmentModel>? attachments,
    @JsonKey(name: 'reply_to') ChatReplyToModel? replyTo,
    List<ChatUserModel>? reads,
    @JsonKey(name: 'reads_count', fromJson: _flexibleIntFromJson)
    int? readsCount,
    List<ChatReactionModel>? reactions,
    String? status,
    @JsonKey(name: 'delivered_to_count', fromJson: _flexibleIntFromJson)
    int? deliveredToCount,
    @JsonKey(name: 'seen_by_count', fromJson: _flexibleIntFromJson)
    int? seenByCount,
    List<ChatDeliveryReceiptModel>? delivery,
    @JsonKey(name: 'is_deleted', fromJson: _flexibleBoolFromJson)
    bool? isDeleted,
    @JsonKey(name: 'is_edited', fromJson: _flexibleBoolFromJson) bool? isEdited,
    @JsonKey(name: 'is_forwarded', fromJson: _flexibleBoolFromJson)
    bool? isForwarded,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);
}

@freezed
class ChatMessagesListModelResponse with _$ChatMessagesListModelResponse {
  const factory ChatMessagesListModelResponse({
    bool? value,
    String? message,
    List<ChatMessageModel>? data,
    @JsonKey(name: 'has_more', fromJson: _flexibleBoolFromJson) bool? hasMore,
    @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
    int? conversationId,
  }) = _ChatMessagesListModelResponse;

  factory ChatMessagesListModelResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatMessagesListModelResponseFromJson(json);
}

@freezed
class ChatMessageEnvelopeModelResponse with _$ChatMessageEnvelopeModelResponse {
  const factory ChatMessageEnvelopeModelResponse({
    bool? value,
    String? message,
    ChatMessageModel? data,
  }) = _ChatMessageEnvelopeModelResponse;

  factory ChatMessageEnvelopeModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ChatMessageEnvelopeModelResponseFromJson(json);
}

@freezed
class ChatReactionsEnvelopeModelResponse
    with _$ChatReactionsEnvelopeModelResponse {
  const factory ChatReactionsEnvelopeModelResponse({
    bool? value,
    String? message,
    ChatReactionsDataModel? data,
  }) = _ChatReactionsEnvelopeModelResponse;

  factory ChatReactionsEnvelopeModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ChatReactionsEnvelopeModelResponseFromJson(json);
}

@freezed
class ChatReactionsDataModel with _$ChatReactionsDataModel {
  const factory ChatReactionsDataModel({
    List<ChatReactionModel>? reactions,
  }) = _ChatReactionsDataModel;

  factory ChatReactionsDataModel.fromJson(Map<String, dynamic> json) =>
      _$ChatReactionsDataModelFromJson(json);
}

@freezed
class ChatUsersSearchModelResponse with _$ChatUsersSearchModelResponse {
  const factory ChatUsersSearchModelResponse({
    bool? value,
    String? message,
    List<ChatUserModel>? data,
  }) = _ChatUsersSearchModelResponse;

  factory ChatUsersSearchModelResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatUsersSearchModelResponseFromJson(json);
}

@freezed
class ChatPaginatorMeta with _$ChatPaginatorMeta {
  const factory ChatPaginatorMeta({
    @JsonKey(name: 'current_page', fromJson: _flexibleIntFromJson)
    int? currentPage,
    @JsonKey(name: 'per_page', fromJson: _flexibleIntFromJson) int? perPage,
    @JsonKey(fromJson: _flexibleIntFromJson) int? total,
    @JsonKey(name: 'last_page', fromJson: _flexibleIntFromJson) int? lastPage,
  }) = _ChatPaginatorMeta;

  factory ChatPaginatorMeta.fromJson(Map<String, dynamic> json) =>
      _$ChatPaginatorMetaFromJson(json);
}

@freezed
class ChatMessageSearchHit with _$ChatMessageSearchHit {
  const factory ChatMessageSearchHit({
    @JsonKey(name: 'message_id', fromJson: _flexibleIntFromJson) int? messageId,
    @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
    int? conversationId,
    @JsonKey(name: 'chat_type') String? chatType,
    @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson) int? contextId,
    @JsonKey(name: 'conversation_title') String? conversationTitle,
    ChatUserModel? sender,
    String? content,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _ChatMessageSearchHit;

  factory ChatMessageSearchHit.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageSearchHitFromJson(json);
}

@freezed
class ChatMessageSearchData with _$ChatMessageSearchData {
  const factory ChatMessageSearchData({
    List<ChatMessageSearchHit>? items,
    ChatPaginatorMeta? meta,
  }) = _ChatMessageSearchData;

  /// Accepts both `{ items, meta }` and Laravel-style
  /// `{ data: [...], current_page, last_page, per_page, total, meta? }`.
  factory ChatMessageSearchData.fromJson(Map<String, dynamic> json) {
    return ChatMessageSearchData(
      items: _parseMessageSearchHits(json),
      meta: _parseMessageSearchMeta(json),
    );
  }
}

@freezed
class ChatMessageSearchModelResponse with _$ChatMessageSearchModelResponse {
  const factory ChatMessageSearchModelResponse({
    bool? value,
    String? message,
    ChatMessageSearchData? data,
  }) = _ChatMessageSearchModelResponse;

  factory ChatMessageSearchModelResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['data'];
    ChatMessageSearchData? data;
    if (raw is List) {
      data = ChatMessageSearchData(
        items: _parseHitList(raw),
        meta: null,
      );
    } else if (raw is Map<String, dynamic>) {
      data = ChatMessageSearchData.fromJson(raw);
    } else if (raw is Map) {
      data = ChatMessageSearchData.fromJson(Map<String, dynamic>.from(raw));
    }
    return ChatMessageSearchModelResponse(
      value: json['value'] is bool ? json['value'] as bool : null,
      message: json['message']?.toString(),
      data: data,
    );
  }
}

List<ChatMessageSearchHit> _parseHitList(List<dynamic> raw) {
  final items = <ChatMessageSearchHit>[];
  for (final row in raw) {
    if (row is Map<String, dynamic>) {
      items.add(ChatMessageSearchHit.fromJson(row));
    } else if (row is Map) {
      items.add(ChatMessageSearchHit.fromJson(Map<String, dynamic>.from(row)));
    }
  }
  return items;
}

List<ChatMessageSearchHit> _parseMessageSearchHits(Map<String, dynamic> json) {
  final raw = json['items'] ?? json['data'] ?? json['messages'] ?? json['results'];
  if (raw is List) return _parseHitList(raw);
  return const [];
}

ChatPaginatorMeta? _parseMessageSearchMeta(Map<String, dynamic> json) {
  final rawMeta = json['meta'];
  if (rawMeta is Map<String, dynamic>) {
    return ChatPaginatorMeta.fromJson(rawMeta);
  }
  if (rawMeta is Map) {
    return ChatPaginatorMeta.fromJson(Map<String, dynamic>.from(rawMeta));
  }
  // Laravel paginator fields often sit on the same object as the list.
  if (json.containsKey('current_page') ||
      json.containsKey('last_page') ||
      json.containsKey('per_page') ||
      json.containsKey('total')) {
    return ChatPaginatorMeta.fromJson(json);
  }
  return null;
}

@freezed
class ChatConversationModel with _$ChatConversationModel {
  const factory ChatConversationModel({
    int? id,
    String? type,
    @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson) int? contextId,
    String? name,
    String? description,
    String? image,
    @JsonKey(name: 'created_by', fromJson: _flexibleIntFromJson) int? createdBy,
    ChatUserModel? creator,
    @JsonKey(name: 'my_role') String? myRole,
    List<ChatUserModel>? participants,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _ChatConversationModel;

  factory ChatConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ChatConversationModelFromJson(json);
}

@freezed
class ChatConversationEnvelopeModelResponse
    with _$ChatConversationEnvelopeModelResponse {
  const factory ChatConversationEnvelopeModelResponse({
    bool? value,
    String? message,
    ChatConversationModel? data,
  }) = _ChatConversationEnvelopeModelResponse;

  factory ChatConversationEnvelopeModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ChatConversationEnvelopeModelResponseFromJson(json);
}

/// Ably signed TokenRequest from `POST /broadcasting/ably-token`.
@freezed
class AblyTokenRequestModel with _$AblyTokenRequestModel {
  const factory AblyTokenRequestModel({
    String? keyName,
    @JsonKey(fromJson: _flexibleIntFromJson) int? ttl,
    String? capability,
    String? clientId,
    @JsonKey(fromJson: _flexibleIntFromJson) int? timestamp,
    String? nonce,
    String? mac,
  }) = _AblyTokenRequestModel;

  factory AblyTokenRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AblyTokenRequestModelFromJson(json);
}
