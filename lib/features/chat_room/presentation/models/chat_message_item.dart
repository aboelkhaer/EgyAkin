import 'dart:io';

enum ChatMessageStatus {
  /// Optimistic local message waiting for API.
  sending,

  /// Queued locally while offline; will auto-send when connection returns.
  pending,

  /// Server accepted; one tick.
  sent,

  /// Peer device acknowledged delivery; double gray ticks.
  delivered,

  /// Peer opened/read; double blue ticks.
  seen,

  /// Send failed — user can tap to resend.
  failed,
}

class ChatReactionPerson {
  final int? id;
  final String name;
  final String initials;
  final String? imageUrl;
  final bool isVerified;

  const ChatReactionPerson({
    this.id,
    required this.name,
    required this.initials,
    this.imageUrl,
    this.isVerified = false,
  });
}

/// Per-member receipt for group message info (WhatsApp-style).
enum ChatDeliveryReceiptKind { seen, delivered, remaining }

class ChatDeliveryPerson {
  final int? id;
  final String name;
  final String initials;
  final String? imageUrl;
  final bool isVerified;
  final ChatDeliveryReceiptKind kind;
  final DateTime? at;

  const ChatDeliveryPerson({
    this.id,
    required this.name,
    required this.initials,
    this.imageUrl,
    this.isVerified = false,
    required this.kind,
    this.at,
  });

  ChatReactionPerson get asReactionPerson => ChatReactionPerson(
        id: id,
        name: name,
        initials: initials,
        imageUrl: imageUrl,
        isVerified: isVerified,
      );
}

class ChatReactionGroupView {
  final String emoji;
  final int count;
  final List<ChatReactionPerson> users;

  const ChatReactionGroupView({
    required this.emoji,
    required this.count,
    this.users = const [],
  });
}

/// An image attached to a message — either a local file (uploading) or a URL.
class ChatAttachmentItem {
  final int? id;
  final String? url;
  final File? localFile;
  final String? mimeType;
  final String? originalName;
  final String type; // 'image', 'voice', 'file'
  final int? durationMs;

  const ChatAttachmentItem({
    this.id,
    this.url,
    this.localFile,
    this.mimeType,
    this.originalName,
    this.type = 'image',
    this.durationMs,
  });

  bool get isLocal => localFile != null;

  bool get isVoice {
    if (type == 'voice' || type == 'audio') return true;
    if (mimeType != null && mimeType!.startsWith('audio/')) return true;
    final name = (originalName ?? url ?? '').toLowerCase();
    return name.endsWith('.m4a') ||
        name.endsWith('.mp3') ||
        name.endsWith('.wav') ||
        name.endsWith('.ogg') ||
        name.endsWith('.aac');
  }

  bool get isImage {
    if (isVoice) return false;
    if (mimeType != null && mimeType!.startsWith('image/')) return true;
    if (type == 'image' || type == 'photo') return true;
    if (_hasImageExtension(url) || _hasImageExtension(originalName)) {
      return true;
    }
    // Explicit document/file attachments are not images.
    if (type == 'file' || type == 'document') return false;
    // Signed /chat/files/{id} URLs often have no extension. After [isVoice],
    // treat remaining chat-file URLs as images when type isn't "file".
    final resolved = (url ?? '').toLowerCase();
    if (resolved.contains('/chat/files/')) return true;
    // Local optimistic image sends.
    if (localFile != null && type != 'file' && type != 'document') return true;
    return false;
  }

  /// Non-image, non-voice document (PDF, doc, zip, …).
  bool get isFile {
    if (isVoice || isImage) return false;
    if (type == 'file' || type == 'document') return true;
    if (mimeType != null) {
      final mime = mimeType!.toLowerCase();
      if (mime.startsWith('application/') || mime.startsWith('text/')) {
        return true;
      }
    }
    final name = (originalName ?? url ?? '').toLowerCase();
    const exts = [
      '.pdf',
      '.doc',
      '.docx',
      '.xls',
      '.xlsx',
      '.ppt',
      '.pptx',
      '.txt',
      '.csv',
      '.zip',
      '.rar',
      '.7z',
    ];
    for (final ext in exts) {
      if (name.contains(ext)) return true;
    }
    return localFile != null && type == 'file';
  }

  static bool _hasImageExtension(String? value) {
    if (value == null || value.isEmpty) return false;
    final lower = value.toLowerCase();
    return lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png') ||
        lower.endsWith('.gif') ||
        lower.endsWith('.webp') ||
        lower.contains('.jpg?') ||
        lower.contains('.jpeg?') ||
        lower.contains('.png?') ||
        lower.contains('.gif?') ||
        lower.contains('.webp?');
  }
}

/// The quoted/replied-to message shown inside a bubble.
class ChatReplyItem {
  final int id;
  final String senderName;
  final String text;
  final bool isOutgoing;
  /// First image of the replied message (for WhatsApp-style reply previews).
  final ChatAttachmentItem? imageAttachment;
  /// First voice note of the replied message.
  final ChatAttachmentItem? voiceAttachment;
  /// Total image attachments on the replied message (WhatsApp "3 photos").
  final int imageCount;

  const ChatReplyItem({
    required this.id,
    required this.senderName,
    required this.text,
    required this.isOutgoing,
    this.imageAttachment,
    this.voiceAttachment,
    this.imageCount = 0,
  });

  bool get hasImagePreview => imageAttachment != null;
  bool get hasVoicePreview => voiceAttachment != null;
}

class ChatMessageItem {
  final String id;
  final String text;
  final String timeLabel;
  /// Local timestamp used for WhatsApp-style day separators.
  final DateTime? createdAt;
  final bool isOutgoing;
  final ChatMessageStatus status;
  final bool showAvatar;
  /// Sender user id (for group avatar / name coloring).
  final int? senderId;
  /// Full display name of the sender (group chats).
  final String senderName;
  final String? senderImageUrl;
  final String senderInitials;
  final String? reactionEmoji;
  final List<ChatReactionGroupView> reactions;
  final List<ChatAttachmentItem> attachments;
  final ChatReplyItem? replyTo;

  /// Upload progress 0.0–1.0 for local attachment sends.
  final double? uploadProgress;

  /// Local-only id used to reconcile optimistic sends with the API response.
  final String? clientTempId;

  /// True while the bubble is playing the delete exit animation.
  final bool isDeleting;

  /// Soft-deleted (WhatsApp-style placeholder stays in the timeline).
  final bool isDeleted;

  /// True after the sender edited the text (WhatsApp "Edited" label).
  final bool isEdited;

  /// True when this message was forwarded (WhatsApp "Forwarded" hint).
  final bool isForwarded;

  /// Server system notice (e.g. "You created this group") — centered hint.
  final bool isSystem;

  /// Group read receipts — who has seen this outgoing message.
  final List<ChatReactionPerson> reads;
  final int readsCount;

  /// Full per-member delivery roster from API `delivery` (seen / delivered /
  /// remaining). Empty when the API omitted it.
  final List<ChatDeliveryPerson> deliveryPeople;

  const ChatMessageItem({
    required this.id,
    required this.text,
    required this.timeLabel,
    this.createdAt,
    required this.isOutgoing,
    this.status = ChatMessageStatus.sent,
    this.showAvatar = false,
    this.senderId,
    this.senderName = '',
    this.senderImageUrl,
    this.senderInitials = '?',
    this.reactionEmoji,
    this.reactions = const [],
    this.attachments = const [],
    this.replyTo,
    this.uploadProgress,
    this.clientTempId,
    this.isDeleting = false,
    this.isDeleted = false,
    this.isEdited = false,
    this.isForwarded = false,
    this.isSystem = false,
    this.reads = const [],
    this.readsCount = 0,
    this.deliveryPeople = const [],
  });

  List<ChatDeliveryPerson> get seenByPeople => deliveryPeople
      .where((p) => p.kind == ChatDeliveryReceiptKind.seen)
      .toList(growable: false);

  List<ChatDeliveryPerson> get deliveredOnlyPeople => deliveryPeople
      .where((p) => p.kind == ChatDeliveryReceiptKind.delivered)
      .toList(growable: false);

  List<ChatDeliveryPerson> get remainingPeople => deliveryPeople
      .where((p) => p.kind == ChatDeliveryReceiptKind.remaining)
      .toList(growable: false);

  bool get isRead => status == ChatMessageStatus.seen;

  bool get canResend =>
      isOutgoing &&
      clientTempId != null &&
      status == ChatMessageStatus.failed;

  /// Failed image/file send — show WhatsApp-style center retry on the media.
  bool get needsMediaUploadRetry =>
      canResend && (hasImages || hasFiles);

  /// WhatsApp-style: own text (or caption) within 15 minutes, not deleted.
  bool get canEdit {
    if (!isOutgoing || isDeleted || isSystem) return false;
    if (status == ChatMessageStatus.sending ||
        status == ChatMessageStatus.pending ||
        status == ChatMessageStatus.failed) {
      return false;
    }
    if (int.tryParse(id) == null) return false;
    final text = this.text.trim();
    final placeholders = {
      '[Image]',
      '[Photo]',
      '[Voice]',
      '[Voice message]',
      '[File]',
      '[Attachment]',
    };
    final isPlaceholder =
        text.isEmpty || placeholders.contains(text) || text.startsWith('[File:');
    if (isPlaceholder) return false;
    if (createdAt != null) {
      final age = DateTime.now().difference(createdAt!);
      if (age > const Duration(minutes: 15)) return false;
    }
    return true;
  }

  bool get hasImages => attachments.any((a) => a.isImage);
  bool get hasVoice => attachments.any((a) => a.isVoice);
  bool get hasFiles => attachments.any((a) => a.isFile);
  bool get isUploading =>
      uploadProgress != null && uploadProgress! < 1.0;

  int get totalReactionCount =>
      reactions.fold<int>(0, (sum, g) => sum + g.count);

  ChatAttachmentItem? get firstImageAttachment {
    for (final a in attachments) {
      if (a.isImage) return a;
    }
    return null;
  }

  ChatAttachmentItem? get firstVoiceAttachment {
    for (final a in attachments) {
      if (a.isVoice) return a;
    }
    return null;
  }

  int get imageAttachmentCount =>
      attachments.where((a) => a.isImage).length;

  ChatMessageItem copyWith({
    String? id,
    String? text,
    String? timeLabel,
    DateTime? createdAt,
    bool? isOutgoing,
    ChatMessageStatus? status,
    bool? showAvatar,
    int? senderId,
    String? senderName,
    String? senderImageUrl,
    bool clearSenderImageUrl = false,
    String? senderInitials,
    String? reactionEmoji,
    bool clearReaction = false,
    List<ChatReactionGroupView>? reactions,
    List<ChatAttachmentItem>? attachments,
    ChatReplyItem? replyTo,
    bool clearReplyTo = false,
    double? uploadProgress,
    bool clearUploadProgress = false,
    String? clientTempId,
    bool? isDeleting,
    bool? isDeleted,
    bool? isEdited,
    bool? isForwarded,
    bool? isSystem,
    List<ChatReactionPerson>? reads,
    int? readsCount,
    List<ChatDeliveryPerson>? deliveryPeople,
  }) {
    final nextReactions = clearReaction
        ? const <ChatReactionGroupView>[]
        : (reactions ?? this.reactions);
    final nextEmoji = clearReaction
        ? null
        : (reactionEmoji ??
            (reactions != null
                ? (nextReactions.isEmpty ? null : nextReactions.first.emoji)
                : this.reactionEmoji));

    return ChatMessageItem(
      id: id ?? this.id,
      text: text ?? this.text,
      timeLabel: timeLabel ?? this.timeLabel,
      createdAt: createdAt ?? this.createdAt,
      isOutgoing: isOutgoing ?? this.isOutgoing,
      status: status ?? this.status,
      showAvatar: showAvatar ?? this.showAvatar,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderImageUrl: clearSenderImageUrl
          ? null
          : (senderImageUrl ?? this.senderImageUrl),
      senderInitials: senderInitials ?? this.senderInitials,
      reactionEmoji: nextEmoji,
      reactions: nextReactions,
      attachments: attachments ?? this.attachments,
      replyTo: clearReplyTo ? null : (replyTo ?? this.replyTo),
      uploadProgress: clearUploadProgress
          ? null
          : (uploadProgress ?? this.uploadProgress),
      clientTempId: clientTempId ?? this.clientTempId,
      isDeleting: isDeleting ?? this.isDeleting,
      isDeleted: isDeleted ?? this.isDeleted,
      isEdited: isEdited ?? this.isEdited,
      isForwarded: isForwarded ?? this.isForwarded,
      isSystem: isSystem ?? this.isSystem,
      reads: reads ?? this.reads,
      readsCount: readsCount ?? this.readsCount,
      deliveryPeople: deliveryPeople ?? this.deliveryPeople,
    );
  }
}
