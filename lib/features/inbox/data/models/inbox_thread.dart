// Inbox thread UI models for the Chats tab.

import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat/data/models/chat_composer_activity.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';

enum InboxFilter { all, doctors, patients, groups, socialGroups, consults }

enum InboxPreviewKind { text, photo, voice, video, file }

enum InboxThreadKind {
  doctor,
  group,
  patient,
  consult,
  caseNote,
  support,
  admin,
}

extension InboxThreadKindX on InboxThreadKind {
  bool get opensChatRoom => this != InboxThreadKind.admin;
}

class InboxThread {
  final String id;
  final String title;
  final String subtitle;
  final String preview;
  final String timeLabel;
  final String initials;
  final InboxThreadKind kind;
  final int unreadCount;
  final bool isOnline;
  final bool isTyping;
  final ChatComposerActivity peerActivity;
  final bool isUrgent;
  final bool isVerified;
  final bool isPriority;
  final bool isAdminBadge;
  /// Status of the last outgoing message; null when last message is incoming.
  final ChatMessageStatus? lastMessageStatus;
  final InboxPreviewKind previewKind;
  /// How many media items the last message preview represents (e.g. 2 photos).
  final int previewCount;
  final InboxFilter filter;
  /// `chat` or `consultation` from unified inbox API.
  final String? source;
  final String? chatType;
  final int? contextId;
  final int? conversationId;
  final String? imageUrl;
  final int? counterpartUserId;
  final bool? isConsultationOpen;
  final String? consultationDirection;
  final bool isPinned;
  final bool isMuted;

  /// Server id of the message shown in [preview]; null when unknown (e.g.
  /// after an `inbox.updated` that carried no id).
  final int? lastMessageId;

  const InboxThread({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.preview,
    required this.timeLabel,
    required this.initials,
    required this.kind,
    this.unreadCount = 0,
    this.isOnline = false,
    this.isTyping = false,
    this.peerActivity = ChatComposerActivity.none,
    this.isUrgent = false,
    this.isVerified = false,
    this.isPriority = false,
    this.isAdminBadge = false,
    this.lastMessageStatus,
    this.previewKind = InboxPreviewKind.text,
    this.previewCount = 1,
    required this.filter,
    this.source,
    this.chatType,
    this.contextId,
    this.conversationId,
    this.imageUrl,
    this.counterpartUserId,
    this.isConsultationOpen,
    this.consultationDirection,
    this.isPinned = false,
    this.isMuted = false,
    this.lastMessageId,
  });

  bool get hasPeerActivity => peerActivity.isActive || isTyping;

  bool get isChatThread =>
      source == 'chat' && chatType != null && contextId != null;

  bool get isConsultationThread =>
      source == 'consultation' && counterpartUserId != null;

  /// Private chat params for opening the chat room (includes legacy consult rows).
  String? get resolvedChatType {
    final raw = chatType ?? (source == 'consultation' ? 'private' : null);
    if (raw == null) return null;
    return ChatApiType.fromApi(raw) ??
        raw.trim().toLowerCase().replaceAll('-', '_');
  }

  /// Address id for chat endpoints — depends on [resolvedChatType].
  /// Ad-hoc / case groups use conversation id when `context_id` was omitted.
  int? get resolvedContextId =>
      contextId ??
      ((resolvedChatType == 'group' || resolvedChatType == 'case_group')
          ? conversationId
          : null) ??
      counterpartUserId;

  bool get isGroupLike {
    final t = resolvedChatType;
    if (t == 'group' || t == 'social_group' || t == 'case_group') {
      return true;
    }
    if (kind == InboxThreadKind.patient) return true;
    if (filter == InboxFilter.patients) return true;
    final s = subtitle.toLowerCase();
    return s.contains('patient case') || s.contains('patient_case');
  }

  bool get opensAsChatRoom =>
      resolvedChatType != null && resolvedContextId != null;

  InboxThread copyWith({
    String? preview,
    String? timeLabel,
    int? unreadCount,
    bool? isPriority,
    ChatMessageStatus? lastMessageStatus,
    InboxPreviewKind? previewKind,
    int? previewCount,
    bool clearLastMessageStatus = false,
    int? conversationId,
    bool? isOnline,
    bool? isTyping,
    ChatComposerActivity? peerActivity,
    bool? isPinned,
    bool? isMuted,
    int? lastMessageId,
    bool clearLastMessageId = false,
  }) {
    final nextActivity = peerActivity ?? this.peerActivity;
    final nextTyping = isTyping ??
        (peerActivity != null ? peerActivity.isActive : this.isTyping);
    return InboxThread(
      id: id,
      title: title,
      subtitle: subtitle,
      preview: preview ?? this.preview,
      timeLabel: timeLabel ?? this.timeLabel,
      initials: initials,
      kind: kind,
      unreadCount: unreadCount ?? this.unreadCount,
      isOnline: isOnline ?? this.isOnline,
      isTyping: nextTyping,
      peerActivity: nextActivity,
      isUrgent: isUrgent,
      isVerified: isVerified,
      isPriority: isPriority ?? this.isPriority,
      isAdminBadge: isAdminBadge,
      lastMessageStatus: clearLastMessageStatus
          ? null
          : (lastMessageStatus ?? this.lastMessageStatus),
      previewKind: previewKind ?? this.previewKind,
      previewCount: previewCount ?? this.previewCount,
      filter: filter,
      source: source,
      chatType: chatType,
      contextId: contextId,
      conversationId: conversationId ?? this.conversationId,
      imageUrl: imageUrl,
      counterpartUserId: counterpartUserId,
      isConsultationOpen: isConsultationOpen,
      consultationDirection: consultationDirection,
      isPinned: isPinned ?? this.isPinned,
      isMuted: isMuted ?? this.isMuted,
      lastMessageId:
          clearLastMessageId ? null : (lastMessageId ?? this.lastMessageId),
    );
  }
}
