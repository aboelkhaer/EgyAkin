import 'package:egy_akin/app/constants/app_strings.dart';
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat/data/models/chat_conversations_list_models.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/inbox/data/models/get_inbox_model_response.dart';
import 'package:egy_akin/features/inbox/data/models/inbox_thread.dart';
import 'package:intl/intl.dart';

class ChatMappers {
  ChatMappers._();

  static String userDisplayName(ChatUserModel? user) {
    if (user == null) return '';
    final first = user.name?.trim() ?? '';
    final last = user.lname?.trim() ?? '';
    return [first, last].where((p) => p.isNotEmpty).join(' ').trim();
  }

  static String userInitials(ChatUserModel? user) {
    if (user == null) return '?';
    final first = user.name?.trim();
    final last = user.lname?.trim();
    final a = (first != null && first.isNotEmpty) ? first[0] : '';
    final b = (last != null && last.isNotEmpty) ? last[0] : '';
    final initials = '$a$b'.toUpperCase();
    return initials.isEmpty ? '?' : initials;
  }

  /// Initials from a display title.
  /// [useFirstTwoWords]: first char of word 1 + word 2 (patient first/second name).
  /// Otherwise: first char of first word + first char of last word.
  static String initialsFromTitle(
    String? title, {
    bool useFirstTwoWords = false,
  }) {
    final trimmed = title?.trim() ?? '';
    if (trimmed.isEmpty) return 'G';
    final parts =
        trimmed.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return 'G';
    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }
    final a = parts.first[0];
    final b = useFirstTwoWords ? parts[1][0] : parts.last[0];
    final initials = '$a$b'.toUpperCase();
    return initials.isEmpty ? 'G' : initials;
  }

  /// Tombstone `content` the server keeps on messages deleted for everyone.
  static const deletedForEveryoneContent = 'This message was deleted';

  static String? normalizeChatType(String? raw) {
    final known = ChatApiType.fromApi(raw);
    if (known != null) return known;
    final t = raw?.trim().toLowerCase().replaceAll('-', '_');
    return (t == null || t.isEmpty) ? raw : t;
  }

  static bool isAdHocGroup(String? chatType) =>
      normalizeChatType(chatType) == ChatApiType.group;

  static bool isCaseGroupChat(String? chatType) =>
      normalizeChatType(chatType) == ChatApiType.caseGroup;

  /// Inbox rows for patient cases often ship `chat_type=private` (or null) but
  /// subtitle like "Patient case · …". Treat those as case groups.
  static bool looksLikePatientCase({
    String? chatType,
    String? subtitle,
    InboxThreadKind? kind,
  }) {
    if (kind == InboxThreadKind.patient) return true;
    if (isCaseGroupChat(chatType)) return true;
    final s = subtitle?.toLowerCase() ?? '';
    return s.contains('patient case') || s.contains('patient_case');
  }

  static bool isAnyGroupChat(String? chatType) {
    final t = normalizeChatType(chatType);
    return t == ChatApiType.group ||
        t == ChatApiType.socialGroup ||
        t == ChatApiType.caseGroup;
  }

  static String inboxAvatarInitials({
    required String? chatType,
    required String displayTitle,
    ChatUserModel? counterpart,
  }) {
    if (isAnyGroupChat(chatType)) {
      return initialsFromTitle(
        displayTitle,
        useFirstTwoWords: isCaseGroupChat(chatType),
      );
    }
    final fromUser = userInitials(counterpart);
    if (fromUser != '?') return fromUser;
    return initialsFromTitle(displayTitle, useFirstTwoWords: true);
  }

  static bool userIsVerified(ChatUserModel? user) =>
      user?.isSyndicateCardRequired?.toLowerCase() == 'verified';

  static String formatMessageTime(String? iso) {
    if (iso == null || iso.isEmpty) return '';
    final dt = DateTime.tryParse(iso);
    if (dt == null) return iso;
    // WhatsApp-style in-bubble timestamp: time only (day separators handle dates).
    return DateFormat.jm().format(dt.toLocal());
  }

  static String formatInboxTime(String? iso) {
    if (iso == null || iso.isEmpty) return '';
    final dt = DateTime.tryParse(iso);
    if (dt == null) return iso;
    final diff = DateTime.now().difference(dt.toLocal());
    if (diff.inMinutes < 1) return AppStrings.now;
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return DateFormat('MMM d').format(dt.toLocal());
  }

  static bool isImageAttachment(ChatAttachmentModel a) => _isImageAttachment(a);

  static bool isFileAttachment(ChatAttachmentModel a) => _isFileAttachment(a);

  static bool _isImageAttachment(ChatAttachmentModel a) {
    final type = (a.type ?? '').toLowerCase();
    final mime = (a.mimeType ?? '').toLowerCase();
    if (type == 'image' || type == 'photo') return true;
    if (mime.startsWith('image/')) return true;
    return false;
  }

  static bool _isVoiceAttachment(ChatAttachmentModel a) {
    final type = (a.type ?? '').toLowerCase();
    final mime = (a.mimeType ?? '').toLowerCase();
    return type == 'voice' || type == 'audio' || mime.startsWith('audio/');
  }

  static bool _isFileAttachment(ChatAttachmentModel a) {
    if (_isImageAttachment(a) || _isVoiceAttachment(a)) return false;
    final type = (a.type ?? '').toLowerCase();
    return type == 'file' ||
        type == 'document' ||
        type == 'attachment' ||
        type.isEmpty;
  }

  static String messagePreview(ChatMessageModel message) {
    final text = message.content?.trim();
    if (text != null && text.isNotEmpty) {
      // Keep API placeholders for inbox parsing (`[2 images]`).
      return text;
    }
    final attachments = message.attachments ?? const [];
    if (attachments.isEmpty) return '';
    final imageCount = attachments.where(_isImageAttachment).length;
    final voiceCount = attachments.where(_isVoiceAttachment).length;
    final fileCount = attachments.where(_isFileAttachment).length;
    if (imageCount > 0 && voiceCount == 0 && fileCount == 0) {
      return imageCount > 1 ? '[Images:$imageCount]' : '[Image]';
    }
    if (voiceCount > 0 && imageCount == 0 && fileCount == 0) {
      return '[Voice message]';
    }
    if (fileCount > 0 && imageCount == 0 && voiceCount == 0) {
      if (fileCount > 1) return '[Files:$fileCount]';
      final name = attachments.firstWhere(_isFileAttachment).originalName;
      return name != null && name.isNotEmpty ? '[File: $name]' : '[File]';
    }
    if (imageCount > 0) {
      return imageCount > 1 ? '[Images:$imageCount]' : '[Image]';
    }
    if (fileCount > 0) {
      return fileCount > 1 ? '[Files:$fileCount]' : '[File]';
    }
    return '[Attachment]';
  }

  /// Prefer API type; otherwise infer from mime so signed `/chat/files/`
  /// images are not forced to `file` (which hides them from the image grid).
  static String _attachmentUiType(ChatAttachmentModel a) {
    final raw = a.type?.trim() ?? '';
    if (raw.isNotEmpty) return raw;
    final mime = a.mimeType?.toLowerCase() ?? '';
    if (mime.startsWith('image/')) return 'image';
    if (mime.startsWith('audio/')) return 'voice';
    final name = (a.originalName ?? a.url ?? '').toLowerCase();
    if (name.contains('.pdf') ||
        name.contains('.doc') ||
        name.contains('.xls') ||
        name.contains('.ppt') ||
        name.contains('.zip')) {
      return 'file';
    }
    // Unknown — leave empty so [ChatAttachmentItem.isImage] can use URL heuristics.
    return '';
  }

  /// Text shown inside a chat bubble — never multi-count tokens like `[Images:2]`.
  static String _bubbleTextForMessage(ChatMessageModel message) {
    final content = message.content?.trim() ?? '';
    final attachments = message.attachments ?? const [];
    final hasMedia = attachments.isNotEmpty;

    if (content.isNotEmpty) {
      if (isImagePlaceholder(content)) {
        return hasMedia ? '[Image]' : content;
      }
      if (isVoicePlaceholder(content)) {
        return hasMedia ? '[Voice]' : content;
      }
      if (isFilePlaceholder(content)) {
        if (content.toLowerCase().startsWith('[file:')) return content;
        return hasMedia ? '[File]' : content;
      }
      return content;
    }

    if (attachments.isEmpty) return '';
    if (attachments.any(_isImageAttachment)) return '[Image]';
    if (attachments.any(_isVoiceAttachment)) return '[Voice]';
    if (attachments.any(_isFileAttachment)) {
      final name = attachments.firstWhere(_isFileAttachment).originalName;
      return name != null && name.isNotEmpty ? '[File: $name]' : '[File]';
    }
    return '';
  }

  /// Matches API / client media placeholders, e.g.:
  /// `[Image]`, `[2 images]`, `[Images:2]`, `[2 attachments]`, `[File]`.
  static final RegExp _imagePlaceholderRe = RegExp(
    r'^\[(?:'
    r'image|photo|'
    r'(\d+)\s*(?:images?|photos?)|'
    r'images?:(\d+)'
    r')\]$',
    caseSensitive: false,
  );

  static final RegExp _filePlaceholderRe = RegExp(
    r'^\[(?:'
    r'file|attachment|'
    r'(\d+)\s*(?:files?|attachments?)|'
    r'files?:(\d+)|'
    r'file:\s*.+'
    r')\]$',
    caseSensitive: false,
  );

  static final RegExp _voicePlaceholderRe = RegExp(
    r'^\[(?:voice(?:\s*message)?|audio)'
    r'(?:\s*[·•\|\-–—]\s*([\d:]+))?'
    r'\]$',
    caseSensitive: false,
  );

  /// Translated media labels the server sends as the inbox preview — no
  /// brackets, English or Arabic ("Photo" / "صورة", "3 photos" / "3 صور",
  /// "Voice message" / "رسالة صوتية", "Video" / "فيديو", "Attachment" /
  /// "مرفق", "3 attachments" / "3 مرفقات", or a file name like report.pdf).
  static final RegExp _photoLabelRe = RegExp(
    r'^(?:photo|image|صورة|صورتان|([0-9٠-٩]+)\s*(?:photos|images|صور|صورة))$',
    caseSensitive: false,
  );
  static final RegExp _videoLabelRe = RegExp(
    r'^(?:video|فيديو|([0-9٠-٩]+)\s*(?:videos|فيديوهات|فيديو))$',
    caseSensitive: false,
  );
  static final RegExp _voiceLabelRe = RegExp(
    r'^(?:voice|voice message|voice note|audio|رسالة صوتية|رسالة صوتيه|مقطع صوتي)$',
    caseSensitive: false,
  );
  static final RegExp _attachmentLabelRe = RegExp(
    r'^(?:attachment|مرفق|مرفقان|([0-9٠-٩]+)\s*(?:attachments|مرفقات|مرفق))$',
    caseSensitive: false,
  );
  static final RegExp _fileNameLabelRe = RegExp(
    r'^[^\n\\/]{1,120}\.(?:pdf|docx?|xlsx?|txt|csv)$',
    caseSensitive: false,
  );

  /// Media kind of a server label, or null for ordinary text.
  static InboxPreviewKind? mediaKindFromLabel(String preview) {
    final p = preview.trim();
    if (p.isEmpty) return null;
    if (_photoLabelRe.hasMatch(p)) return InboxPreviewKind.photo;
    if (_videoLabelRe.hasMatch(p)) return InboxPreviewKind.video;
    if (_voiceLabelRe.hasMatch(p)) return InboxPreviewKind.voice;
    if (_attachmentLabelRe.hasMatch(p) || _fileNameLabelRe.hasMatch(p)) {
      return InboxPreviewKind.file;
    }
    return null;
  }

  static int? _labelCount(String preview) {
    final p = preview.trim();
    if (p == 'صورتان' || p == 'مرفقان') return 2;
    for (final re in [_photoLabelRe, _videoLabelRe, _attachmentLabelRe]) {
      final match = re.firstMatch(p);
      if (match == null) continue;
      final digits = match.group(1);
      if (digits == null) return 1;
      return int.tryParse(_westernDigits(digits));
    }
    return null;
  }

  static String _westernDigits(String value) {
    const arabicIndic = '٠١٢٣٤٥٦٧٨٩';
    final out = StringBuffer();
    for (final ch in value.split('')) {
      final i = arabicIndic.indexOf(ch);
      out.write(i >= 0 ? '$i' : ch);
    }
    return out.toString();
  }

  /// Tombstone preview for a message deleted for everyone.
  static bool isDeletedTombstone(String preview) {
    final p = preview.trim().toLowerCase().replaceAll(RegExp(r'[.。]$'), '');
    return p == deletedForEveryoneContent.toLowerCase() ||
        p == 'تم حذف هذه الرسالة';
  }

  static int previewCountFromText(String preview) {
    final p = preview.trim();
    final image = _imagePlaceholderRe.firstMatch(p);
    if (image != null) {
      final n = int.tryParse(image.group(1) ?? image.group(2) ?? '');
      return (n != null && n > 0) ? n : 1;
    }
    final file = _filePlaceholderRe.firstMatch(p);
    if (file != null) {
      final n = int.tryParse(file.group(1) ?? file.group(2) ?? '');
      return (n != null && n > 0) ? n : 1;
    }
    final fromLabel = _labelCount(p);
    if (fromLabel != null && fromLabel > 0) return fromLabel;
    return 1;
  }

  static bool isImagePlaceholder(String preview) =>
      _imagePlaceholderRe.hasMatch(preview.trim());

  static bool isFilePlaceholder(String preview) =>
      _filePlaceholderRe.hasMatch(preview.trim());

  static bool isVoicePlaceholder(String preview) =>
      _voicePlaceholderRe.hasMatch(preview.trim());

  /// Duration fragment from placeholders like `[Voice Message · 2:00]`.
  static String? voiceDurationFromPlaceholder(String preview) {
    final match = _voicePlaceholderRe.firstMatch(preview.trim());
    final dur = match?.group(1)?.trim();
    if (dur == null || dur.isEmpty) return null;
    return dur;
  }

  /// Normalize API content like `[2 images]` into internal tokens.
  static String normalizeMediaPlaceholder(String content) {
    final p = content.trim();
    if (isImagePlaceholder(p)) {
      final count = previewCountFromText(p);
      return count > 1 ? '[Images:$count]' : '[Image]';
    }
    if (isFilePlaceholder(p)) {
      final count = previewCountFromText(p);
      if (count > 1) return '[Files:$count]';
      if (p.toLowerCase().startsWith('[file:')) return p;
      return '[File]';
    }
    if (isVoicePlaceholder(p)) {
      final dur = voiceDurationFromPlaceholder(p);
      return dur == null ? '[Voice]' : '[Voice · $dur]';
    }
    return p;
  }

  /// Emoji badge for a message: prefer the current user's reaction, else the
  /// top reaction from anyone (so peer reactions are visible).
  static String? displayReactionEmoji(
    ChatMessageModel message,
    int currentUserId,
  ) {
    final reactions = message.reactions ?? const [];
    if (reactions.isEmpty) return null;

    for (final reaction in reactions) {
      final emoji = reaction.emoji?.trim();
      if (emoji == null || emoji.isEmpty) continue;
      final users = reaction.users ?? const [];
      if (users.any((u) => u.id == currentUserId)) {
        return emoji;
      }
    }

    ChatReactionModel? top;
    for (final reaction in reactions) {
      final emoji = reaction.emoji?.trim();
      if (emoji == null || emoji.isEmpty) continue;
      if (top == null || (reaction.count ?? 0) > (top.count ?? 0)) {
        top = reaction;
      }
    }
    return top?.emoji?.trim();
  }

  @Deprecated('Use displayReactionEmoji')
  static String? myReactionEmoji(
    ChatMessageModel message,
    int currentUserId,
  ) =>
      displayReactionEmoji(message, currentUserId);

  static List<ChatReactionGroupView> reactionGroups(
    ChatMessageModel message,
  ) {
    final groups = <ChatReactionGroupView>[];
    for (final reaction in message.reactions ?? const []) {
      final emoji = reaction.emoji?.trim();
      if (emoji == null || emoji.isEmpty) continue;
      final users = <ChatReactionPerson>[];
      for (final user in reaction.users ?? const []) {
        final name = userDisplayName(user);
        users.add(
          ChatReactionPerson(
            id: user.id,
            name: name.isEmpty ? 'User' : name,
            initials: userInitials(user),
            imageUrl: user.image,
            isVerified: userIsVerified(user),
          ),
        );
      }
      final count = reaction.count ?? users.length;
      if (count <= 0 && users.isEmpty) continue;
      groups.add(
        ChatReactionGroupView(
          emoji: emoji,
          count: count > 0 ? count : users.length,
          users: users,
        ),
      );
    }
    // API order is newest-first (top of list → left on the badge).
    return groups;
  }

  static ChatMessageItem toMessageItem(
    ChatMessageModel message, {
    required int currentUserId,
    bool showAvatar = false,
    Map<int, ChatMessageModel>? messagesById,
    bool isGroupChat = false,
    int? otherMembersCount,
  }) {
    final senderId = message.sender?.id;
    final isSystem = message.type == 'system';
    final isOutgoing =
        !isSystem && senderId != null && senderId == currentUserId;
    final status = resolveOutgoingMessageStatus(
      message,
      isOutgoing: isOutgoing,
      isGroupChat: isGroupChat,
      otherMembersCount: otherMembersCount,
    );
    final groups = reactionGroups(message);

    final attachmentItems = (message.attachments ?? const [])
        .map(
          (a) => ChatAttachmentItem(
            id: a.id,
            url: a.url,
            mimeType: a.mimeType,
            originalName: a.originalName,
            type: _attachmentUiType(a),
            durationMs: a.durationSeconds != null && a.durationSeconds! > 0
                ? a.durationSeconds! * 1000
                : null,
          ),
        )
        .toList(growable: false);

    final reply = message.replyTo;
    ChatReplyItem? replyItem;
    if (reply != null && reply.id != null) {
      final replySenderId = reply.senderId ?? reply.sender?.id;
      final imageAtt = _replyImageAttachment(
        reply,
        messagesById: messagesById,
      );
      final voiceAtt = imageAtt == null
          ? _replyVoiceAttachment(reply, messagesById: messagesById)
          : null;
      final imageCount = _replyImageCount(reply, messagesById: messagesById);
      final replyText = () {
        final content = reply.content?.trim() ?? '';
        if (content.isNotEmpty) return content;
        if (imageAtt != null || imageCount > 0 || _replyLooksLikeImage(reply)) {
          return '[Image]';
        }
        if (voiceAtt != null || _replyLooksLikeVoice(reply)) {
          return '[Voice message]';
        }
        return '';
      }();
      replyItem = ChatReplyItem(
        id: reply.id!,
        senderName: userDisplayName(reply.sender),
        text: replyText,
        isOutgoing: replySenderId != null && replySenderId == currentUserId,
        imageAttachment: imageAtt,
        voiceAttachment: voiceAtt,
        imageCount: imageCount > 0 ? imageCount : (imageAtt != null ? 1 : 0),
      );
    }

    final deliveryPeople = message.isDeleted == true || isSystem
        ? const <ChatDeliveryPerson>[]
        : _deliveryPeople(message);
    final readPeople = deliveryPeople.isNotEmpty
        ? [
            for (final p in deliveryPeople)
              if (p.kind == ChatDeliveryReceiptKind.seen) p.asReactionPerson,
          ]
        : (message.isDeleted == true || isSystem
            ? const <ChatReactionPerson>[]
            : _readPeople(message));
    final readCount = message.isDeleted == true || isSystem
        ? 0
        : (message.seenByCount ??
            message.readsCount ??
            readPeople.length);

    return ChatMessageItem(
      id: '${message.id ?? ''}',
      text: isSystem ? (message.content ?? '') : _bubbleTextForMessage(message),
      timeLabel: formatMessageTime(message.createdAt),
      createdAt: DateTime.tryParse(message.createdAt ?? '')?.toLocal(),
      isOutgoing: isOutgoing,
      status: status,
      showAvatar: showAvatar && !isOutgoing && !isSystem,
      senderId: senderId,
      senderName: userDisplayName(message.sender),
      senderImageUrl: message.sender?.image,
      senderInitials: userInitials(message.sender),
      reactionEmoji: message.isDeleted == true || isSystem
          ? null
          : displayReactionEmoji(message, currentUserId),
      reactions: message.isDeleted == true || isSystem ? const [] : groups,
      attachments:
          message.isDeleted == true || isSystem ? const [] : attachmentItems,
      replyTo: message.isDeleted == true || isSystem ? null : replyItem,
      isDeleted: message.isDeleted == true,
      isEdited: message.isDeleted == true || isSystem
          ? false
          : _messageIsEdited(message),
      isForwarded: message.isDeleted == true || isSystem
          ? false
          : message.isForwarded == true,
      isSystem: isSystem,
      reads: readPeople,
      readsCount: readCount,
      deliveryPeople: deliveryPeople,
    );
  }

  static List<ChatDeliveryPerson> _deliveryPeople(ChatMessageModel message) {
    final delivery = message.delivery;
    if (delivery == null || delivery.isEmpty) {
      // Fallback: only `reads` — treat them as seen; no delivered/remaining.
      return [
        for (final user in message.reads ?? const <ChatUserModel>[])
          ChatDeliveryPerson(
            id: user.id,
            name: () {
              final n = userDisplayName(user);
              return n.isEmpty ? 'User' : n;
            }(),
            initials: userInitials(user),
            imageUrl: user.image,
            isVerified: userIsVerified(user),
            kind: ChatDeliveryReceiptKind.seen,
            at: null,
          ),
      ];
    }

    final people = <ChatDeliveryPerson>[];
    final seenIds = <int>{};
    for (final d in delivery) {
      final id = d.id;
      if (id != null && !seenIds.add(id)) continue;
      final name = [d.name, d.lname]
          .where((p) => (p ?? '').trim().isNotEmpty)
          .map((p) => p!.trim())
          .join(' ')
          .trim();
      final displayName = name.isEmpty ? 'User' : name;
      final hasRead = d.readAt?.trim().isNotEmpty ?? false;
      final hasDelivered = d.deliveredAt?.trim().isNotEmpty ?? false;
      final kind = hasRead
          ? ChatDeliveryReceiptKind.seen
          : hasDelivered
              ? ChatDeliveryReceiptKind.delivered
              : ChatDeliveryReceiptKind.remaining;
      final atRaw = hasRead ? d.readAt : (hasDelivered ? d.deliveredAt : null);
      people.add(
        ChatDeliveryPerson(
          id: id,
          name: displayName,
          initials: initialsFromTitle(displayName, useFirstTwoWords: true),
          imageUrl: d.image,
          isVerified:
              (d.isSyndicateCardRequired ?? '').toLowerCase() == 'verified',
          kind: kind,
          at: DateTime.tryParse(atRaw ?? '')?.toLocal(),
        ),
      );
    }
    return people;
  }

  static List<ChatReactionPerson> _readPeople(ChatMessageModel message) {
    final people = <ChatReactionPerson>[];
    final seenIds = <int>{};
    for (final user in message.reads ?? const <ChatUserModel>[]) {
      final id = user.id;
      if (id != null && !seenIds.add(id)) continue;
      final name = userDisplayName(user);
      people.add(
        ChatReactionPerson(
          id: id,
          name: name.isEmpty ? 'User' : name,
          initials: userInitials(user),
          imageUrl: user.image,
          isVerified: userIsVerified(user),
        ),
      );
    }
    return people;
  }

  static bool _messageIsEdited(ChatMessageModel message) {
    if (message.isEdited == true) return true;
    final created = message.createdAt;
    final updated = message.updatedAt;
    if (created == null || updated == null) return false;
    if (created == updated) return false;
    final c = DateTime.tryParse(created);
    final u = DateTime.tryParse(updated);
    if (c == null || u == null) return true;
    return u.difference(c).inSeconds.abs() > 1;
  }

  static bool _replyLooksLikeImage(ChatReplyToModel reply) {
    final type = (reply.type ?? '').toLowerCase();
    return type == 'image' || type == 'photo';
  }

  static bool _replyLooksLikeVoice(ChatReplyToModel reply) {
    final type = (reply.type ?? '').toLowerCase();
    return type == 'voice' || type == 'audio';
  }

  static ChatAttachmentItem? _replyImageAttachment(
    ChatReplyToModel reply, {
    Map<int, ChatMessageModel>? messagesById,
  }) {
    final replyId = reply.id;
    final original = replyId == null ? null : messagesById?[replyId];
    final attachments = original?.attachments ?? const <ChatAttachmentModel>[];
    for (final a in attachments) {
      final item = ChatAttachmentItem(
        id: a.id,
        url: a.url,
        mimeType: a.mimeType,
        originalName: a.originalName,
        type: a.type ?? 'file',
      );
      if (item.isImage) return item;
    }
    return null;
  }

  static ChatAttachmentItem? _replyVoiceAttachment(
    ChatReplyToModel reply, {
    Map<int, ChatMessageModel>? messagesById,
  }) {
    final replyId = reply.id;
    final original = replyId == null ? null : messagesById?[replyId];
    final attachments = original?.attachments ?? const <ChatAttachmentModel>[];
    for (final a in attachments) {
      final item = ChatAttachmentItem(
        id: a.id,
        url: a.url,
        mimeType: a.mimeType,
        originalName: a.originalName,
        type: a.type ?? 'file',
        durationMs: a.durationSeconds != null && a.durationSeconds! > 0
            ? a.durationSeconds! * 1000
            : null,
      );
      if (item.isVoice) return item;
    }
    return null;
  }

  static int _replyImageCount(
    ChatReplyToModel reply, {
    Map<int, ChatMessageModel>? messagesById,
  }) {
    final replyId = reply.id;
    final original = replyId == null ? null : messagesById?[replyId];
    final attachments = original?.attachments ?? const <ChatAttachmentModel>[];
    var count = 0;
    for (final a in attachments) {
      final item = ChatAttachmentItem(
        id: a.id,
        url: a.url,
        mimeType: a.mimeType,
        originalName: a.originalName,
        type: a.type ?? 'file',
      );
      if (item.isImage) count++;
    }
    return count;
  }

  static ChatMessageStatus messageStatusFromApi(
    String? status, {
    required bool isOutgoing,
  }) {
    if (!isOutgoing) return ChatMessageStatus.sent;
    switch (status) {
      case 'seen':
      case 'read':
        return ChatMessageStatus.seen;
      case 'delivered':
        return ChatMessageStatus.delivered;
      case 'sent':
        return ChatMessageStatus.sent;
      case 'pending':
        return ChatMessageStatus.pending;
      case 'failed':
        return ChatMessageStatus.failed;
      default:
        return ChatMessageStatus.sent;
    }
  }

  /// Aggregate ticks for group chats: delivered/seen only when every other
  /// member has reached that state (matches API `status` semantics).
  static String? aggregateGroupStatusApi({
    required ChatMessageModel message,
    int? otherMembersCount,
  }) {
    final delivery = message.delivery;
    final expectedFromRoster =
        (otherMembersCount != null && otherMembersCount > 0)
            ? otherMembersCount
            : null;
    final expectedFromDelivery =
        (delivery != null && delivery.isNotEmpty) ? delivery.length : null;
    // Prefer roster size so a partial local delivery list can't falsely
    // reach "all delivered / all seen".
    final expected = expectedFromRoster ?? expectedFromDelivery;

    if (expected != null && expected > 0) {
      if (delivery != null && delivery.isNotEmpty) {
        final delivered = delivery
            .where((d) => d.deliveredAt?.trim().isNotEmpty ?? false)
            .length;
        final seen = delivery
            .where((d) => d.readAt?.trim().isNotEmpty ?? false)
            .length;
        if (seen >= expected) return 'seen';
        if (delivered >= expected) return 'delivered';
        return 'sent';
      }

      final seen = message.seenByCount ?? message.readsCount ?? 0;
      if (seen >= expected) return 'seen';
      final delivered = message.deliveredToCount ?? 0;
      if (delivered >= expected) return 'delivered';

      // Counts incomplete — trust explicit server status when present.
      final api = message.status?.trim().toLowerCase();
      if (api == 'seen' || api == 'read') return 'seen';
      if (api == 'delivered') return 'delivered';
      if (api == 'sent') return 'sent';
      return 'sent';
    }

    // No roster/delivery detail — trust the server aggregate field.
    return message.status;
  }

  static ChatMessageStatus resolveOutgoingMessageStatus(
    ChatMessageModel message, {
    required bool isOutgoing,
    bool isGroupChat = false,
    int? otherMembersCount,
  }) {
    if (!isOutgoing) return ChatMessageStatus.sent;
    if (!isGroupChat) {
      return messageStatusFromApi(message.status, isOutgoing: true);
    }

    final fromApi = messageStatusFromApi(message.status, isOutgoing: true);
    final aggregated = aggregateGroupStatusApi(
      message: message,
      otherMembersCount: otherMembersCount,
    );
    final fromReceipts = aggregated == null || aggregated.trim().isEmpty
        ? ChatMessageStatus.sent
        : messageStatusFromApi(aggregated, isOutgoing: true);

    // Take the higher of API aggregate vs local receipt math so partial
    // delivery arrays can't hide a server "seen", and stale "sent" can't
    // hide completed delivery rows.
    return _statusRank(fromReceipts) >= _statusRank(fromApi)
        ? fromReceipts
        : fromApi;
  }

  static int _statusRank(ChatMessageStatus status) {
    switch (status) {
      case ChatMessageStatus.failed:
      case ChatMessageStatus.pending:
      case ChatMessageStatus.sending:
        return 0;
      case ChatMessageStatus.sent:
        return 1;
      case ChatMessageStatus.delivered:
        return 2;
      case ChatMessageStatus.seen:
        return 3;
    }
  }

  static List<ChatMessageItem> toMessageItems(
    List<ChatMessageModel> messages, {
    required int currentUserId,
    bool isGroupChat = false,
    int? otherMembersCount,
  }) {
    final messagesById = <int, ChatMessageModel>{
      for (final m in messages)
        if (m.id != null) m.id!: m,
    };
    final items = <ChatMessageItem>[];
    int? lastVisibleSenderId;
    for (var i = 0; i < messages.length; i++) {
      final msg = messages[i];
      // "Delete for me" rows come back as tombstones without content — keep
      // them hidden, like right after deleting. A delete for everyone keeps
      // its content and shows the "deleted" bubble.
      if (msg.isDeleted == true) {
        final senderId = msg.sender?.id;
        final isMine = senderId != null && senderId == currentUserId;
        final deletedForMe = (msg.content ?? '').trim().isEmpty;
        if (!isMine && deletedForMe) continue;
      }
      final isSystem = msg.type == 'system';
      // System rows (created/removed/…) share the actor's sender id — don't
      // let them suppress the avatar/name on the next real bubble.
      if (isSystem) {
        items.add(
          toMessageItem(
            msg,
            currentUserId: currentUserId,
            showAvatar: false,
            messagesById: messagesById,
            isGroupChat: isGroupChat,
            otherMembersCount: otherMembersCount,
          ),
        );
        continue;
      }
      final showAvatar = msg.sender?.id != lastVisibleSenderId;
      lastVisibleSenderId = msg.sender?.id;
      items.add(
        toMessageItem(
          msg,
          currentUserId: currentUserId,
          showAvatar: showAvatar,
          messagesById: messagesById,
          isGroupChat: isGroupChat,
          otherMembersCount: otherMembersCount,
        ),
      );
    }
    return items;
  }

  static InboxThreadKind inboxKind(InboxItemModel item) {
    if (item.source == 'consultation') return InboxThreadKind.consult;
    switch (normalizeChatType(item.chatType)) {
      case ChatApiType.caseGroup:
        return InboxThreadKind.patient;
      case ChatApiType.group:
      case ChatApiType.socialGroup:
        return InboxThreadKind.group;
      case ChatApiType.private:
        return InboxThreadKind.doctor;
      default:
        return InboxThreadKind.doctor;
    }
  }

  static InboxFilter inboxFilterForItem(InboxItemModel item) {
    if (item.source == 'consultation') return InboxFilter.consults;
    switch (normalizeChatType(item.chatType)) {
      case ChatApiType.caseGroup:
        return InboxFilter.patients;
      case ChatApiType.socialGroup:
        return InboxFilter.socialGroups;
      case ChatApiType.group:
        return InboxFilter.groups;
      default:
        return InboxFilter.doctors;
    }
  }

  static InboxPreviewKind previewKindFromText(String preview) {
    final p = preview.trim();
    if (p.isEmpty) return InboxPreviewKind.text;
    if (isImagePlaceholder(p)) return InboxPreviewKind.photo;
    if (isVoicePlaceholder(p)) return InboxPreviewKind.voice;
    if (isFilePlaceholder(p)) return InboxPreviewKind.file;
    return mediaKindFromLabel(p) ?? InboxPreviewKind.text;
  }

  static InboxPreviewKind previewKindFromLast(InboxLastMessageModel? last) {
    if (last == null) return InboxPreviewKind.text;
    final attachments = last.attachments ?? const [];
    final imageCount = attachments.where(_isImageAttachment).length;
    final voiceCount = attachments.where(_isVoiceAttachment).length;
    final fileCount = attachments.where(_isFileAttachment).length;

    if (imageCount > 0 && fileCount == 0 && voiceCount == 0) {
      return InboxPreviewKind.photo;
    }
    if (voiceCount > 0 && imageCount == 0 && fileCount == 0) {
      return InboxPreviewKind.voice;
    }
    if (fileCount > 0 && imageCount == 0 && voiceCount == 0) {
      return InboxPreviewKind.file;
    }
    if (imageCount > 0) return InboxPreviewKind.photo;
    if (fileCount > 0) return InboxPreviewKind.file;
    if (voiceCount > 0) return InboxPreviewKind.voice;

    final type = last.type?.toLowerCase() ?? '';
    if (type == 'image' || type == 'photo') return InboxPreviewKind.photo;
    if (type == 'voice' || type == 'audio') return InboxPreviewKind.voice;
    if (type == 'file') return InboxPreviewKind.file;

    // API often puts placeholders in content, e.g. "[2 images]".
    final fromContent = previewKindFromText(last.content ?? '');
    if (fromContent != InboxPreviewKind.text) return fromContent;

    if ((last.content ?? '').trim().isEmpty && attachments.isNotEmpty) {
      return InboxPreviewKind.photo;
    }
    return InboxPreviewKind.text;
  }

  static int previewCountFromLast(InboxLastMessageModel? last) {
    if (last == null) return 1;
    final attachments = last.attachments ?? const [];
    final imageCount = attachments.where(_isImageAttachment).length;
    final fileCount = attachments.where(_isFileAttachment).length;
    final voiceCount = attachments.where(_isVoiceAttachment).length;
    final kind = previewKindFromLast(last);

    // Prefer attachment list counts when present.
    switch (kind) {
      case InboxPreviewKind.photo:
        if (imageCount > 0) return imageCount;
        return previewCountFromText(last.content ?? '');
      case InboxPreviewKind.file:
        if (fileCount > 0) return fileCount;
        return previewCountFromText(last.content ?? '');
      case InboxPreviewKind.voice:
        return voiceCount > 0 ? voiceCount : 1;
      case InboxPreviewKind.video:
      case InboxPreviewKind.text:
        return previewCountFromText(last.content ?? '');
    }
  }

  static String inboxPreviewText(InboxLastMessageModel? last) {
    final content = last?.content?.trim() ?? '';
    // Prefer normalizing API placeholders first so "[2 images]" becomes countable.
    if (content.isNotEmpty &&
        (isImagePlaceholder(content) ||
            isFilePlaceholder(content) ||
            isVoicePlaceholder(content))) {
      return normalizeMediaPlaceholder(content);
    }
    // Server media labels are already translated — show them as-is.
    if (content.isNotEmpty && mediaKindFromLabel(content) != null) {
      return content;
    }

    final kind = previewKindFromLast(last);
    final count = previewCountFromLast(last);
    switch (kind) {
      case InboxPreviewKind.photo:
        return count > 1 ? '[Images:$count]' : '[Image]';
      case InboxPreviewKind.voice:
        return '[Voice]';
      case InboxPreviewKind.video:
        return content;
      case InboxPreviewKind.file:
        if (count > 1) return '[Files:$count]';
        if (content.isNotEmpty && !isFilePlaceholder(content)) return content;
        final files = (last?.attachments ?? const []).where(_isFileAttachment);
        final name = files.isEmpty ? null : files.first.originalName;
        return name != null && name.isNotEmpty ? '[File: $name]' : '[File]';
      case InboxPreviewKind.text:
        if (last?.type == 'system') return content;
        if (content.isEmpty && (last?.attachments?.isNotEmpty ?? false)) {
          return count > 1 ? '[Images:$count]' : '[Image]';
        }
        return content;
    }
  }

  /// Reaction summary rows ("Reacted with 👍") are not real messages — hide ticks.
  static bool isReactionLastMessage(InboxLastMessageModel? last) {
    if (last == null) return false;
    final type = (last.type ?? '').trim().toLowerCase();
    if (type == 'reaction' ||
        type == 'message_reaction' ||
        type == 'reacted' ||
        type == 'emoji_reaction') {
      return true;
    }
    return isReactionPreview(last.content);
  }

  /// True when inbox preview text is a reaction sentence (EN/AR).
  static bool isReactionPreview(String? text) {
    final p = (text ?? '').trim().toLowerCase();
    if (p.isEmpty) return false;
    if (p.contains('reacted with') ||
        p.contains('reacted to') ||
        p.startsWith('reacted ') ||
        p.contains('تفاعل ب') ||
        p.contains('تفاعل على') ||
        p.contains('تفاعل مع')) {
      return true;
    }
    // "You reacted …" / "Reacted …" system copy without emoji verb variants.
    if (RegExp(r'^(you\s+)?reacted\b').hasMatch(p)) return true;
    return false;
  }

  static InboxThread toInboxThread(InboxItemModel item) {
    final counterpart = item.counterpart;
    final last = item.lastMessage;
    final preview = inboxPreviewText(last);
    final previewKind = previewKindFromLast(last);
    final previewCount = previewCountFromLast(last);
    final subtitleRaw = item.subtitle ?? '';
    var chatType = item.source == 'consultation'
        ? ChatApiType.private
        : normalizeChatType(item.chatType);
    // Force patient-case rows to case_group even when API labels them private.
    if (item.source != 'consultation' &&
        looksLikePatientCase(chatType: chatType, subtitle: subtitleRaw)) {
      chatType = ChatApiType.caseGroup;
    }
    // Ad-hoc `group` chats are addressed by conversation id. Some inbox rows
    // omit `context_id` — fall back to `id` so the thread still opens.
    final contextId = item.source == 'consultation'
        ? counterpart?.id
        : (item.contextId ??
            (isAdHocGroup(chatType) || isCaseGroupChat(chatType)
                ? item.id
                : null));
    final isGroupChat = isAnyGroupChat(chatType);
    // Ad-hoc groups often ship a long `description` as subtitle — that makes
    // the inbox row three lines. Keep subtitle for social/patient chats only.
    final subtitle = isAdHocGroup(chatType) ? '' : subtitleRaw;
    final displayTitle = (item.title?.trim().isNotEmpty == true)
        ? item.title!.trim()
        : userDisplayName(counterpart);
    final kind = item.source == 'consultation'
        ? InboxThreadKind.consult
        : (isCaseGroupChat(chatType)
            ? InboxThreadKind.patient
            : inboxKind(item));
    final filter = item.source == 'consultation'
        ? InboxFilter.consults
        : (isCaseGroupChat(chatType)
            ? InboxFilter.patients
            : inboxFilterForItem(item));

    return InboxThread(
      id: '${item.source ?? 'chat'}_${item.id ?? 0}',
      title: displayTitle.isEmpty ? 'Chat' : displayTitle,
      subtitle: subtitle,
      preview: preview,
      previewKind: previewKind,
      previewCount: previewCount,
      timeLabel: formatInboxTime(item.lastActivityAt ?? last?.createdAt),
      initials: inboxAvatarInitials(
        chatType: chatType,
        displayTitle: displayTitle,
        counterpart: counterpart,
      ),
      kind: kind,
      unreadCount: item.unreadCount ?? 0,
      isVerified: isGroupChat ? false : userIsVerified(counterpart),
      isUrgent: item.isUrgent ?? false,
      isPriority: item.section == 'priority',
      lastMessageStatus: last?.isMine == true && !isReactionLastMessage(last)
          ? messageStatusFromApi(last?.status, isOutgoing: true)
          : null,
      filter: filter,
      source: item.source,
      chatType: chatType,
      contextId: contextId,
      conversationId: item.source == 'chat' ? item.id : null,
      // Case/patient groups often have empty/broken image URLs — prefer initials.
      imageUrl: isCaseGroupChat(chatType)
          ? null
          : (item.image ?? counterpart?.image),
      // Private rows sometimes omit `counterpart` — context_id IS the peer.
      counterpartUserId: counterpart?.id ??
          (!isGroupChat ? contextId : null),
      isConsultationOpen: item.isOpen,
      consultationDirection: item.direction,
      lastMessageId: last?.id,
    );
  }

  /// Maps `GET /chat/conversations` rows (incl. archived) into inbox tiles.
  static InboxThread conversationToInboxThread(
    ChatConversationListItemModel item,
  ) {
    var chatType = normalizeChatType(item.type);
    final subtitleRaw = item.subtitle ?? '';
    if (looksLikePatientCase(chatType: chatType, subtitle: subtitleRaw)) {
      chatType = ChatApiType.caseGroup;
    }
    final counterpart = item.counterpart ??
        (isAnyGroupChat(chatType)
            ? null
            : (item.participants != null && item.participants!.isNotEmpty
                ? item.participants!.first
                : null));
    final last = item.lastMessage;
    final preview = inboxPreviewText(last);
    final previewKind = previewKindFromLast(last);
    final previewCount = previewCountFromLast(last);
    final isGroupChat = isAnyGroupChat(chatType);
    final title = (item.title ?? item.name)?.trim();
    final displayTitle = (title != null && title.isNotEmpty)
        ? title
        : userDisplayName(counterpart);
    final contextId = item.contextId ??
        (isAdHocGroup(chatType) || isCaseGroupChat(chatType)
            ? item.id
            : counterpart?.id);
    final subtitle = isAdHocGroup(chatType) ? '' : subtitleRaw;

    InboxThreadKind kind;
    InboxFilter filter;
    if (chatType == ChatApiType.socialGroup ||
        chatType == ChatApiType.caseGroup ||
        chatType == ChatApiType.group) {
      kind = chatType == ChatApiType.caseGroup
          ? InboxThreadKind.patient
          : InboxThreadKind.group;
      filter = chatType == ChatApiType.caseGroup
          ? InboxFilter.patients
          : (chatType == ChatApiType.socialGroup
              ? InboxFilter.socialGroups
              : InboxFilter.groups);
    } else {
      kind = InboxThreadKind.doctor;
      filter = InboxFilter.doctors;
    }

    return InboxThread(
      id: 'chat_${item.id ?? 0}',
      title: displayTitle.isEmpty ? 'Chat' : displayTitle,
      subtitle: subtitle,
      preview: preview,
      previewKind: previewKind,
      previewCount: previewCount,
      timeLabel: formatInboxTime(
        item.lastActivityAt ?? last?.createdAt ?? item.updatedAt,
      ),
      initials: inboxAvatarInitials(
        chatType: chatType,
        displayTitle: displayTitle,
        counterpart: counterpart,
      ),
      kind: kind,
      unreadCount: item.unreadCount ?? 0,
      isVerified: isGroupChat ? false : userIsVerified(counterpart),
      isPriority: (item.unreadCount ?? 0) > 0,
      lastMessageStatus: last?.isMine == true && !isReactionLastMessage(last)
          ? messageStatusFromApi(last?.status, isOutgoing: true)
          : null,
      filter: filter,
      source: 'chat',
      chatType: chatType,
      contextId: contextId,
      conversationId: item.id,
      imageUrl: isCaseGroupChat(chatType)
          ? null
          : (item.image ?? counterpart?.image),
      counterpartUserId: counterpart?.id ??
          (!isGroupChat ? contextId : null),
      isPinned: item.isPinned ?? false,
      isMuted: item.isMuted ?? false,
      lastMessageId: last?.id,
    );
  }

  static String inboxFilterParam(InboxFilter filter) {
    switch (filter) {
      case InboxFilter.all:
        return 'all';
      case InboxFilter.doctors:
        return 'individual';
      case InboxFilter.patients:
        return 'patients';
      case InboxFilter.groups:
        return 'group';
      case InboxFilter.socialGroups:
        return 'social_group';
      case InboxFilter.consults:
        return 'consults';
    }
  }

  static int countForFilter(InboxCountsModel? counts, InboxFilter filter) {
    if (counts == null) return 0;
    switch (filter) {
      case InboxFilter.all:
        return counts.all ?? 0;
      case InboxFilter.doctors:
        return counts.doctors ?? counts.people ?? 0;
      case InboxFilter.patients:
        return counts.patients ?? 0;
      case InboxFilter.groups:
        return counts.groups ?? 0;
      case InboxFilter.socialGroups:
        return counts.socialGroups ?? 0;
      case InboxFilter.consults:
        return counts.consults ?? 0;
    }
  }
}
