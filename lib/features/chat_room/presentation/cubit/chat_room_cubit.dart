import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:egy_akin/features/chat/data/mappers/chat_mappers.dart';
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat/data/models/chat_composer_activity.dart';
import 'package:egy_akin/features/chat/data/models/chat_composer_activity_labels.dart';
import 'package:egy_akin/features/chat/data/services/chat_incoming_sound.dart';
import 'package:egy_akin/features/chat/data/services/chat_mute_prefs.dart';
import 'package:egy_akin/features/chat/data/services/chat_realtime_service.dart';
import 'package:egy_akin/features/chat/data/services/chat_block_service.dart';
import 'package:egy_akin/features/chat/data/services/chat_typing_sound.dart';
import 'package:egy_akin/features/chat_room/domain/repositories/chat_room_repo.dart';
import 'package:egy_akin/features/chat_room/presentation/cubit/chat_room_state.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_pending_send_store.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../../../exports.dart';

class _PendingSendPayload {
  final String? text;
  final List<File> images;
  final List<File> voices;
  final List<File> files;
  final List<int> voiceDurationsMs;
  final int? replyToId;

  const _PendingSendPayload({
    this.text,
    this.images = const [],
    this.voices = const [],
    this.files = const [],
    this.voiceDurationsMs = const [],
    this.replyToId,
  });

  bool get hasAttachments =>
      images.isNotEmpty || voices.isNotEmpty || files.isNotEmpty;
}

/// Watches for a server message that still arrived after the user cancelled
/// an in-flight multipart upload (client abort ≠ server reject).
class _CancelledSendWatch {
  final DateTime until;
  final int imageCount;
  final int voiceCount;
  final int fileCount;
  final int? replyToId;

  const _CancelledSendWatch({
    required this.until,
    required this.imageCount,
    required this.voiceCount,
    required this.fileCount,
    this.replyToId,
  });

  bool get isExpired => DateTime.now().isAfter(until);
}

/// Short-lived guard so stale self reaction echoes / soft-reloads cannot wipe
/// an optimistic emoji change (👍 → 😂) or a just-set reaction.
class _LocalReactionHold {
  /// `null` means the user intentionally cleared their reaction.
  final String? emoji;
  final DateTime until;

  const _LocalReactionHold({required this.emoji, required this.until});

  bool get isActive => DateTime.now().isBefore(until);
}

class ChatRoomCubit extends Cubit<ChatRoomState> {
  ChatRoomCubit(this._repository, this._realtime, this._networkInfo)
      : super(const ChatRoomState.initial()) {
    _realtimeSub = _realtime.events.listen(_onRealtimeEvent);
    _connectivitySub = _networkInfo.onConnectivityChanged.listen((online) {
      if (online) unawaited(_flushPendingSends());
    });
  }

  final ChatRoomRepository _repository;
  final ChatRealtimeService _realtime;
  final NetworkInfo _networkInfo;

  int? _contextId;
  String? _chatType;
  int? _conversationId;
  int? _currentUserId;
  int? get conversationId => _conversationId;

  int? get currentUserId => _currentUserId;
  String? _peerDisplayName;
  String? _peerImageUrl;
  String? _myDisplayName;
  String? _myImageUrl;
  String? get myImageUrl => _myImageUrl;

  /// Peer / group avatar from conversation details or message senders.
  String? get peerImageUrl => _peerImageUrl;
  bool _hasMore = false;
  List<ChatMessageItem> _messages = [];
  List<ChatMessageModel> _rawMessages = [];
  int _loadGeneration = 0;
  Future<void>? _loadOlderFuture;
  Future<void>? _loadMessagesFuture;

  /// messageId → last local reaction we applied (survives soft-reload / echoes).
  final Map<int, _LocalReactionHold> _localReactionHolds = {};

  /// Full-screen image / local overlays push a route on top of this room.
  /// [onVisibleAgain] must not soft-reload messages for those — GET often lags
  /// reactions and wipes the badge the user just set.
  int _localOverlayDepth = 0;

  /// First GET messages finished (success or failure) — allows empty rooms.
  bool _initialMessagesLoadDone = false;

  /// Group roster from GET /chat/conversations/{id}.
  List<ChatUserModel> _participants = const [];
  String? _myRole;
  int _rosterVersion = 0;

  /// Avoid duplicate GET /chat/conversations/{id} when init + loadMessages both fire.
  Future<void>? _conversationDetailsFuture;
  int? _conversationDetailsLoadedFor;
  String? _conversationDetailsLoadedChatType;
  DateTime? _lastCaseRosterRefresh;
  List<ChatUserModel> get participants => _participants;
  String? get myRole => _myRole;

  /// WhatsApp-style first-name list for the group header subtitle.
  /// [youLabel] replaces the current user's name (e.g. localized "You").
  /// Dedupes by user id so members who share a first name still appear.
  String membersSubtitlePreview({String youLabel = 'You'}) {
    final names = <String>[];
    final seenIds = <int>{};
    for (final p in _participants) {
      final isMe = p.id != null && p.id == _currentUserId;
      if (p.id != null && !seenIds.add(p.id!)) continue;

      if (isMe) {
        names.add(youLabel);
      } else {
        final full = ChatMappers.userDisplayName(p).trim();
        final fallback = (p.name ?? '').trim();
        final display = full.isNotEmpty ? full : fallback;
        if (display.isEmpty) continue;
        var first = ChatComposerActivityLabels.firstNameOf(display);
        if (first.isEmpty) {
          first = display.split(RegExp(r'\s+')).firstWhere(
                (s) => s.isNotEmpty,
                orElse: () => display,
              );
        }
        if (first.isEmpty) continue;
        names.add(first);
      }
      if (names.length >= 8) break;
    }
    return names.join(', ');
  }

  int get memberCount => _participants.length;

  /// Immediately drop a member from the local roster (Chat Info remove).
  void removeParticipantLocally(int userId) {
    final before = _participants.length;
    _participants = [
      for (final p in _participants)
        if (p.id != userId) p,
    ];
    if (_participants.length == before) return;
    _rosterVersion++;
    _emitLoaded();
  }

  /// Replace the local roster (e.g. after Chat Info edits).
  void setParticipants(List<ChatUserModel> participants) {
    _participants = List<ChatUserModel>.of(participants);
    _rosterVersion++;
    _emitLoaded();
  }

  /// Local payloads for pending / failed optimistic sends (keyed by clientTempId).
  final Map<String, _PendingSendPayload> _pendingSends = {};
  bool _flushingPending = false;
  final Set<String> _inFlightTempIds = {};
  final Map<String, CancelToken> _sendCancelTokens = {};
  final Set<String> _cancelledTempIds = {};

  /// Temp ids cancelled while upload may still complete on the server.
  final Map<String, _CancelledSendWatch> _cancelledSendWatches = {};

  /// Typing / recording / uploading activity we broadcast to peers.
  Timer? _typingStartDebounce;
  Timer? _typingStopTimer;
  ChatComposerActivity _localActivity = ChatComposerActivity.none;
  ChatComposerActivity _peerActivity = ChatComposerActivity.none;
  String? _peerTypingName;
  Timer? _peerTypingClearTimer;

  /// After a peer message arrives, ignore stale recording/sending/typing echoes.
  DateTime? _suppressPeerComposerActivityUntil;
  bool _peerIsOnline = false;
  final Set<int> _onlinePeerIds = {};
  bool _peerAppOnline = false;

  /// Live online flag for the header — updates even while messages are loading
  /// (BlocState.loading has no peerIsOnline field).
  final ValueNotifier<bool> peerIsOnlineLive = ValueNotifier(false);

  /// Debounce offline so presence re-snapshots don't flash Online→Offline→Online.
  Timer? _peerOfflineDebounce;

  /// Soft online from recent message/typing — expires unless Ably confirms.
  Timer? _softOnlineExpiry;

  /// GET messages marks the thread read on the server; debounce while viewing.
  Timer? _markReadDebounce;

  /// Reply-to state: set when user taps reply, cleared after send.
  ChatMessageItem? _replyToMessage;
  ChatMessageItem? get replyToMessage => _replyToMessage;

  ChatMessageItem? _editingMessage;
  ChatMessageItem? get editingMessage => _editingMessage;

  StreamSubscription<ChatRealtimeEvent>? _realtimeSub;
  StreamSubscription<bool>? _connectivitySub;

  /// Set at the start of [close] so late realtime events don't mark messages read
  /// while the user is already back on the chats list.
  bool _isDisposing = false;

  static ChatRoomCubit get(context) => BlocProvider.of<ChatRoomCubit>(context);

  bool get isReady => _contextId != null && _chatType != null;

  /// Private chats use contextId as the peer user id.
  int? get _trackedPeerUserId =>
      _chatType == ChatApiType.private ? _contextId : null;

  void init({
    required int contextId,
    required String chatType,
    required int currentUserId,
    int? conversationId,
    String? peerDisplayName,
    String? myDisplayName,
    String? myImageUrl,
    bool? peerIsOnline,
    List<ChatUserModel>? initialParticipants,
  }) {
    _contextId = contextId;
    chatType = ChatApiType.fromApi(chatType) ?? chatType;
    _chatType = chatType;
    _currentUserId = currentUserId;
    _conversationId = conversationId;
    _conversationDetailsLoadedFor = null;
    _conversationDetailsLoadedChatType = null;
    _conversationDetailsFuture = null;
    _peerDisplayName = peerDisplayName;
    _peerTypingName = ChatComposerActivityLabels.firstNameOf(peerDisplayName);
    _myDisplayName = myDisplayName;
    _myImageUrl = myImageUrl;
    _peerIsOnline = peerIsOnline ?? false;
    _recipientUnavailable = false;
    if (initialParticipants != null && initialParticipants.isNotEmpty) {
      _participants = List<ChatUserModel>.of(initialParticipants);
    }
    final tracked = _trackedPeerUserId;
    if (tracked != null) {
      // Trust Chats-list Online immediately — conversation presence leave on
      // room open must not grey the header while presence:app still has them.
      _peerAppOnline =
          _realtime.isUserAppOnline(tracked) || peerIsOnline == true;
      if (_peerAppOnline) _peerIsOnline = true;
    }
    peerIsOnlineLive.value = _peerIsOnline;
    // Always refresh app presence (even before conversationId) so the header
    // shows Online from presence:app while messages / room attach catch up.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isDisposing || isClosed) return;
      unawaited(_syncAppPresenceForPeer());
      if (_conversationId != null) {
        // Defer Ably until after the first paint — opening from a push tap
        // used to reconnect Ably in the same frame as Metal surface recreate.
        unawaited(_connectRealtimeIfPossible());
      }
    });
    // Show shimmer immediately — never flash "No messages yet" before fetch.
    if (!isClosed) {
      emit(const ChatRoomState.loading());
    }
    unawaited(loadMessages(refresh: true));
    // Conversation details: group roster + peer/group avatar (also private —
    // push opens often omit peerImageUrl).
    if (chatType == ChatApiType.group ||
        chatType == ChatApiType.socialGroup ||
        chatType == ChatApiType.caseGroup ||
        chatType == ChatApiType.private) {
      unawaited(_loadConversationDetails());
    }
  }

  void _emitLoaded({
    bool isSending = false,
    bool isLoadingMore = false,
  }) {
    if (_isDisposing || isClosed) return;
    // Roster / presence can finish before the first messages response. Emitting
    // loaded([]) here would flash the empty state — keep shimmer until load.
    if (!_initialMessagesLoadDone) return;
    emit(
      ChatRoomState.loaded(
        messages: List.of(_messages),
        conversationId: _conversationId,
        hasMore: _hasMore,
        isSending: isSending,
        isLoadingMore: isLoadingMore,
        peerIsTyping: _peerActivity.isActive,
        peerActivity: _peerActivity,
        peerTypingName: _peerTypingName,
        peerIsOnline: _peerIsOnline,
        replyToMessage: _replyToMessage,
        editingMessage: _editingMessage,
        rosterVersion: _rosterVersion,
      ),
    );
  }

  bool _recipientUnavailable = false;

  bool get recipientUnavailable => _recipientUnavailable;

  bool get iBlockedPeer {
    final peerId = _trackedPeerUserId;
    return peerId != null &&
        GetIt.I.isRegistered<ChatBlockService>() &&
        GetIt.I<ChatBlockService>().isBlocked(peerId);
  }

  void clearRecipientUnavailable() {
    if (!_recipientUnavailable) return;
    _recipientUnavailable = false;
    _emitLoaded();
  }

  Future<bool> blockPeer() async {
    final peerId = _trackedPeerUserId;
    if (peerId == null || !GetIt.I.isRegistered<ChatBlockService>()) {
      return false;
    }
    final result = await GetIt.I<ChatBlockService>().blockUser(peerId);
    return result.fold((_) => false, (_) {
      _emitLoaded();
      return true;
    });
  }

  Future<bool> unblockPeer() async {
    final peerId = _trackedPeerUserId;
    if (peerId == null || !GetIt.I.isRegistered<ChatBlockService>()) {
      return false;
    }
    final result = await GetIt.I<ChatBlockService>().unblockUser(peerId);
    return result.fold((_) => false, (_) {
      _recipientUnavailable = false;
      _emitLoaded();
      return true;
    });
  }

  bool get _isGroupLikeChat =>
      _chatType == ChatApiType.group ||
      _chatType == ChatApiType.socialGroup ||
      _chatType == ChatApiType.caseGroup;

  /// Other members (everyone except me) — used for all-delivered / all-seen.
  int get _otherMembersCount {
    final mine = _currentUserId;
    final fromRoster = _participants
        .where((p) => p.id != null && (mine == null || p.id != mine))
        .length;
    return fromRoster;
  }

  /// Seed empty `delivery` from the group roster so Message Info can show
  /// Remaining immediately (and realtime receipts have rows to update).
  ChatMessageModel _seedDeliveryRoster(ChatMessageModel message) {
    if (!_isGroupLikeChat) return message;
    if ((message.delivery ?? const []).isNotEmpty) return message;
    if (_participants.isEmpty) return message;
    final senderId = message.sender?.id;
    final isMine = senderId != null &&
        senderId == _currentUserId &&
        message.type != 'system';
    if (!isMine) return message;
    return message.copyWith(
      delivery: [
        for (final p in _participants)
          if (p.id != null && p.id != _currentUserId)
            ChatDeliveryReceiptModel(
              id: p.id,
              name: p.name,
              lname: p.lname,
              image: p.image,
              specialty: p.specialty,
              workingplace: p.workingplace,
              isSyndicateCardRequired: p.isSyndicateCardRequired,
            ),
      ],
    );
  }

  List<ChatMessageModel> _seedDeliveryOnList(List<ChatMessageModel> list) => [
        for (final m in list) _seedDeliveryRoster(m),
      ];

  /// Live lookup for Message Info sheet (realtime receipts).
  ChatMessageItem? messageById(String id) {
    for (final m in _messages) {
      if (m.id == id || m.clientTempId == id) return m;
    }
    return null;
  }

  void _rebuildMessageItems() {
    final userId = _currentUserId ?? 0;
    final previousById = <String, ChatMessageItem>{
      for (final m in _messages) m.id: m,
      for (final m in _messages)
        if (m.clientTempId != null && m.clientTempId!.isNotEmpty)
          m.clientTempId!: m,
    };
    final localPending = _messages
        .where(
          (m) =>
              m.clientTempId != null &&
              _pendingSends.containsKey(m.clientTempId),
        )
        .toList(growable: false);
    final localSystem = _messages
        .where((m) => m.isSystem && m.id.startsWith('local-system-'))
        .toList(growable: false);
    final mapped = ChatMappers.toMessageItems(
      _rawMessages,
      currentUserId: userId,
      isGroupChat: _isGroupLikeChat,
      otherMembersCount: _otherMembersCount,
    );
    // Keep failed/cancelled uploads in chronological place — never force them
    // to the end (that made cancelled media jump back to "last message").
    _messages = [
      for (final item in _mergeLocalPendingByCreatedAt(mapped, localPending))
        _enrichReplyMediaPreview(
          _preserveLocalMessageState(
            previousById[item.id] ??
                _previousOptimisticForServerMessage(item, previousById),
            item,
          ),
        ),
    ];
    for (final sys in localSystem) {
      var matchIdx = _messages.indexWhere(
        (m) =>
            m.isSystem &&
            m.text.trim().toLowerCase() == sys.text.trim().toLowerCase(),
      );
      // Server copy can use different wording — coalesce with the newest
      // system row so the chip doesn't remount/animate a second later.
      if (matchIdx < 0 && _messages.isNotEmpty && _messages.last.isSystem) {
        matchIdx = _messages.length - 1;
      }
      if (matchIdx >= 0) {
        final server = _messages[matchIdx];
        _messages = [
          for (var i = 0; i < _messages.length; i++)
            if (i == matchIdx) server.copyWith(id: sys.id) else _messages[i],
        ];
      } else {
        _messages = [..._messages, sys];
      }
    }
    _maybeFillPeerImageFromMessages();
  }

  /// Insert local pending/failed optimistic bubbles by [createdAt] among server
  /// rows (list is oldest → newest).
  List<ChatMessageItem> _mergeLocalPendingByCreatedAt(
    List<ChatMessageItem> server,
    List<ChatMessageItem> pending,
  ) {
    if (pending.isEmpty) return server;
    if (server.isEmpty) return List<ChatMessageItem>.of(pending);

    final pendingSorted = List<ChatMessageItem>.of(pending)
      ..sort((a, b) {
        final at = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bt = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return at.compareTo(bt);
      });

    final result = <ChatMessageItem>[];
    var pi = 0;
    for (final s in server) {
      final sTime = s.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      while (pi < pendingSorted.length) {
        final p = pendingSorted[pi];
        final pTime = p.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        if (pTime.isAfter(sTime)) break;
        result.add(p);
        pi++;
      }
      result.add(s);
    }
    while (pi < pendingSorted.length) {
      result.add(pendingSorted[pi]);
      pi++;
    }
    return result;
  }

  void _maybeFillPeerImageFromMessages() {
    if (_peerImageUrl != null && _peerImageUrl!.trim().isNotEmpty) return;
    if (_chatType != ChatApiType.private) return;
    for (final m in _messages) {
      if (m.isOutgoing || m.isSystem) continue;
      final img = m.senderImageUrl?.trim();
      if (img != null && img.isNotEmpty) {
        _peerImageUrl = img;
        return;
      }
    }
  }

  ChatMessageItem _enrichReplyMediaPreview(ChatMessageItem item) {
    final reply = item.replyTo;
    if (reply == null) return item;

    ChatAttachmentItem? image = reply.imageAttachment;
    ChatAttachmentItem? voice = reply.voiceAttachment;
    var imageCount = reply.imageCount;

    ChatMessageItem? original;
    for (final m in _messages) {
      if (m.id == '${reply.id}') {
        original = m;
        break;
      }
    }
    image ??= original?.firstImageAttachment;
    voice ??= original?.firstVoiceAttachment;
    if (original != null && original.imageAttachmentCount > imageCount) {
      imageCount = original.imageAttachmentCount;
    }

    if (image == null || voice == null || imageCount <= 0) {
      for (final raw in _rawMessages) {
        if (raw.id != reply.id) continue;
        var rawImageCount = 0;
        for (final a in raw.attachments ?? const []) {
          final att = ChatAttachmentItem(
            id: a.id,
            url: a.url,
            mimeType: a.mimeType,
            originalName: a.originalName,
            type: a.type ?? 'file',
            durationMs: a.durationSeconds != null && a.durationSeconds! > 0
                ? a.durationSeconds! * 1000
                : null,
          );
          if (att.isImage) {
            rawImageCount++;
            image ??= att;
          }
          if (voice == null && att.isVoice) voice = att;
        }
        if (rawImageCount > imageCount) imageCount = rawImageCount;
        break;
      }
    }

    if (imageCount <= 0 && image != null) imageCount = 1;

    if (image == reply.imageAttachment &&
        voice == reply.voiceAttachment &&
        imageCount == reply.imageCount) {
      return item;
    }

    final fallbackText = image != null
        ? '[Image]'
        : voice != null
            ? '[Voice message]'
            : reply.text;
    return item.copyWith(
      replyTo: ChatReplyItem(
        id: reply.id,
        senderName: reply.senderName,
        text: reply.text.isNotEmpty ? reply.text : fallbackText,
        isOutgoing: reply.isOutgoing,
        imageAttachment: image,
        voiceAttachment: voice,
        imageCount: imageCount,
      ),
    );
  }

  /// Soft-reload after background: optimistic row may still be keyed by
  /// `local_*` while the API row uses the server id.
  ChatMessageItem? _previousOptimisticForServerMessage(
    ChatMessageItem next,
    Map<String, ChatMessageItem> previousById,
  ) {
    if (!next.isOutgoing) return null;
    for (final m in previousById.values) {
      final temp = m.clientTempId;
      if (temp == null || temp.isEmpty || !m.isOutgoing) continue;
      if (m.id != temp) continue; // already swapped to server id
      if (m.text != next.text) continue;
      final a = m.createdAt;
      final b = next.createdAt;
      if (a != null &&
          b != null &&
          a.difference(b).abs() > const Duration(minutes: 2)) {
        continue;
      }
      return m;
    }
    return null;
  }

  ChatMessageItem _preserveLocalAttachments(
    ChatMessageItem? previous,
    ChatMessageItem next,
  ) {
    if (previous == null || previous.attachments.isEmpty) return next;
    return next.copyWith(
      attachments: _mergeLocalAttachments(
        previous.attachments,
        next.attachments,
      ),
    );
  }

  /// Keep local delivery ticks when a refresh remaps stale API `sent` status.
  ChatMessageItem _preserveLocalMessageState(
    ChatMessageItem? previous,
    ChatMessageItem next,
  ) {
    var merged = _preserveLocalAttachments(previous, next);
    // Keep clientTempId across soft-reload so the list identity (and send
    // pop-in) stays stable after background → resume.
    final prevTemp = previous?.clientTempId;
    if (prevTemp != null &&
        prevTemp.isNotEmpty &&
        (merged.clientTempId == null || merged.clientTempId!.isEmpty)) {
      merged = merged.copyWith(clientTempId: prevTemp);
    }
    // Soft-reload / media-viewer pop must not wipe reaction badges when the
    // messages payload omits or lags reactions (including when peers remain
    // but my own emoji was dropped from the GET payload).
    // Never undo an intentional local remove (hold.emoji == null).
    if (previous != null) {
      final holdId = int.tryParse(merged.id);
      final hold = holdId == null ? null : _localReactionHolds[holdId];
      final removingMine =
          hold != null && hold.isActive && hold.emoji == null;

      final prevHasRx = previous.reactions.isNotEmpty ||
          (previous.reactionEmoji?.trim().isNotEmpty ?? false);
      final nextHasRx = merged.reactions.isNotEmpty ||
          (merged.reactionEmoji?.trim().isNotEmpty ?? false);
      if (prevHasRx && !nextHasRx && !removingMine) {
        merged = merged.copyWith(
          reactions: previous.reactions,
          reactionEmoji: previous.reactionEmoji,
        );
      } else if (!removingMine) {
        final prevMine = _myReactionEmojiFromItem(previous);
        final nextMine = _myReactionEmojiFromItem(merged);
        if (prevMine != null && nextMine == null) {
          merged = merged.copyWith(
            reactions: previous.reactions,
            reactionEmoji: previous.reactionEmoji ?? prevMine,
          );
        } else if (prevMine != null &&
            nextMine != null &&
            prevMine != nextMine) {
          // Prefer the locally shown emoji when GET is still on the old one.
          if (hold != null && hold.isActive && hold.emoji == prevMine) {
            merged = merged.copyWith(
              reactions: previous.reactions,
              reactionEmoji: prevMine,
            );
          }
        }
      }
    }
    if (previous == null || !previous.isOutgoing || !next.isOutgoing) {
      return merged;
    }
    // Groups: API / delivery receipts are authoritative — never keep inflated
    // local ticks from 1:1-style presence upgrades.
    if (_isGroupLikeChat) return merged;
    if (_messageStatusRank(previous.status) > _messageStatusRank(next.status) &&
        (previous.status == ChatMessageStatus.delivered ||
            previous.status == ChatMessageStatus.seen)) {
      merged = merged.copyWith(status: previous.status);
    }
    return merged;
  }

  int _messageStatusRank(ChatMessageStatus status) {
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

  void _restorePendingFromStore() {
    final contextId = _contextId;
    final chatType = _chatType;
    if (contextId == null || chatType == null) return;

    final entries = ChatPendingSendStore.instance.entriesFor(
      chatType: chatType,
      contextId: contextId,
    );
    if (entries.isEmpty) return;

    final toInsert = <ChatMessageItem>[];
    for (final entry in entries) {
      // Still uploading in a previous cubit instance — keep "sending" UI.
      final status = ChatPendingSendStore.instance.isInFlight(entry.tempId)
          ? ChatMessageStatus.sending
          : (entry.status == ChatMessageStatus.sending
              ? ChatMessageStatus.pending
              : entry.status);
      _pendingSends[entry.tempId] = _PendingSendPayload(
        text: entry.text,
        images: entry.images,
        voices: entry.voices,
        files: entry.files,
        voiceDurationsMs: entry.voiceDurationsMs,
        replyToId: entry.replyToId,
      );
      if (status != entry.status) {
        ChatPendingSendStore.instance.save(
          chatType: chatType,
          contextId: contextId,
          entry: entry.copyWithStatus(status),
        );
      }
      if (!_messages.any((m) => m.clientTempId == entry.tempId)) {
        toInsert.add(entry.copyWithStatus(status).toMessageItem());
      }
      if (ChatPendingSendStore.instance.isInFlight(entry.tempId)) {
        unawaited(_watchInFlightSend(entry.tempId));
      }
    }
    if (toInsert.isNotEmpty) {
      final serverOnly = [
        for (final m in _messages)
          if (m.clientTempId == null ||
              !_pendingSends.containsKey(m.clientTempId))
            m,
      ];
      final pending = [
        for (final m in _messages)
          if (m.clientTempId != null &&
              _pendingSends.containsKey(m.clientTempId))
            m,
        ...toInsert,
      ];
      _messages = _mergeLocalPendingByCreatedAt(serverOnly, pending);
    }
  }

  /// When reopening while a previous cubit is still uploading, wait it out
  /// then reconcile optimistic bubble with store / server.
  Future<void> _watchInFlightSend(String tempId) async {
    while (!_isDisposing &&
        !isClosed &&
        ChatPendingSendStore.instance.isInFlight(tempId)) {
      await Future<void>.delayed(const Duration(milliseconds: 250));
    }
    if (_isDisposing || isClosed) return;

    final contextId = _contextId;
    final chatType = _chatType;
    if (contextId == null || chatType == null) return;

    final stillQueued = ChatPendingSendStore.instance
        .entriesFor(chatType: chatType, contextId: contextId)
        .where((e) => e.tempId == tempId)
        .toList(growable: false);

    if (stillQueued.isEmpty) {
      _pendingSends.remove(tempId);
      _messages = [
        for (final m in _messages)
          if (m.clientTempId != tempId) m,
      ];
      await loadMessages(refresh: false);
      return;
    }

    final entry = stillQueued.first;
    _messages = [
      for (final m in _messages)
        if (m.clientTempId == tempId) entry.toMessageItem() else m,
    ];
    _emitLoaded();
    if (entry.status == ChatMessageStatus.pending) {
      unawaited(_flushPendingSends());
    }
  }

  void _persistPendingEntry({
    required String tempId,
    required String previewText,
    required String timeLabel,
    required ChatMessageStatus status,
    required _PendingSendPayload payload,
  }) {
    final contextId = _contextId;
    final chatType = _chatType;
    if (contextId == null || chatType == null) return;

    ChatPendingSendStore.instance.save(
      chatType: chatType,
      contextId: contextId,
      entry: ChatPendingSendEntry(
        tempId: tempId,
        previewText: previewText,
        timeLabel: timeLabel,
        status: status,
        createdAt: DateTime.now(),
        text: payload.text,
        images: payload.images,
        voices: payload.voices,
        files: payload.files,
        voiceDurationsMs: payload.voiceDurationsMs,
        replyToId: payload.replyToId,
      ),
    );
  }

  void _updatePersistedStatus(String tempId, ChatMessageStatus status) {
    final contextId = _contextId;
    final chatType = _chatType;
    if (contextId == null || chatType == null) return;
    final entries = ChatPendingSendStore.instance.entriesFor(
      chatType: chatType,
      contextId: contextId,
    );
    for (final entry in entries) {
      if (entry.tempId != tempId) continue;
      ChatPendingSendStore.instance.save(
        chatType: chatType,
        contextId: contextId,
        entry: entry.copyWithStatus(status),
      );
      break;
    }
  }

  void _removePersisted(String tempId) {
    final contextId = _contextId;
    final chatType = _chatType;
    if (contextId == null || chatType == null) return;
    ChatPendingSendStore.instance.remove(
      chatType: chatType,
      contextId: contextId,
      tempId: tempId,
    );
  }

  /// Call before pushing a local overlay (e.g. full-screen image) so
  /// [onVisibleAgain] reconnects realtime without replacing the message list.
  void beginLocalOverlay() {
    _localOverlayDepth++;
  }

  /// Visible again after a chat pushed on top of it closed: that chat took
  /// over the realtime channel, so re-attach and catch up (also marks read).
  /// Local overlays (image viewer) only re-attach — never soft-reload.
  void onVisibleAgain() {
    if (_isDisposing || isClosed || _conversationId == null) return;
    unawaited(_connectRealtimeIfPossible());
    if (_localOverlayDepth > 0) {
      _localOverlayDepth--;
      return;
    }
    unawaited(loadMessages(refresh: false));
  }

  Future<void> _connectRealtimeIfPossible() async {
    // A closing room must never re-enter the chat's presence.
    if (_isDisposing || isClosed) return;
    final conversationId = _conversationId;
    final userId = _currentUserId;
    if (conversationId == null || userId == null) return;

    await _realtime.subscribeToConversation(
      conversationId: conversationId,
      currentUserId: userId,
      displayName: _myDisplayName,
      imageUrl: _myImageUrl,
    );
    await _syncAppPresenceForPeer();
  }

  /// Ensure we are on presence:app, refresh who is Online, update header.
  Future<void> _syncAppPresenceForPeer() async {
    final userId = _currentUserId;
    if (userId == null || _isDisposing || isClosed) return;
    try {
      await _realtime.ensureAppPresence(
        currentUserId: userId,
        displayName: _myDisplayName,
        imageUrl: _myImageUrl,
      );
      await _realtime.refreshAppPresenceSnapshot();
    } catch (_) {
      return;
    }
    if (_isDisposing || isClosed) return;
    final tracked = _trackedPeerUserId;
    if (tracked != null) {
      // Snapshot can lag right after room open — never clear a known Online.
      if (_realtime.isUserAppOnline(tracked)) {
        _peerAppOnline = true;
      }
    }
    _recomputePeerOnline();
  }

  void _publishPeerOnlineLive() {
    if (peerIsOnlineLive.value != _peerIsOnline) {
      peerIsOnlineLive.value = _peerIsOnline;
    }
  }

  bool _isEventForThisChat(int? conversationId) {
    // A room without a conversation yet has no channel of its own — anything
    // arriving now belongs to another chat (e.g. a Chats-list listener).
    if (_conversationId == null) return false;
    if (conversationId == null) return true;
    return conversationId == _conversationId;
  }

  bool _peerIsInThisConversation() {
    final tracked = _trackedPeerUserId;
    if (tracked != null) return _onlinePeerIds.contains(tracked);
    return _onlinePeerIds.isNotEmpty;
  }

  ChatMessageStatus _statusFromSendResponse(String? status) {
    final normalized = status?.trim().toLowerCase();
    if (normalized == 'seen' || normalized == 'read') {
      return ChatMessageStatus.seen;
    }
    if (normalized == 'delivered') return ChatMessageStatus.delivered;
    return ChatMessageStatus.sent;
  }

  /// Upgrade outgoing ticks only forward: sent → delivered → seen.
  /// Never touch messages that are still uploading / queued locally.
  /// Private (1:1) only — groups use per-member delivery/read receipts.
  void _upgradeOutgoingToAtLeast(ChatMessageStatus target) {
    if (_isGroupLikeChat) return;
    if (target != ChatMessageStatus.delivered &&
        target != ChatMessageStatus.seen) {
      return;
    }
    var changed = false;
    final next = <ChatMessageItem>[];
    for (final m in _messages) {
      if (!m.isOutgoing) {
        next.add(m);
        continue;
      }
      // Keep clock / pending UI while the upload is in flight.
      if (m.isUploading ||
          m.status == ChatMessageStatus.sending ||
          m.status == ChatMessageStatus.pending) {
        next.add(m);
        continue;
      }
      if (target == ChatMessageStatus.seen &&
          (m.status == ChatMessageStatus.sent ||
              m.status == ChatMessageStatus.delivered)) {
        next.add(m.copyWith(status: ChatMessageStatus.seen));
        changed = true;
      } else if (target == ChatMessageStatus.delivered &&
          m.status == ChatMessageStatus.sent) {
        next.add(m.copyWith(status: ChatMessageStatus.delivered));
        changed = true;
      } else {
        next.add(m);
      }
    }
    if (!changed) return;
    _messages = next;

    // Persist into raw so a later loadMessages/_rebuild does not wipe ticks
    // when the API still returns stale `sent`.
    final apiStatus = target == ChatMessageStatus.seen ? 'read' : 'delivered';
    final apiRank = target == ChatMessageStatus.seen ? 3 : 2;
    _rawMessages = [
      for (final m in _rawMessages)
        if (m.sender?.id == _currentUserId &&
            m.type != 'system' &&
            m.isDeleted != true &&
            _apiStatusRank(m.status) < apiRank)
          m.copyWith(status: apiStatus)
        else
          m,
    ];
    _emitLoaded();
  }

  int _apiStatusRank(String? status) {
    switch (status) {
      case 'seen':
      case 'read':
        return 3;
      case 'delivered':
        return 2;
      case 'sent':
        return 1;
      default:
        return 0;
    }
  }

  /// Merge a peer into `reads` / `delivery` on outgoing messages they caught up to.
  /// Group ticks advance to seen only when every other member has read.
  /// 1:1: the server emits `message.read` only once the peer opened the
  /// messages, so it always means blue ticks — but only with a peer user id.
  void _applyGroupReadReceipt({
    required int? readerUserId,
    required int? lastReadMessageId,
    String? readAt,
  }) {
    if (!_isGroupLikeChat) {
      if (readerUserId == null) return;
      _upgradeOutgoingToAtLeast(ChatMessageStatus.seen);
      return;
    }
    if (readerUserId == null) return;

    ChatUserModel? reader;
    for (final p in _participants) {
      if (p.id == readerUserId) {
        reader = p;
        break;
      }
    }
    reader ??= ChatUserModel(id: readerUserId);

    final nowIso = _serverTimeOrNow(readAt);
    var rawChanged = false;
    final nextRaw = <ChatMessageModel>[];
    for (final m in _rawMessages) {
      final mid = m.id;
      final senderId = m.sender?.id;
      final isMine =
          senderId != null && senderId == _currentUserId && m.type != 'system';
      if (!isMine || mid == null || m.isDeleted == true) {
        nextRaw.add(m);
        continue;
      }
      if (lastReadMessageId != null && mid > lastReadMessageId) {
        nextRaw.add(m);
        continue;
      }

      final existingReads = List<ChatUserModel>.of(m.reads ?? const []);
      if (!existingReads.any((u) => u.id == readerUserId)) {
        existingReads.add(reader);
      }

      final existingDelivery =
          List<ChatDeliveryReceiptModel>.of(m.delivery ?? const []);
      if (existingDelivery.isEmpty && _participants.isNotEmpty) {
        for (final p in _participants) {
          if (p.id == null || p.id == _currentUserId) continue;
          existingDelivery.add(
            ChatDeliveryReceiptModel(
              id: p.id,
              name: p.name,
              lname: p.lname,
              image: p.image,
            ),
          );
        }
      }
      final deliveryIdx =
          existingDelivery.indexWhere((d) => d.id == readerUserId);
      if (deliveryIdx >= 0) {
        final prev = existingDelivery[deliveryIdx];
        existingDelivery[deliveryIdx] = prev.copyWith(
          deliveredAt: prev.deliveredAt ?? nowIso,
          readAt: prev.readAt ?? nowIso,
        );
      } else {
        existingDelivery.add(
          ChatDeliveryReceiptModel(
            id: reader.id,
            name: reader.name,
            lname: reader.lname,
            image: reader.image,
            deliveredAt: nowIso,
            readAt: nowIso,
          ),
        );
      }

      final deliveredCount = existingDelivery
          .where((d) => (d.deliveredAt?.trim().isNotEmpty ?? false))
          .length;
      final seenCount = existingDelivery
          .where((d) => (d.readAt?.trim().isNotEmpty ?? false))
          .length;
      final patched = m.copyWith(
        reads: existingReads,
        readsCount: existingReads.length,
        delivery: existingDelivery,
        deliveredToCount: deliveredCount,
        seenByCount: seenCount,
      );
      final status = ChatMappers.aggregateGroupStatusApi(
            message: patched,
            otherMembersCount: _otherMembersCount,
          ) ??
          patched.status;
      nextRaw.add(patched.copyWith(status: status));
      rawChanged = true;
    }

    if (!rawChanged) return;
    _rawMessages = nextRaw;
    _rebuildMessageItems();
    _emitLoaded();
  }

  /// Server event time; the phone's clock only when the event carried none.
  static String _serverTimeOrNow(String? serverTime) {
    final t = serverTime?.trim();
    if (t != null && t.isNotEmpty) return t;
    return DateTime.now().toUtc().toIso8601String();
  }

  /// Mark one member as delivered; group ticks go to delivered only when all have.
  void _applyGroupDeliveredReceipt(
      {required int? userId, String? deliveredAt}) {
    if (!_isGroupLikeChat) {
      _upgradeOutgoingToAtLeast(ChatMessageStatus.delivered);
      return;
    }
    if (userId == null) return;

    ChatUserModel? member;
    for (final p in _participants) {
      if (p.id == userId) {
        member = p;
        break;
      }
    }
    member ??= ChatUserModel(id: userId);

    final nowIso = _serverTimeOrNow(deliveredAt);
    var rawChanged = false;
    final nextRaw = <ChatMessageModel>[];
    for (final m in _rawMessages) {
      final mid = m.id;
      final senderId = m.sender?.id;
      final isMine =
          senderId != null && senderId == _currentUserId && m.type != 'system';
      if (!isMine || mid == null || m.isDeleted == true) {
        nextRaw.add(m);
        continue;
      }

      final existingDelivery =
          List<ChatDeliveryReceiptModel>.of(m.delivery ?? const []);
      if (existingDelivery.isEmpty && _participants.isNotEmpty) {
        for (final p in _participants) {
          if (p.id == null || p.id == _currentUserId) continue;
          existingDelivery.add(
            ChatDeliveryReceiptModel(
              id: p.id,
              name: p.name,
              lname: p.lname,
              image: p.image,
            ),
          );
        }
      }
      final deliveryIdx = existingDelivery.indexWhere((d) => d.id == userId);
      if (deliveryIdx >= 0) {
        final prev = existingDelivery[deliveryIdx];
        if (prev.deliveredAt?.trim().isNotEmpty ?? false) {
          nextRaw.add(m);
          continue;
        }
        existingDelivery[deliveryIdx] = prev.copyWith(
          deliveredAt: nowIso,
        );
      } else {
        existingDelivery.add(
          ChatDeliveryReceiptModel(
            id: member.id,
            name: member.name,
            lname: member.lname,
            image: member.image,
            deliveredAt: nowIso,
          ),
        );
      }

      final deliveredCount = existingDelivery
          .where((d) => (d.deliveredAt?.trim().isNotEmpty ?? false))
          .length;
      final seenCount = existingDelivery
          .where((d) => (d.readAt?.trim().isNotEmpty ?? false))
          .length;
      final patched = m.copyWith(
        delivery: existingDelivery,
        deliveredToCount: deliveredCount,
        seenByCount: seenCount,
      );
      final status = ChatMappers.aggregateGroupStatusApi(
            message: patched,
            otherMembersCount: _otherMembersCount,
          ) ??
          patched.status;
      nextRaw.add(patched.copyWith(status: status));
      rawChanged = true;
    }

    if (!rawChanged) return;
    _rawMessages = nextRaw;
    _rebuildMessageItems();
    _emitLoaded();
  }

  void _onRealtimeEvent(ChatRealtimeEvent event) {
    if (_isDisposing) return;
    switch (event) {
      case ChatMessageSentEvent(:final message):
        if (!_isEventForThisChat(message.conversationId)) return;
        final isMine =
            message.sender?.id != null && message.sender!.id == _currentUserId;
        // Skip our own non-system messages — send flow already reconciles them.
        // System events (member removed/added) must still appear for the actor.
        final isSystem = message.type == 'system';
        // Cancelled multipart can still land on the server after Dio aborts.
        // Delete that orphan for everyone so the peer never keeps it.
        if (isMine &&
            !isSystem &&
            message.id != null &&
            _claimCancelledSendWatchForMessage(message)) {
          unawaited(
            _deleteServerMessageForCancelledSend(
              messageId: message.id!,
              conversationId: message.conversationId ?? _conversationId,
            ),
          );
          return;
        }
        if ((!isMine || isSystem) &&
            message.id != null &&
            !_rawMessages.any((m) => m.id == message.id)) {
          _rawMessages = [..._rawMessages, message];
          _rebuildMessageItems();
          _emitLoaded();
          if (!isMine) {
            unawaited(_playIncomingSoundIfUnmuted(
              conversationId: message.conversationId ?? _conversationId,
            ));
          }
        }
        if (!isMine) {
          // Peer is messaging — treat as delivered. Seen only via message.read
          // (presence alone wrongly marked archived chats as seen after leave).
          _upgradeOutgoingToAtLeast(ChatMessageStatus.delivered);
          // Message arrived — drop recording / sending immediately.
          // Keep ignoring typing echoes through the voice upload gap + after.
          _suppressPeerComposerActivityUntil =
              DateTime.now().add(const Duration(seconds: 3));
          _clearPeerComposerActivity();
          // Soft online only — don't add to Ably member set (that stuck
          // "online" after the peer closed the app without a leave event).
          final senderId = message.sender?.id;
          if (senderId != null) {
            _markPeerRecentlyActive(userId: senderId);
          }
          final contextId = _contextId;
          final chatType = _chatType;
          if (contextId != null && chatType != null) {
            unawaited(
              _repository.markDelivered(
                contextId: contextId,
                chatType: chatType,
              ),
            );
          }
          // Only mark read while this chat room is still the active screen.
          if (_realtime.subscribedConversationId == _conversationId &&
              !_isDisposing) {
            final conversationId = message.conversationId ?? _conversationId;
            if (conversationId != null && GetIt.I.isRegistered<InboxCubit>()) {
              GetIt.I<InboxCubit>().markConversationRead(conversationId);
            }
            _scheduleMarkConversationReadOnServer();
          }
        }
      case ChatMessageUpdatedEvent(:final message):
        if (!_isEventForThisChat(message.conversationId)) return;
        if (message.id == null) return;
        final idStr = '${message.id}';
        final mapped = ChatMappers.toMessageItem(
          message.copyWith(isEdited: true),
          currentUserId: _currentUserId ?? 0,
          showAvatar: false,
          isGroupChat: _isGroupLikeChat,
          otherMembersCount: _otherMembersCount,
          messagesById: {
            for (final m in _rawMessages)
              if (m.id != null) m.id!: m,
            message.id!: message,
          },
        );
        final idx = _messages.indexWhere((m) => m.id == idStr);
        if (idx >= 0) {
          final prev = _messages[idx];
          _messages = [
            for (var i = 0; i < _messages.length; i++)
              if (i == idx)
                mapped.copyWith(
                  status: prev.isOutgoing ? prev.status : mapped.status,
                  attachments: mapped.attachments.isNotEmpty
                      ? mapped.attachments
                      : prev.attachments,
                  replyTo: mapped.replyTo ?? prev.replyTo,
                  isEdited: true,
                  reactionEmoji: mapped.reactionEmoji ?? prev.reactionEmoji,
                  reactions: mapped.reactions.isNotEmpty
                      ? mapped.reactions
                      : prev.reactions,
                )
              else
                _messages[i],
          ];
        } else if (!mapped.isOutgoing) {
          _messages = [..._messages, mapped.copyWith(isEdited: true)];
        }
        final rIdx = _rawMessages.indexWhere((m) => m.id == message.id);
        if (rIdx >= 0) {
          final prevRaw = _rawMessages[rIdx];
          final nextRaw = message.copyWith(isEdited: true);
          // Edited payloads often omit reactions — don't wipe the badge.
          final keepRx = (nextRaw.reactions == null ||
                  nextRaw.reactions!.isEmpty) &&
              (prevRaw.reactions != null && prevRaw.reactions!.isNotEmpty);
          _rawMessages = [
            for (var i = 0; i < _rawMessages.length; i++)
              if (i == rIdx)
                keepRx
                    ? nextRaw.copyWith(reactions: prevRaw.reactions)
                    : nextRaw
              else
                _rawMessages[i],
          ];
        } else {
          _rawMessages = [..._rawMessages, message.copyWith(isEdited: true)];
        }
        _emitLoaded();
      case ChatMessageDeletedEvent(:final messageId, :final conversationId):
        if (!_isEventForThisChat(conversationId)) return;
        _markMessageDeletedLocally(messageId);
      case ChatMessageReactedEvent(
          :final messageId,
          :final conversationId,
          :final userId,
          :final reaction,
          :final action,
        ):
        if (!_isEventForThisChat(conversationId)) return;
        final idx = _rawMessages.indexWhere((m) => m.id == messageId);
        if (idx == -1) return;
        final before = _rawMessages[idx];
        // Skip stale self-echoes that would briefly wipe an optimistic change
        // (e.g. remove old emoji after we already switched to a new one).
        if (userId != null && userId == _currentUserId) {
          final mine = _myReactionEmoji(before);
          final trimmed = reaction?.trim();
          final isRemove = (action ?? '').toLowerCase().contains('remove') ||
              (action ?? '').toLowerCase() == 'deleted' ||
              (action ?? '').toLowerCase() == 'delete';
          final hold = _localReactionHolds[messageId];
          if (hold != null && hold.isActive) {
            final held = hold.emoji?.trim();
            if (isRemove) {
              // Changing A→B emits remove(A) after we already hold B.
              if (held != null && trimmed != null && trimmed != held) {
                return;
              }
            } else {
              // Already applied optimistically, or a stale add of the old emoji.
              if (trimmed == null || trimmed != held) return;
              if (mine != null && mine == trimmed) return;
            }
          } else {
            if (isRemove &&
                mine != null &&
                trimmed != null &&
                mine != trimmed) {
              return;
            }
            if (!isRemove && mine != null && mine == trimmed) {
              return;
            }
          }
        }
        final updated = _applyReactionEvent(
          message: before,
          userId: userId,
          emoji: reaction,
          action: action,
        );
        if (_reactionsEqual(before.reactions, updated.reactions)) return;
        _rawMessages = [
          for (var i = 0; i < _rawMessages.length; i++)
            if (i == idx) updated else _rawMessages[i],
        ];
        _rebuildMessageItems();
        _emitLoaded();
      case ChatMessageReadEvent(
          :final conversationId,
          :final userId,
          :final lastReadMessageId,
          :final readAt,
        ):
        if (!_isEventForThisChat(conversationId)) return;
        // Opening this chat emits message.read for us — ignore self / missing id
        // or 1:1 ticks jump to blue while the peer never opened the thread.
        if (userId == null || userId == _currentUserId) return;
        _applyGroupReadReceipt(
          readerUserId: userId,
          lastReadMessageId: lastReadMessageId,
          readAt: readAt,
        );
      case ChatMessageDeliveredEvent(
          :final conversationId,
          :final userId,
          :final deliveredAt,
        ):
        // Ably `message.delivered` → 1:1 two ticks; groups need all members.
        if (!_isEventForThisChat(conversationId)) return;
        if (userId == null || userId == _currentUserId) return;
        _applyGroupDeliveredReceipt(userId: userId, deliveredAt: deliveredAt);
      case ChatUserTypingEvent(
          :final conversationId,
          :final userId,
          :final userName,
          :final isTyping,
          :final activity,
          :final fromPresence,
        ):
        if (!_isEventForThisChat(conversationId)) return;
        // Own typing REST/presence echoes often omit or mismatch user_id.
        // Unattributed starts were shown as the peer typing (esp. after paste).
        if (userId == null || userId == _currentUserId) return;
        final trackedPeer = _trackedPeerUserId;
        if (trackedPeer != null && userId != trackedPeer) return;
        _peerTypingClearTimer?.cancel();

        // After media/voice activity ends (or the message lands), ignore stale
        // typing REST echoes so we don't flash "is typing".
        final suppressComposer = _suppressPeerComposerActivityUntil != null &&
            DateTime.now().isBefore(_suppressPeerComposerActivityUntil!);
        if (suppressComposer) {
          _clearPeerComposerActivity();
          return;
        }

        // Offline peer cannot be typing — ignore stale channel echoes.
        if (isTyping) {
          final peerPresent = _onlinePeerIds.contains(userId) ||
              _realtime.isUserAppOnline(userId) ||
              _peerAppOnline;
          if (!peerPresent) return;
        }

        // Plain typing REST must not replace / clear recording / uploads.
        // Presence updates are authoritative for those activities.
        final ChatComposerActivity nextActivity;
        if (!isTyping) {
          if (!fromPresence && _isNonTypingComposerActivity(_peerActivity)) {
            return;
          }
          // Recording/sending just ended — block typing flashes until voice/images arrive.
          if (_isNonTypingComposerActivity(_peerActivity)) {
            _suppressPeerComposerActivityUntil =
                DateTime.now().add(const Duration(seconds: 3));
          }
          nextActivity = ChatComposerActivity.none;
        } else if (activity.isActive &&
            activity != ChatComposerActivity.typing) {
          nextActivity = activity;
        } else if (!fromPresence &&
            _isNonTypingComposerActivity(_peerActivity)) {
          return;
        } else if (!fromPresence && activity == ChatComposerActivity.typing) {
          // Generic typing REST while we were showing recording/sending, or
          // right after it — ignore (backend echoes is_typing without activity).
          if (_isNonTypingComposerActivity(_peerActivity) ||
              (_suppressPeerComposerActivityUntil != null &&
                  DateTime.now()
                      .isBefore(_suppressPeerComposerActivityUntil!))) {
            return;
          }
          nextActivity = ChatComposerActivity.typing;
        } else {
          nextActivity = ChatComposerActivity.typing;
        }

        final wasActive = _peerActivity.isActive;
        final wasTypingSound = _peerActivity.playsTypingSound;
        final activityUnchanged = nextActivity == _peerActivity;

        // Same activity again (heartbeats / duplicate REST) — only refresh the
        // idle timer. Emitting again rebuilds the typing row and looks like panic.
        if (activityUnchanged && nextActivity.isActive) {
          _armPeerActivityClear(nextActivity);
          _markPeerRecentlyActive(userId: userId);
          return;
        }

        _peerActivity = nextActivity;
        // Groups: use the active member's name. 1:1: peer display name.
        final isGroupChat = _chatType == ChatApiType.group ||
            _chatType == ChatApiType.socialGroup ||
            _chatType == ChatApiType.caseGroup;
        _peerTypingName = ChatComposerActivityLabels.firstNameOf(
          isGroupChat
              ? (userName ?? _peerDisplayName)
              : (_peerDisplayName ?? userName),
        );
        // Soft online while composing — Ably presence remains authoritative.
        if (nextActivity.isActive) {
          if (nextActivity.playsTypingSound && !wasTypingSound) {
            if (!_isCurrentChatMuted()) {
              ChatTypingSound.startPeerTypingClicks();
            }
          } else if (!nextActivity.playsTypingSound && wasTypingSound) {
            ChatTypingSound.stopPeerTypingClicks();
          }
          _markPeerRecentlyActive(userId: userId);
        } else if (wasActive) {
          ChatTypingSound.stopPeerTypingClicks();
          _recomputePeerOnline();
        }
        _emitLoaded();
        if (nextActivity.isActive) _armPeerActivityClear(nextActivity);
      case ChatPresenceChangedEvent(
          :final conversationId,
          :final userId,
          :final clientId,
          :final isOnline,
        ):
        if (!_isEventForThisChat(conversationId)) return;
        _applyPresence(
          userId: userId,
          clientId: clientId,
          isOnline: isOnline,
        );
      case ChatAppPresenceChangedEvent(:final userId, :final isOnline):
        final tracked = _trackedPeerUserId;
        if (tracked == null || userId != tracked) return;
        if (_peerAppOnline == isOnline) return;
        _peerAppOnline = isOnline;
        // App-offline must not instantly drop online while they're still
        // present in this conversation channel.
        _recomputePeerOnline();
      case ChatInboxUpdatedEvent(
          :final conversationId,
          :final contextId,
          :final chatType,
          :final senderId,
        ):
        // A peer's first message created the chat we have open without a
        // conversation yet — adopt it and go live.
        if (_conversationId != null || chatType != _chatType) return;
        final matches = contextId == _contextId ||
            (_chatType == ChatApiType.private && senderId == _contextId);
        if (!matches) return;
        _conversationId = conversationId;
        unawaited(loadMessages(refresh: true));
        unawaited(_connectRealtimeIfPossible());
    }
  }

  /// Peers refresh typing / recording about every 2.5 s while it lasts, so
  /// these only expire a missed "stopped". Uploads stay until the message
  /// lands or presence clears; the cap only guards a lost clear.
  void _armPeerActivityClear(ChatComposerActivity activity) {
    _peerTypingClearTimer?.cancel();
    final clearAfter = _isUploadComposerActivity(activity)
        ? const Duration(seconds: 60)
        : activity == ChatComposerActivity.recording
            ? const Duration(seconds: 6)
            : const Duration(seconds: 8);
    _peerTypingClearTimer = Timer(clearAfter, () {
      _clearPeerComposerActivity();
    });
  }

  void _markPeerRecentlyActive({int? userId}) {
    final tracked = _trackedPeerUserId;
    // Require a concrete peer id — null used to soft-online the header from
    // our own typing echoes and make a closed peer look active/typing.
    if (tracked != null) {
      if (userId == null || userId != tracked) return;
    } else if (userId == null || userId == _currentUserId) {
      return;
    }

    _softOnlineExpiry?.cancel();
    _peerOfflineDebounce?.cancel();
    _peerOfflineDebounce = null;
    if (!_peerIsOnline) {
      _peerIsOnline = true;
      _publishPeerOnlineLive();
      _emitLoaded();
    }
    // Fall back to Ably membership / app presence shortly after.
    _softOnlineExpiry = Timer(const Duration(seconds: 8), () {
      if (_isDisposing || isClosed) return;
      _recomputePeerOnline();
    });
  }

  void _applyPresence({
    required int? userId,
    required String? clientId,
    required bool isOnline,
  }) {
    final id = userId ?? int.tryParse(clientId ?? '');
    if (id == null) return;
    if (id == _currentUserId) return;

    final tracked = _trackedPeerUserId;
    // Private chat: accept the tracked peer. Also accept unknown ids when
    // clientId couldn't be parsed earlier but user_id matched later.
    if (tracked != null && id != tracked) {
      // Ignore other members in private channels.
      return;
    }

    if (isOnline) {
      _onlinePeerIds.add(id);
      // Device is in this chat channel — our sent messages are delivered.
      _upgradeOutgoingToAtLeast(ChatMessageStatus.delivered);
    } else {
      // Peer left the chat room — clear activity; app-online may still be true.
      _clearPeerComposerActivity();
      _onlinePeerIds.remove(id);
      // Conversation leave ≠ app offline. Only upgrade app-online from
      // realtime — never clear _peerAppOnline here (that greys the header
      // when opening a room while the peer is Online on Chats / presence:app).
      final trackedId = _trackedPeerUserId;
      if (trackedId != null && _realtime.isUserAppOnline(trackedId)) {
        _peerAppOnline = true;
      }
    }

    _recomputePeerOnline();
  }

  void _recomputePeerOnline() {
    final tracked = _trackedPeerUserId;
    // App-open is the source of truth (WhatsApp). Conversation membership
    // can only turn the header Online — never Offline by itself.
    if (tracked != null && _realtime.isUserAppOnline(tracked)) {
      _peerAppOnline = true;
    }
    final inConversation = tracked != null
        ? _onlinePeerIds.contains(tracked)
        : _onlinePeerIds.isNotEmpty;
    final next = _peerAppOnline || inConversation;
    if (next == _peerIsOnline) {
      if (next) _peerOfflineDebounce?.cancel();
      _publishPeerOnlineLive();
      return;
    }

    // Coming online — apply immediately.
    if (next) {
      _peerOfflineDebounce?.cancel();
      _peerOfflineDebounce = null;
      _peerIsOnline = true;
      _publishPeerOnlineLive();
      _emitLoaded();
      return;
    }

    // Going offline — only after app presence also says Offline.
    // Sending a message used to race a presence snapshot and flip the header.
    _peerOfflineDebounce?.cancel();
    _peerOfflineDebounce = Timer(const Duration(milliseconds: 1500), () {
      if (_isDisposing || isClosed) return;
      final trackedId = _trackedPeerUserId;
      if (trackedId != null && _realtime.isUserAppOnline(trackedId)) {
        _peerAppOnline = true;
      }
      final stillInConversation = trackedId != null
          ? _onlinePeerIds.contains(trackedId)
          : _onlinePeerIds.isNotEmpty;
      final stillOnline = _peerAppOnline || stillInConversation;
      if (!stillOnline && _peerIsOnline) {
        _peerIsOnline = false;
        _publishPeerOnlineLive();
        _emitLoaded();
      } else if (stillOnline && !_peerIsOnline) {
        _peerIsOnline = true;
        _publishPeerOnlineLive();
        _emitLoaded();
      }
    });
  }

  Future<void> loadMessages({bool refresh = true}) async {
    final contextId = _contextId;
    final chatType = _chatType;
    if (contextId == null || chatType == null) return;

    // Coalesce concurrent opens / resume refreshes into one request.
    final inFlight = _loadMessagesFuture;
    if (inFlight != null) {
      await inFlight;
      return;
    }

    final future = _loadMessagesBody(refresh: refresh);
    _loadMessagesFuture = future;
    try {
      await future;
    } finally {
      if (identical(_loadMessagesFuture, future)) {
        _loadMessagesFuture = null;
      }
    }
  }

  bool _isRateLimited(Failure failure) {
    final msg = failure.message.toLowerCase();
    return failure.code == 429 ||
        msg.contains('too many attempts') ||
        msg.contains('too many requests') ||
        msg.contains('throttle');
  }

  Future<void> _loadMessagesBody({required bool refresh}) async {
    final contextId = _contextId;
    final chatType = _chatType;
    if (contextId == null || chatType == null) return;

    final generation = ++_loadGeneration;

    if (refresh) {
      emit(const ChatRoomState.loading());
    }

    const maxAttempts = 3;
    Either<Failure, ChatMessagesListModelResponse>? result;
    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      result = await _repository.getMessages(
        contextId: contextId,
        chatType: chatType,
      );
      if (generation != _loadGeneration) return;

      final failure = result.fold((f) => f, (_) => null);
      if (failure == null) break;
      if (!_isRateLimited(failure) || attempt == maxAttempts) break;

      // Brief backoff so Laravel throttle windows can clear.
      await Future<void>.delayed(Duration(milliseconds: 700 * attempt));
      if (generation != _loadGeneration || _isDisposing || isClosed) return;
    }

    if (result == null || generation != _loadGeneration) return;

    await result.fold(
      (failure) async {
        _initialMessagesLoadDone = true;
        if (_messages.isNotEmpty) {
          _emitLoaded();
        } else {
          final message = _isRateLimited(failure)
              ? 'Too many requests. Please wait a moment and try again.'
              : failure.message;
          emit(ChatRoomState.error(message));
        }
      },
      (response) async {
        _conversationId = response.conversationId ?? _conversationId;
        _hasMore = response.hasMore ?? false;
        // Soft-reload (resume / media viewer pop) must keep local reactions —
        // GET messages often omits or lags the reactions array.
        _rawMessages = _seedDeliveryOnList(
          _mergeIncomingRawMessages(response.data ?? const []),
        );
        _rebuildMessageItems();
        await ChatPendingSendStore.instance.ensureLoaded();
        _restorePendingFromStore();
        _initialMessagesLoadDone = true;
        _emitLoaded();

        if (_conversationId != null) {
          await _repository.markDelivered(
            contextId: contextId,
            chatType: chatType,
          );
          await _connectRealtimeIfPossible();
        }
        unawaited(_flushPendingSends());
        unawaited(_loadConversationDetails());
      },
    );
  }

  Future<void> refreshConversationDetails() =>
      _loadConversationDetails(force: true);

  Future<void> _loadConversationDetails({bool force = false}) async {
    final contextId = _contextId;
    final chatType = _chatType;
    if (contextId == null || chatType == null) return;
    if (chatType != ChatApiType.group &&
        chatType != ChatApiType.socialGroup &&
        chatType != ChatApiType.caseGroup &&
        chatType != ChatApiType.private) {
      return;
    }

    // Ad-hoc groups are addressed by conversation id (may arrive after first
    // messages response). Prefer that when available.
    final addressId = chatType == ChatApiType.group
        ? (_conversationId ?? contextId)
        : contextId;

    if (!force &&
        _conversationDetailsLoadedFor == addressId &&
        _conversationDetailsLoadedChatType == chatType) {
      return;
    }

    final inFlight = _conversationDetailsFuture;
    if (inFlight != null) {
      await inFlight;
      if (_isDisposing || isClosed) return;
      if (!force &&
          _conversationDetailsLoadedFor == addressId &&
          _conversationDetailsLoadedChatType == chatType) {
        return;
      }
    }

    final future = _fetchConversationDetails(
      addressId: addressId,
      chatType: chatType,
    );
    _conversationDetailsFuture = future;
    try {
      await future;
    } finally {
      if (identical(_conversationDetailsFuture, future)) {
        _conversationDetailsFuture = null;
      }
    }
  }

  Future<void> _fetchConversationDetails({
    required int addressId,
    required String chatType,
  }) async {
    final result = await _repository.getConversation(
      contextId: addressId,
      chatType: chatType,
    );
    if (_isDisposing || isClosed) return;
    result.fold((_) {}, (response) {
      final data = response.data;
      if (data == null) return;
      _participants = List<ChatUserModel>.of(data.participants ?? const []);
      _myRole = data.myRole;
      _conversationId = data.id ?? _conversationId;
      if (data.name != null && data.name!.trim().isNotEmpty) {
        _peerDisplayName = data.name!.trim();
      }
      final image = _imageFromConversation(data);
      if (image != null) {
        _peerImageUrl = image;
      }
      _conversationDetailsLoadedFor = addressId;
      _conversationDetailsLoadedChatType = chatType;
      _rosterVersion++;
      // Roster may arrive after messages — seed Remaining rows + refresh ticks.
      _rawMessages = _seedDeliveryOnList(_rawMessages);
      _rebuildMessageItems();
      _emitLoaded();
    });
  }

  String? _imageFromConversation(ChatConversationModel data) {
    final direct = data.image?.trim();
    if (direct != null && direct.isNotEmpty) return direct;
    // Private DM: conversation.image may be empty — use the other participant.
    if (_chatType == ChatApiType.private) {
      for (final p in data.participants ?? const <ChatUserModel>[]) {
        if (p.id != null && p.id == _currentUserId) continue;
        final img = p.image?.trim();
        if (img != null && img.isNotEmpty) return img;
      }
    }
    return null;
  }

  Future<void> loadOlderMessages() async {
    if (_loadOlderFuture != null) {
      await _loadOlderFuture;
      return;
    }
    _loadOlderFuture = _doLoadOlderMessages();
    try {
      await _loadOlderFuture;
    } finally {
      _loadOlderFuture = null;
    }
  }

  Future<void> _doLoadOlderMessages() async {
    final contextId = _contextId;
    final chatType = _chatType;
    if (contextId == null ||
        chatType == null ||
        !_hasMore ||
        _rawMessages.isEmpty) {
      return;
    }

    final current = state;
    final alreadyLoading = current.maybeWhen(
      loaded: (_, __, ___, ____, isLoadingMore, _____, ______, ________,
              _________, __________, ___________, ____________) =>
          isLoadingMore,
      orElse: () => false,
    );
    if (alreadyLoading) return;

    final oldestId = _rawMessages.first.id;
    if (oldestId == null) return;

    _emitLoaded(isLoadingMore: true);

    final result = await _repository.getMessages(
      contextId: contextId,
      chatType: chatType,
      before: oldestId,
    );

    if (_isDisposing || isClosed) return;

    result.fold(
      (failure) => _emitLoaded(),
      (response) {
        _conversationId = response.conversationId ?? _conversationId;
        _hasMore = response.hasMore ?? false;
        final older = _seedDeliveryOnList(response.data ?? const []);
        _rawMessages = [...older, ..._rawMessages];
        _rebuildMessageItems();
        _emitLoaded();
      },
    );
  }

  /// Fetch older pages without rebuilding the list each page, then emit once.
  /// Used when jumping to a search / reply target that isn't loaded yet.
  Future<bool> ensureMessageLoaded(String messageId) async {
    if (_resolveLoadedMessageId(messageId) != null) return true;

    final contextId = _contextId;
    final chatType = _chatType;
    if (contextId == null || chatType == null) return false;

    if (_loadOlderFuture != null) {
      await _loadOlderFuture;
      if (_resolveLoadedMessageId(messageId) != null) return true;
    }

    if (!_hasMore || _rawMessages.isEmpty) {
      return _resolveLoadedMessageId(messageId) != null;
    }

    _emitLoaded(isLoadingMore: true);

    var attempts = 0;
    while (_hasMore && attempts < 40) {
      attempts++;
      final oldestId = _rawMessages.first.id;
      if (oldestId == null) break;

      final result = await _repository.getMessages(
        contextId: contextId,
        chatType: chatType,
        before: oldestId,
      );
      if (_isDisposing || isClosed) return false;

      var grew = false;
      result.fold(
        (_) {
          _hasMore = false;
        },
        (response) {
          _conversationId = response.conversationId ?? _conversationId;
          _hasMore = response.hasMore ?? false;
          final older = response.data ?? const [];
          if (older.isEmpty) {
            _hasMore = false;
            return;
          }
          _rawMessages = [...older, ..._rawMessages];
          grew = true;
        },
      );

      if (!grew) break;
      _rebuildMessageItems();
      if (_resolveLoadedMessageId(messageId) != null) {
        _emitLoaded();
        return true;
      }
    }

    _rebuildMessageItems();
    _emitLoaded();
    return _resolveLoadedMessageId(messageId) != null;
  }

  /// Resolves a chat message id from a message id, temp id, or attachment id.
  String? _resolveLoadedMessageId(String target) {
    final t = target.trim();
    if (t.isEmpty || t == '0') return null;
    for (final m in _messages) {
      if (m.id == t || m.clientTempId == t) return m.id;
      for (final a in m.attachments) {
        if (a.id != null && '${a.id}' == t) return m.id;
      }
    }
    for (final m in _rawMessages) {
      if (m.id != null && '${m.id}' == t) return '${m.id}';
      for (final a in m.attachments ?? const []) {
        if (a.id != null && '${a.id}' == t && m.id != null) return '${m.id}';
      }
    }
    return null;
  }

  /// Public helper for jump-to-message (media gallery may pass attachment ids).
  String? resolveMessageId(String target) => _resolveLoadedMessageId(target);

  void setReplyTo(ChatMessageItem message) {
    _editingMessage = null;
    _replyToMessage = message;
    _emitLoaded();
  }

  void clearReply() {
    _replyToMessage = null;
    _emitLoaded();
  }

  void setEditing(ChatMessageItem message) {
    if (!message.canEdit) return;
    _replyToMessage = null;
    _editingMessage = message;
    // Prefilling the composer must not show "is typing" to peers.
    _stopTyping(force: true);
    _emitLoaded();
  }

  void clearEditing() {
    _editingMessage = null;
    _stopTyping(force: true);
    _emitLoaded();
  }

  /// WhatsApp-style in-place edit. Returns an error string on failure.
  /// Path uses conversation_id (not context_id).
  Future<String?> editMessage(String content) async {
    final editing = _editingMessage;
    final conversationId = _conversationId;
    final chatType = _chatType;
    if (editing == null || conversationId == null || chatType == null) {
      return null;
    }
    final messageId = int.tryParse(editing.id);
    if (messageId == null) return null;

    final trimmed = content.trim();
    if (trimmed.isEmpty) return null;
    if (trimmed == editing.text.trim()) {
      _editingMessage = null;
      _stopTyping(force: true);
      _emitLoaded();
      return null;
    }

    final previousUi = editing;
    final rawIdx = _rawMessages.indexWhere((m) => m.id == messageId);
    final previousRaw = rawIdx >= 0 ? _rawMessages[rawIdx] : null;

    // Optimistic update.
    _messages = [
      for (final m in _messages)
        if (m.id == editing.id)
          m.copyWith(text: trimmed, isEdited: true)
        else
          m,
    ];
    if (rawIdx >= 0) {
      _rawMessages = [
        for (var i = 0; i < _rawMessages.length; i++)
          if (i == rawIdx)
            _rawMessages[i].copyWith(
              content: trimmed,
              isEdited: true,
              updatedAt: DateTime.now().toUtc().toIso8601String(),
            )
          else
            _rawMessages[i],
      ];
    }
    _editingMessage = null;
    // Programmatic clear of the input does not fire onChanged — stop typing
    // explicitly or the heartbeat keeps broadcasting forever.
    _stopTyping(force: true);
    _emitLoaded();

    final result = await _repository.editMessage(
      conversationId: conversationId,
      chatType: chatType,
      messageId: messageId,
      content: trimmed,
    );

    return result.fold(
      (failure) {
        debugPrint('Edit message failed: $failure');
        _messages = [
          for (final m in _messages)
            if (m.id == previousUi.id) previousUi else m,
        ];
        if (previousRaw != null && rawIdx >= 0) {
          _rawMessages = [
            for (var i = 0; i < _rawMessages.length; i++)
              if (i == rawIdx) previousRaw else _rawMessages[i],
          ];
        }
        _emitLoaded();
        return AppStrings.editMessageFailed;
      },
      (response) {
        final server = response.data;
        if (server != null && server.id != null) {
          final mapped = ChatMappers.toMessageItem(
            server,
            currentUserId: _currentUserId ?? 0,
            showAvatar: false,
            isGroupChat: _isGroupLikeChat,
            otherMembersCount: _otherMembersCount,
            messagesById: {
              for (final m in _rawMessages)
                if (m.id != null) m.id!: m,
              server.id!: server,
            },
          );
          // Keep local status ticks / attachments if server omits them.
          final idx = _messages.indexWhere((m) => m.id == '${server.id}');
          if (idx >= 0) {
            final prev = _messages[idx];
            _messages = [
              for (var i = 0; i < _messages.length; i++)
                if (i == idx)
                  mapped.copyWith(
                    status: prev.status,
                    attachments: mapped.attachments.isNotEmpty
                        ? mapped.attachments
                        : prev.attachments,
                    replyTo: mapped.replyTo ?? prev.replyTo,
                    isEdited: true,
                    reactionEmoji: prev.reactionEmoji,
                    reactions: prev.reactions,
                  )
                else
                  _messages[i],
            ];
          }
          final rIdx = _rawMessages.indexWhere((m) => m.id == server.id);
          if (rIdx >= 0) {
            _rawMessages = [
              for (var i = 0; i < _rawMessages.length; i++)
                if (i == rIdx) server else _rawMessages[i],
            ];
          } else {
            _rawMessages = [..._rawMessages, server];
          }
          _emitLoaded();
        }
        return null;
      },
    );
  }

  /// Update upload progress for a local optimistic message.
  void _updateUploadProgress(String tempId, double progress) {
    _messages = [
      for (final m in _messages)
        if (m.clientTempId == tempId)
          m.copyWith(uploadProgress: progress)
        else
          m,
    ];
    _emitLoaded();
  }

  /// Optimistic send: bubble appears immediately.
  /// Offline messages stay as [ChatMessageStatus.pending] and auto-send later.
  /// Failed messages stay in the list for tap-to-resend (no snackbar needed).
  Future<String?> sendMessage({
    String? text,
    List<File> images = const [],
    List<File> voices = const [],
    List<File> files = const [],
    int? voiceDurationMs,
  }) async {
    final contextId = _contextId;
    final chatType = _chatType;
    if (contextId == null || chatType == null) {
      return 'Chat is not ready yet. Please wait a moment.';
    }

    final trimmed = text?.trim() ?? '';
    final hasContent = trimmed.isNotEmpty;
    final hasAttachments =
        images.isNotEmpty || voices.isNotEmpty || files.isNotEmpty;
    if (!hasContent && !hasAttachments) return null;

    // Voice / attachments: kill recording heartbeat so peers don't keep
    // "is recording" after the bubble already appears.
    _typingStartDebounce?.cancel();
    _typingStopTimer?.cancel();
    _stopTyping(force: true);
    if (_localActivity != ChatComposerActivity.none) {
      _setLocalActivity(ChatComposerActivity.none);
    }

    final tempId = 'local_${DateTime.now().microsecondsSinceEpoch}';
    final previewText = hasContent
        ? trimmed
        : (images.isNotEmpty
            ? '[Image]'
            : voices.isNotEmpty
                ? '[Voice]'
                : '[File]');
    final previewCount = hasContent
        ? 1
        : (images.isNotEmpty
            ? images.length
            : files.isNotEmpty
                ? files.length
                : 1);

    final replyItem = _replyToMessage;
    final replyToId = replyItem != null ? int.tryParse(replyItem.id) : null;
    _replyToMessage = null;

    final voiceDurationsMs = voices.isEmpty
        ? const <int>[]
        : List<int>.generate(
            voices.length,
            (i) => i == 0 && voiceDurationMs != null && voiceDurationMs > 0
                ? voiceDurationMs
                : (voiceDurationMs ?? 0),
          );

    _pendingSends[tempId] = _PendingSendPayload(
      text: hasContent ? trimmed : null,
      images: List<File>.from(images),
      voices: List<File>.from(voices),
      files: List<File>.from(files),
      voiceDurationsMs: voiceDurationsMs,
      replyToId: replyToId,
    );

    // Build local attachment previews for images / voice / files.
    final localAttachments = <ChatAttachmentItem>[
      ...images.map((f) => ChatAttachmentItem(localFile: f, type: 'image')),
      for (var i = 0; i < voices.length; i++)
        ChatAttachmentItem(
          localFile: voices[i],
          type: 'voice',
          mimeType: 'audio/mp4',
          durationMs: i < voiceDurationsMs.length && voiceDurationsMs[i] > 0
              ? voiceDurationsMs[i]
              : null,
        ),
      ...files.map(
        (f) => ChatAttachmentItem(
          localFile: f,
          type: 'file',
          originalName: f.path.split(RegExp(r'[\\/]')).last,
        ),
      ),
    ];

    // Build reply-to item for the optimistic bubble.
    ChatReplyItem? replyToItem;
    if (replyItem != null && replyToId != null) {
      replyToItem = ChatReplyItem(
        id: replyToId,
        senderName: replyItem.isOutgoing
            ? 'You'
            : (replyItem.senderName.isNotEmpty
                ? replyItem.senderName
                : (_peerDisplayName ?? '')),
        text: replyItem.text,
        isOutgoing: replyItem.isOutgoing,
        imageAttachment: replyItem.firstImageAttachment,
        voiceAttachment: replyItem.firstVoiceAttachment,
        imageCount: replyItem.imageAttachmentCount,
      );
    }

    final now = DateTime.now();
    final timeLabel = ChatMappers.formatMessageTime(now.toIso8601String());
    // Show the bubble immediately — before network checks / upload.
    final optimistic = ChatMessageItem(
      id: tempId,
      text: previewText,
      timeLabel: timeLabel,
      createdAt: now,
      isOutgoing: true,
      status: ChatMessageStatus.sending,
      clientTempId: tempId,
      attachments: localAttachments,
      replyTo: replyToItem,
      uploadProgress: localAttachments.isNotEmpty ? 0.0 : null,
    );
    _messages = [..._messages, optimistic];
    _persistPendingEntry(
      tempId: tempId,
      previewText: previewText,
      timeLabel: timeLabel,
      status: ChatMessageStatus.sending,
      payload: _pendingSends[tempId]!,
    );
    _emitLoaded(isSending: true);

    final online = await _networkInfo.isConnected;
    if (!online) {
      _messages = [
        for (final m in _messages)
          if (m.clientTempId == tempId)
            m.copyWith(status: ChatMessageStatus.pending)
          else
            m,
      ];
      _updatePersistedStatus(tempId, ChatMessageStatus.pending);
      _emitLoaded(isSending: false);
      _notifyInboxPreview(previewText, previewCount: previewCount);
      return null;
    }

    // Upload in background so callers (voice send) aren't blocked.
    unawaited(_dispatchSend(tempId));
    return null;
  }

  /// Resend a pending/failed optimistic message (WhatsApp-style).
  /// Stamps the bubble with the current time and moves it to the latest slot.
  Future<void> resendMessage(String clientTempId) async {
    if (!_pendingSends.containsKey(clientTempId)) return;
    if (_inFlightTempIds.contains(clientTempId)) return;

    final now = DateTime.now();
    final timeLabel = ChatMappers.formatMessageTime(now.toIso8601String());

    ChatMessageItem? target;
    final others = <ChatMessageItem>[];
    for (final m in _messages) {
      if (m.clientTempId == clientTempId) {
        target = m;
      } else {
        others.add(m);
      }
    }
    if (target == null) return;

    final online = await _networkInfo.isConnected;
    if (!online) {
      _messages = [
        ...others,
        target.copyWith(
          status: ChatMessageStatus.pending,
          createdAt: now,
          timeLabel: timeLabel,
        ),
      ];
      _touchPersistedResend(
        clientTempId,
        status: ChatMessageStatus.pending,
        createdAt: now,
        timeLabel: timeLabel,
      );
      _emitLoaded();
      return;
    }

    _messages = [
      ...others,
      target.copyWith(
        status: ChatMessageStatus.sending,
        createdAt: now,
        timeLabel: timeLabel,
        uploadProgress:
            (target.hasImages || target.hasFiles || target.hasVoice)
                ? 0.0
                : null,
        clearUploadProgress:
            !(target.hasImages || target.hasFiles || target.hasVoice),
      ),
    ];
    _touchPersistedResend(
      clientTempId,
      status: ChatMessageStatus.sending,
      createdAt: now,
      timeLabel: timeLabel,
    );
    _emitLoaded(isSending: true);
    await _dispatchSend(clientTempId);
  }

  void _touchPersistedResend(
    String tempId, {
    required ChatMessageStatus status,
    required DateTime createdAt,
    required String timeLabel,
  }) {
    final contextId = _contextId;
    final chatType = _chatType;
    if (contextId == null || chatType == null) return;
    final entries = ChatPendingSendStore.instance.entriesFor(
      chatType: chatType,
      contextId: contextId,
    );
    for (final entry in entries) {
      if (entry.tempId != tempId) continue;
      ChatPendingSendStore.instance.save(
        chatType: chatType,
        contextId: contextId,
        entry: entry.copyWith(
          status: status,
          createdAt: createdAt,
          timeLabel: timeLabel,
        ),
      );
      break;
    }
  }

  /// Cancel an in-flight upload — keep the bubble + files so the user can
  /// tap retry later. Does not delete the local message.
  ///
  /// Also aborts the Dio request and arms an orphan watch so any message the
  /// server still accepts after abort is deleted for everyone.
  void cancelSend(String clientTempId) {
    if (clientTempId.isEmpty) return;
    _cancelledTempIds.add(clientTempId);
    _sendCancelTokens.remove(clientTempId)?.cancel('upload_cancelled');
    final payload = _pendingSends[clientTempId];
    if (payload != null && payload.hasAttachments) {
      _armCancelledSendWatch(clientTempId, payload);
    }
    // Keep in-flight markers until [_dispatchSend] finishes so a second
    // dispatch cannot start for the same temp id while the cancelled request
    // is still unwinding. Token cancel is enough to stop the upload.
    // Keep [_pendingSends] so [resendMessage] can retry the same files.
    _updatePersistedStatus(clientTempId, ChatMessageStatus.failed);
    _messages = [
      for (final m in _messages)
        if (m.clientTempId == clientTempId)
          m.copyWith(
            status: ChatMessageStatus.failed,
            clearUploadProgress: true,
          )
        else
          m,
    ];
    if (_isNonTypingComposerActivity(_localActivity)) {
      _setLocalActivity(ChatComposerActivity.none);
    }
    _emitLoaded();
  }

  /// Drop a local-only optimistic send (delete before a server id exists).
  void discardOptimisticSend(String clientTempId) {
    if (clientTempId.isEmpty) return;
    _cancelledTempIds.add(clientTempId);
    _sendCancelTokens.remove(clientTempId)?.cancel('upload_cancelled');
    final payload = _pendingSends[clientTempId];
    if (payload != null && payload.hasAttachments) {
      _armCancelledSendWatch(clientTempId, payload);
    }
    // Don't clear in-flight here — let [_dispatchSend] finish unwinding so a
    // late server accept can still be deleted via the cancel watch.
    _discardOptimisticSend(clientTempId);
    if (_isNonTypingComposerActivity(_localActivity)) {
      _setLocalActivity(ChatComposerActivity.none);
    }
    _emitLoaded();
  }

  void _discardOptimisticSend(String tempId) {
    _pendingSends.remove(tempId);
    _removePersisted(tempId);
    _messages = [
      for (final m in _messages)
        if (m.clientTempId != tempId) m,
    ];
  }

  void _markFailedForResume(String tempId) {
    _messages = [
      for (final m in _messages)
        if (m.clientTempId == tempId)
          m.copyWith(
            status: ChatMessageStatus.failed,
            clearUploadProgress: true,
          )
        else
          m,
    ];
    _updatePersistedStatus(tempId, ChatMessageStatus.failed);
  }

  void _armCancelledSendWatch(String tempId, _PendingSendPayload payload) {
    if (!payload.hasAttachments) return;
    _cancelledSendWatches[tempId] = _CancelledSendWatch(
      until: DateTime.now().add(const Duration(seconds: 25)),
      imageCount: payload.images.length,
      voiceCount: payload.voices.length,
      fileCount: payload.files.length,
      replyToId: payload.replyToId,
    );
  }

  /// Returns true when [message] matches a cancelled upload we still need to
  /// delete on the server (and claims that watch so we only delete once).
  bool _claimCancelledSendWatchForMessage(ChatMessageModel message) {
    _cancelledSendWatches.removeWhere((_, watch) => watch.isExpired);
    if (_cancelledSendWatches.isEmpty) return false;

    final attachments = message.attachments ?? const <ChatAttachmentModel>[];
    var imageCount = 0;
    var voiceCount = 0;
    var fileCount = 0;
    for (final a in attachments) {
      if (ChatMappers.isImageAttachment(a)) {
        imageCount++;
      } else if (ChatMappers.isVoiceAttachment(a)) {
        voiceCount++;
      } else if (ChatMappers.isFileAttachment(a)) {
        fileCount++;
      }
    }
    // Text-only cancels don't need orphan cleanup.
    if (imageCount == 0 && voiceCount == 0 && fileCount == 0) return false;

    final replyId = message.replyTo?.id;
    String? matchedTempId;
    for (final entry in _cancelledSendWatches.entries) {
      final watch = entry.value;
      if (watch.imageCount != imageCount) continue;
      if (watch.voiceCount != voiceCount) continue;
      if (watch.fileCount != fileCount) continue;
      // reply_to is often omitted on media payloads — only enforce when set.
      if (watch.replyToId != null && watch.replyToId != replyId) continue;
      matchedTempId = entry.key;
      break;
    }
    if (matchedTempId == null) return false;
    _cancelledSendWatches.remove(matchedTempId);
    return true;
  }

  /// Best-effort delete-for-everyone after a cancelled upload still created a
  /// server message. Keeps the local failed bubble for retry.
  Future<void> _deleteServerMessageForCancelledSend({
    required int messageId,
    int? conversationId,
  }) async {
    var cid = conversationId ?? _conversationId;
    for (var attempt = 0; attempt < 4; attempt++) {
      if (_isDisposing || isClosed) return;
      cid ??= _conversationId;
      if (cid == null) {
        await Future<void>.delayed(Duration(milliseconds: 350 * (attempt + 1)));
        continue;
      }
      final result = await _repository.deleteMessage(
        conversationId: cid,
        messageId: messageId,
        forEveryone: true,
      );
      final ok = result.fold((_) => false, _isDeleteEnvelopeOk);
      if (ok) {
        // Drop any server copy that slipped into local state; leave the
        // optimistic failed bubble (keyed by clientTempId) alone.
        final idStr = '$messageId';
        _rawMessages = [
          for (final m in _rawMessages)
            if (m.id != messageId) m,
        ];
        _messages = [
          for (final m in _messages)
            if (m.id != idStr)
              m
            else if (m.clientTempId != null && m.clientTempId!.isNotEmpty)
              m.copyWith(
                status: ChatMessageStatus.failed,
                clearUploadProgress: true,
              ),
        ];
        if (!_isDisposing && !isClosed) _emitLoaded();
        return;
      }
      await Future<void>.delayed(Duration(milliseconds: 400 * (attempt + 1)));
    }
  }

  Future<void> _flushPendingSends() async {
    if (_flushingPending) return;
    if (_pendingSends.isEmpty) return;
    if (!await _networkInfo.isConnected) return;

    _flushingPending = true;
    try {
      final ids = _pendingSends.keys.toList(growable: false);
      for (final tempId in ids) {
        if (!_pendingSends.containsKey(tempId)) continue;
        if (_inFlightTempIds.contains(tempId)) continue;
        if (ChatPendingSendStore.instance.isInFlight(tempId)) continue;

        final idx = _messages.indexWhere((m) => m.clientTempId == tempId);
        if (idx < 0) {
          _pendingSends.remove(tempId);
          continue;
        }

        // Auto-retry only pending (waiting for network). Failed needs user tap.
        if (_messages[idx].status != ChatMessageStatus.pending) continue;

        _messages = [
          for (final m in _messages)
            if (m.clientTempId == tempId)
              m.copyWith(status: ChatMessageStatus.sending)
            else
              m,
        ];
        _updatePersistedStatus(tempId, ChatMessageStatus.sending);
        _emitLoaded(isSending: true);
        await _dispatchSend(tempId);
      }
    } finally {
      _flushingPending = false;
    }
  }

  Future<void> _dispatchSend(String tempId) async {
    final contextId = _contextId;
    final chatType = _chatType;
    final payload = _pendingSends[tempId];
    if (contextId == null || chatType == null || payload == null) return;
    if (_inFlightTempIds.contains(tempId)) return;
    // Another chat-room instance may already be uploading this temp id.
    if (!ChatPendingSendStore.instance.tryMarkInFlight(tempId)) return;

    _inFlightTempIds.add(tempId);
    final cancelToken = CancelToken();
    _sendCancelTokens[tempId] = cancelToken;
    _cancelledTempIds.remove(tempId);
    _cancelledSendWatches.remove(tempId);

    try {
      final uploadActivity = payload.images.isNotEmpty
          ? ChatComposerActivity.sendingImagesForCount(payload.images.length)
          : payload.files.isNotEmpty
              ? ChatComposerActivity.sendingFilesForCount(payload.files.length)
              : ChatComposerActivity.none;
      if (uploadActivity.isActive) {
        // One-shot presence — do NOT heartbeat, or peers keep seeing
        // "sending images" after the message already arrived.
        _typingStopTimer?.cancel();
        _setLocalActivity(uploadActivity);
      }

      final previewText = () {
        final t = payload.text?.trim() ?? '';
        if (t.isNotEmpty) return t;
        if (payload.images.isNotEmpty) return '[Image]';
        if (payload.voices.isNotEmpty) return '[Voice]';
        return '[File]';
      }();
      final previewCount = () {
        final t = payload.text?.trim() ?? '';
        if (t.isNotEmpty) return 1;
        if (payload.images.isNotEmpty) return payload.images.length;
        if (payload.files.isNotEmpty) return payload.files.length;
        return 1;
      }();

      // Simulate upload progress for messages with attachments.
      final hasAttachments = payload.images.isNotEmpty ||
          payload.voices.isNotEmpty ||
          payload.files.isNotEmpty;
      if (hasAttachments) {
        _updateUploadProgress(tempId, 0.15);
      }

      if (_cancelledTempIds.contains(tempId) || cancelToken.isCancelled) {
        _armCancelledSendWatch(tempId, payload);
        _markFailedForResume(tempId);
        if (_isNonTypingComposerActivity(_localActivity) ||
            uploadActivity.isActive) {
          _setLocalActivity(ChatComposerActivity.none);
        }
        _emitLoaded();
        return;
      }

      final result = await _repository.sendMessage(
        contextId: contextId,
        chatType: chatType,
        content: payload.text,
        replyToId: payload.replyToId,
        images: payload.images,
        voices: payload.voices,
        voiceDurationsSeconds: _voiceDurationsSecondsForPayload(payload),
        files: payload.files,
        cancelToken: cancelToken,
      );

      final wasCancelled =
          _cancelledTempIds.remove(tempId) || cancelToken.isCancelled;

      // Clear media activity as soon as the upload finishes (success or fail),
      // before UI reconciliation — stops sticky "sending/recording" on peers.
      _typingStopTimer?.cancel();
      if (_isNonTypingComposerActivity(_localActivity) ||
          uploadActivity.isActive) {
        _setLocalActivity(ChatComposerActivity.none);
      }

      if (wasCancelled) {
        // Never treat a cancelled upload as delivered — even if the HTTP
        // response already came back. Delete the server copy when we have an
        // id; otherwise watch realtime for the orphan and delete it there.
        int? serverMessageId;
        int? serverConversationId;
        result.fold((_) {}, (response) {
          if (response.value != false && response.data != null) {
            serverMessageId = response.data!.id;
            serverConversationId = response.data!.conversationId;
          }
        });
        if (serverMessageId != null) {
          _cancelledSendWatches.remove(tempId);
          if (serverConversationId != null) {
            _conversationId ??= serverConversationId;
          }
          unawaited(
            _deleteServerMessageForCancelledSend(
              messageId: serverMessageId!,
              conversationId: serverConversationId ?? _conversationId,
            ),
          );
        } else {
          _armCancelledSendWatch(tempId, payload);
        }
        _markFailedForResume(tempId);
        _emitLoaded();
        return;
      }

      if (hasAttachments) {
        _updateUploadProgress(tempId, 1.0);
      }

      result.fold(
        (failure) {
          if (wasCancelled ||
              _cancelledTempIds.contains(tempId) ||
              cancelToken.isCancelled) {
            _armCancelledSendWatch(tempId, payload);
            _markFailedForResume(tempId);
            _emitLoaded();
            return;
          }
          if (ChatBlockService.isRecipientUnavailableFailure(failure)) {
            _recipientUnavailable = true;
          }
          _messages = [
            for (final m in _messages)
              if (m.clientTempId == tempId)
                m.copyWith(
                  status: ChatMessageStatus.failed,
                  clearUploadProgress: true,
                )
              else
                m,
          ];
          _updatePersistedStatus(tempId, ChatMessageStatus.failed);
          _emitLoaded();
        },
        (response) {
          if (!wasCancelled &&
              (_cancelledTempIds.contains(tempId) || cancelToken.isCancelled)) {
            _markFailedForResume(tempId);
            _emitLoaded();
            return;
          }
          if (response.value == false) {
            _messages = [
              for (final m in _messages)
                if (m.clientTempId == tempId)
                  m.copyWith(
                    status: ChatMessageStatus.failed,
                    clearUploadProgress: true,
                  )
                else
                  m,
            ];
            _updatePersistedStatus(tempId, ChatMessageStatus.failed);
            _emitLoaded();
            return;
          }

          _pendingSends.remove(tempId);
          _removePersisted(tempId);
          final rawMessage = response.data;
          final wasNewConversation = _conversationId == null;
          if (rawMessage != null) {
            final message = _seedDeliveryRoster(rawMessage);
            _conversationId = message.conversationId ?? _conversationId;
            // First image/file in a brand-new chat: conversation id only exists
            // after send — re-clear presence so peers don't keep "sending images".
            if (wasNewConversation &&
                uploadActivity.isActive &&
                _conversationId != null) {
              unawaited(
                _realtime.updateComposerActivity(
                  conversationId: _conversationId!,
                  activity: ChatComposerActivity.none,
                ),
              );
            } else if (uploadActivity.isActive && _conversationId != null) {
              // Second presence clear in case the first update was dropped.
              unawaited(
                Future<void>.delayed(const Duration(milliseconds: 250), () {
                  if (_isDisposing || _conversationId == null) return;
                  unawaited(
                    _realtime.updateComposerActivity(
                      conversationId: _conversationId!,
                      activity: ChatComposerActivity.none,
                    ),
                  );
                }),
              );
            }
            var mapped = ChatMappers.toMessageItem(
              message,
              currentUserId: _currentUserId ?? 0,
              showAvatar: false,
              isGroupChat: _isGroupLikeChat,
              otherMembersCount: _otherMembersCount,
              messagesById: {
                for (final m in _rawMessages)
                  if (m.id != null) m.id!: m,
                if (message.id != null) message.id!: message,
              },
            ).copyWith(
              status: _statusFromSendResponse(message.status),
              clientTempId: tempId,
            );

            final idx = _messages.indexWhere((m) => m.clientTempId == tempId);
            if (idx >= 0) {
              final previous = _messages[idx];
              // Keep the full local name if the API only returns first name.
              final previousReply = previous.replyTo;
              final nextReply = mapped.replyTo;
              if (previousReply != null &&
                  nextReply != null &&
                  previousReply.senderName.trim().length >
                      nextReply.senderName.trim().length) {
                mapped = mapped.copyWith(
                  replyTo: ChatReplyItem(
                    id: nextReply.id,
                    senderName: previousReply.senderName,
                    text: nextReply.text.isNotEmpty
                        ? nextReply.text
                        : previousReply.text,
                    isOutgoing: nextReply.isOutgoing,
                    imageAttachment: nextReply.imageAttachment ??
                        previousReply.imageAttachment,
                    voiceAttachment: nextReply.voiceAttachment ??
                        previousReply.voiceAttachment,
                    imageCount: nextReply.imageCount > 0
                        ? nextReply.imageCount
                        : previousReply.imageCount,
                  ),
                );
              } else if (previousReply != null &&
                  nextReply != null &&
                  ((previousReply.imageAttachment != null &&
                          nextReply.imageAttachment == null) ||
                      (previousReply.voiceAttachment != null &&
                          nextReply.voiceAttachment == null) ||
                      (previousReply.imageCount > nextReply.imageCount))) {
                mapped = mapped.copyWith(
                  replyTo: ChatReplyItem(
                    id: nextReply.id,
                    senderName: nextReply.senderName.isNotEmpty
                        ? nextReply.senderName
                        : previousReply.senderName,
                    text: nextReply.text.isNotEmpty
                        ? nextReply.text
                        : previousReply.text,
                    isOutgoing: nextReply.isOutgoing,
                    imageAttachment: nextReply.imageAttachment ??
                        previousReply.imageAttachment,
                    voiceAttachment: nextReply.voiceAttachment ??
                        previousReply.voiceAttachment,
                    imageCount: nextReply.imageCount > 0
                        ? nextReply.imageCount
                        : previousReply.imageCount,
                  ),
                );
              }
              // Keep local file previews so images/voice keep working until
              // network URLs are ready (and after signed URL swaps).
              if (previous.attachments.isNotEmpty) {
                mapped = mapped.copyWith(
                  attachments: _mergeLocalAttachments(
                    previous.attachments,
                    mapped.attachments,
                  ),
                  uploadProgress: null,
                );
              }
              _messages = [
                for (var i = 0; i < _messages.length; i++)
                  if (i == idx) mapped else _messages[i],
              ];
            } else if (!_rawMessages.any((m) => m.id == message.id)) {
              _messages = [..._messages, mapped];
            }

            if (!_rawMessages.any((m) => m.id == message.id)) {
              _rawMessages = [..._rawMessages, message];
            }

            _notifyInboxPreview(
              previewText,
              previewCount: previewCount,
              messageId: message.id,
            );
            // Peer already has this conversation channel open → delivered.
            if (_peerIsInThisConversation() &&
                mapped.status == ChatMessageStatus.sent) {
              _upgradeOutgoingToAtLeast(ChatMessageStatus.delivered);
            }
            // Case/patient chats auto-add members on create — refresh roster
            // so the header subtitle under the patient name stays current.
            if (_chatType == ChatApiType.caseGroup) {
              final now = DateTime.now();
              final due = _lastCaseRosterRefresh == null ||
                  now.difference(_lastCaseRosterRefresh!) >
                      const Duration(seconds: 5);
              if (due || wasNewConversation) {
                _lastCaseRosterRefresh = now;
                unawaited(refreshConversationDetails());
              }
            }
          } else {
            _messages = [
              for (final m in _messages)
                if (m.clientTempId == tempId)
                  m.copyWith(status: ChatMessageStatus.sent)
                else
                  m,
            ];
            loadMessages(refresh: false);
          }

          _emitLoaded();
          if (wasNewConversation ||
              _realtime.subscribedConversationId != _conversationId) {
            unawaited(_connectRealtimeIfPossible());
          }
          if (wasNewConversation && _conversationId != null) {
            try {
              if (GetIt.I.isRegistered<InboxCubit>()) {
                unawaited(
                  GetIt.I<InboxCubit>().silentRefresh(
                    bypassThrottle: true,
                  ),
                );
              }
            } catch (_) {}
          }
        },
      );
    } finally {
      _inFlightTempIds.remove(tempId);
      _sendCancelTokens.remove(tempId);
      ChatPendingSendStore.instance.clearInFlight(tempId);
    }
  }

  void _notifyInboxPreview(
    String preview, {
    int? previewCount,
    int? messageId,
  }) {
    try {
      if (!GetIt.I.isRegistered<InboxCubit>()) return;
      final inbox = GetIt.I<InboxCubit>();
      final contextId = _contextId;
      final chatType = _chatType;
      if (contextId == null || chatType == null) return;
      inbox.applyOutgoingPreview(
        chatType: chatType,
        contextId: contextId,
        conversationId: _conversationId,
        preview: preview,
        previewCount: previewCount,
        messageId: messageId,
      );
    } catch (_) {}
  }

  /// Typing: while the composer has text, keep broadcasting typing=true
  /// (light heartbeat). Stop only when the field is cleared or a message is sent.
  void onComposerChanged(String text) {
    final contextId = _contextId;
    final chatType = _chatType;
    if (contextId == null || chatType == null) return;

    // Editing an existing message is not "typing a new message".
    if (_editingMessage != null) {
      _typingStartDebounce?.cancel();
      _typingStopTimer?.cancel();
      if (_localActivity == ChatComposerActivity.typing) {
        _setLocalActivity(ChatComposerActivity.none);
      }
      return;
    }

    // Recording / uploads own the activity channel — don't override with typing.
    if (_localActivity == ChatComposerActivity.recording ||
        _localActivity == ChatComposerActivity.sendingImage ||
        _localActivity == ChatComposerActivity.sendingImages ||
        _localActivity == ChatComposerActivity.sendingFile ||
        _localActivity == ChatComposerActivity.sendingFiles) {
      return;
    }

    final hasContent = text.trim().isNotEmpty;
    _typingStartDebounce?.cancel();

    if (!hasContent) {
      _typingStopTimer?.cancel();
      _setLocalActivity(ChatComposerActivity.none);
      return;
    }

    if (_localActivity != ChatComposerActivity.typing) {
      _typingStopTimer?.cancel();
      _typingStartDebounce = Timer(const Duration(milliseconds: 350), () {
        _setLocalActivity(ChatComposerActivity.typing);
        _scheduleTypingHeartbeat();
      });
      return;
    }

    // Still has content — keep the keep-alive running. Restarting it on
    // every keystroke meant it never fired while typing fast, so the peer's
    // "typing" expired mid-sentence.
    if (!(_typingStopTimer?.isActive ?? false)) _scheduleTypingHeartbeat();
  }

  void onRecordingChanged(bool isRecording) {
    _typingStartDebounce?.cancel();
    _typingStopTimer?.cancel();
    if (isRecording) {
      _setLocalActivity(ChatComposerActivity.recording);
      _scheduleTypingHeartbeat();
    } else {
      // Always clear via presence only — never touch typing REST here.
      if (_localActivity == ChatComposerActivity.recording ||
          _isNonTypingComposerActivity(_localActivity)) {
        _setLocalActivity(ChatComposerActivity.none);
      } else if (_localActivity == ChatComposerActivity.none) {
        _broadcastLocalActivity(
          ChatComposerActivity.none,
          previous: ChatComposerActivity.recording,
        );
      }
    }
  }

  void _scheduleTypingHeartbeat() {
    _typingStopTimer?.cancel();
    // Presence-only heartbeat while text remains — do not re-hit typing REST
    // (backends often echo start/stop and make the peer indicator flicker).
    _typingStopTimer = Timer(const Duration(milliseconds: 2500), () {
      if (!_localActivity.isActive) return;
      if (_isUploadComposerActivity(_localActivity)) return;
      final conversationId = _conversationId;
      if (conversationId != null) {
        unawaited(
          _realtime.updateComposerActivity(
            conversationId: conversationId,
            activity: _localActivity,
          ),
        );
      }
      _scheduleTypingHeartbeat();
    });
  }

  void _setLocalActivity(ChatComposerActivity activity) {
    if (_localActivity == activity) {
      if (activity.isActive) {
        _broadcastLocalActivity(activity, previous: activity);
      }
      return;
    }
    final previous = _localActivity;
    _localActivity = activity;
    if (!activity.isActive) {
      _typingStopTimer?.cancel();
    }
    _broadcastLocalActivity(activity, previous: previous);
  }

  void _broadcastLocalActivity(
    ChatComposerActivity activity, {
    ChatComposerActivity? previous,
  }) {
    final conversationId = _conversationId;
    if (conversationId == null) return;

    // Presence-only for typing / recording / uploads. Avoid POST .../typing —
    // Laravel rebroadcasts that as user.typing on Ably, so peers got the same
    // state twice and every REST hit loaded the API for no gain.
    unawaited(
      _realtime.updateComposerActivity(
        conversationId: conversationId,
        activity: activity,
      ),
    );
  }

  void _stopTyping({bool force = false}) {
    _typingStartDebounce?.cancel();
    _typingStopTimer?.cancel();
    if (!_localActivity.isActive && !force) return;
    if (_localActivity == ChatComposerActivity.none) return;
    _setLocalActivity(ChatComposerActivity.none);
  }

  ChatMessageModel _applyReactionEvent({
    required ChatMessageModel message,
    required int? userId,
    required String? emoji,
    required String? action,
  }) {
    final trimmed = emoji?.trim();
    if (trimmed == null || trimmed.isEmpty) return message;

    final isRemove = (action ?? '').toLowerCase().contains('remove') ||
        (action ?? '').toLowerCase() == 'deleted' ||
        (action ?? '').toLowerCase() == 'delete';

    final existing = List<ChatReactionModel>.from(
      message.reactions ?? const <ChatReactionModel>[],
    );

    if (isRemove) {
      // Only drop this emoji — do not wipe a newer reaction the user just
      // switched to (change 👍 → 😂 emits remove for 👍 after 😂 is applied).
      for (var i = 0; i < existing.length; i++) {
        if (existing[i].emoji?.trim() != trimmed) continue;
        final users = List<ChatUserModel>.from(existing[i].users ?? const []);
        final before = users.length;
        users.removeWhere((u) => userId != null && u.id == userId);
        if (users.length != before) {
          existing[i] = existing[i].copyWith(
            users: users,
            count: users.isEmpty ? 0 : (existing[i].count ?? users.length) - 1,
          );
        }
      }
      existing.removeWhere(
        (r) => (r.count ?? 0) <= 0 && (r.users?.isEmpty ?? true),
      );
      return message.copyWith(reactions: existing);
    }

    // Add / change: one reaction per user — leave other emojis, then join this.
    for (var i = 0; i < existing.length; i++) {
      final users = List<ChatUserModel>.from(existing[i].users ?? const []);
      final before = users.length;
      users.removeWhere((u) => userId != null && u.id == userId);
      if (users.length != before) {
        existing[i] = existing[i].copyWith(
          users: users,
          count: users.isEmpty ? 0 : (existing[i].count ?? users.length) - 1,
        );
      }
    }
    existing.removeWhere(
      (r) => (r.count ?? 0) <= 0 && (r.users?.isEmpty ?? true),
    );

    final groupIdx = existing.indexWhere((r) => r.emoji?.trim() == trimmed);
    if (groupIdx >= 0) {
      final users = List<ChatUserModel>.from(
        existing[groupIdx].users ?? const [],
      );
      if (userId == null || !users.any((u) => u.id == userId)) {
        users.add(
          ChatUserModel(
            id: userId,
            name:
                userId == _currentUserId ? _myDisplayName : _peerDisplayName,
          ),
        );
        // Update counts in place — keep list order (matches API).
        existing[groupIdx] = existing[groupIdx].copyWith(
          users: users,
          count: (existing[groupIdx].count ?? 0) + 1,
        );
      }
    } else {
      // API puts newest at the top of the list → insert at index 0.
      existing.insert(
        0,
        ChatReactionModel(
          emoji: trimmed,
          count: 1,
          users: [
            ChatUserModel(
              id: userId,
              name: userId == _currentUserId
                  ? _myDisplayName
                  : _peerDisplayName,
            ),
          ],
        ),
      );
    }

    return message.copyWith(reactions: existing);
  }

  /// Prefer server order (newest-first). Keep any optimistic order for emojis
  /// the server already has; prepend brand-new types at the top.
  List<ChatReactionModel> _mergeReactionsKeepOrder({
    List<ChatReactionModel>? previous,
    required List<ChatReactionModel> server,
  }) {
    // Server list is authoritative and already newest-first — use it so
    // re-entering the chat matches what you see after reacting.
    if (previous == null || previous.isEmpty) return server;

    final serverEmojis = <String>{
      for (final r in server)
        if (r.emoji?.trim().isNotEmpty == true) r.emoji!.trim(),
    };
    final prevEmojis = <String>{
      for (final r in previous)
        if (r.emoji?.trim().isNotEmpty == true) r.emoji!.trim(),
    };

    final myId = _currentUserId;
    String? prevMine;
    if (myId != null) {
      for (final r in previous) {
        if ((r.users ?? const []).any((u) => u.id == myId)) {
          prevMine = r.emoji?.trim();
          if (prevMine != null && prevMine.isEmpty) prevMine = null;
          break;
        }
      }
    }

    // Same set of emoji types → take server order, but never drop *my*
    // membership when GET lags behind an optimistic toggle.
    if (serverEmojis.length == prevEmojis.length &&
        serverEmojis.containsAll(prevEmojis)) {
      if (prevMine == null) return server;
      final serverHasMine = server.any(
        (r) =>
            r.emoji?.trim() == prevMine &&
            (r.users ?? const []).any((u) => u.id == myId),
      );
      if (serverHasMine) return server;
      return _applyReactionEvent(
            message: ChatMessageModel(reactions: server),
            userId: myId,
            emoji: prevMine,
            action: 'add',
          ).reactions ??
          server;
    }

    // New type appeared optimistically — keep current order, sync payloads.
    final byEmoji = <String, ChatReactionModel>{
      for (final r in server)
        if (r.emoji?.trim().isNotEmpty == true) r.emoji!.trim(): r,
    };
    final out = <ChatReactionModel>[];
    final seen = <String>{};
    for (final r in previous) {
      final e = r.emoji?.trim();
      if (e == null || e.isEmpty) continue;
      final s = byEmoji[e];
      if (s == null) {
        // Keep my optimistic group when the soft-reload/toggle payload lags.
        final mineHere = myId != null &&
            (r.users ?? const []).any((u) => u.id == myId);
        if (!mineHere) continue;
        out.add(r);
        seen.add(e);
        continue;
      }
      // Prefer server counts/users but keep me if server omitted me on this
      // emoji while previous still had me (stale GET during 👍→😂).
      final serverHasMe = myId != null &&
          (s.users ?? const []).any((u) => u.id == myId);
      final prevHasMe = myId != null &&
          (r.users ?? const []).any((u) => u.id == myId);
      if (prevHasMe && !serverHasMe) {
        out.add(r);
      } else {
        out.add(s);
      }
      seen.add(e);
    }
    for (final r in server) {
      final e = r.emoji?.trim();
      if (e == null || e.isEmpty || seen.contains(e)) continue;
      out.insert(0, r);
      seen.add(e);
    }
    return out;
  }

  void _holdLocalReaction(int messageId, String? emoji) {
    _localReactionHolds[messageId] = _LocalReactionHold(
      emoji: emoji?.trim().isEmpty == true ? null : emoji?.trim(),
      // Long enough to cover image-viewer open + slow GET catch-up.
      until: DateTime.now().add(const Duration(seconds: 45)),
    );
  }

  void _clearLocalReactionHold(int messageId) {
    _localReactionHolds.remove(messageId);
  }

  /// Soft-reload merge: keep local reactions when GET messages omits/lags them.
  List<ChatMessageModel> _mergeIncomingRawMessages(
    List<ChatMessageModel> incoming,
  ) {
    if (incoming.isEmpty) return incoming;
    if (_rawMessages.isEmpty && _localReactionHolds.isEmpty) return incoming;

    final prevById = <int, ChatMessageModel>{
      for (final m in _rawMessages)
        if (m.id != null) m.id!: m,
    };

    return [
      for (final next in incoming) _mergeIncomingRawMessage(prevById, next),
    ];
  }

  ChatMessageModel _mergeIncomingRawMessage(
    Map<int, ChatMessageModel> prevById,
    ChatMessageModel next,
  ) {
    final id = next.id;
    if (id == null) return next;

    final previous = prevById[id];
    final hold = _localReactionHolds[id];

    var merged = next;
    final nextRx = next.reactions;
    final prevRx = previous?.reactions;
    final prevMine = previous == null ? null : _myReactionEmoji(previous);

    if ((nextRx == null || nextRx.isEmpty) &&
        prevRx != null &&
        prevRx.isNotEmpty) {
      merged = merged.copyWith(reactions: prevRx);
    } else if (prevRx != null && prevRx.isNotEmpty && nextRx != null) {
      merged = merged.copyWith(
        reactions: _mergeReactionsKeepOrder(
          previous: prevRx,
          server: nextRx,
        ),
      );
    }

    // Active local toggle wins over a lagging GET payload.
    if (hold != null && hold.isActive) {
      final held = hold.emoji;
      final mine = _myReactionEmoji(merged);
      if (held == null) {
        if (mine != null) {
          merged = _applyReactionEvent(
            message: merged,
            userId: _currentUserId,
            emoji: mine,
            action: 'remove',
          );
        }
      } else if (mine != held) {
        merged = _applyReactionEvent(
          message: merged,
          userId: _currentUserId,
          emoji: held,
          action: 'add',
        );
      }
    } else if (hold != null && !hold.isActive) {
      _clearLocalReactionHold(id);
      // Hold expired but GET still missing my reaction — keep what we showed.
      final mine = _myReactionEmoji(merged);
      if (prevMine != null && mine == null) {
        merged = _applyReactionEvent(
          message: merged,
          userId: _currentUserId,
          emoji: prevMine,
          action: 'add',
        );
      }
    } else if (prevMine != null && _myReactionEmoji(merged) == null) {
      // No hold, but soft-reload dropped my badge — restore it.
      merged = _applyReactionEvent(
        message: merged,
        userId: _currentUserId,
        emoji: prevMine,
        action: 'add',
      );
    }

    return merged;
  }

  Future<void> toggleReaction({
    required int messageId,
    required String emoji,
  }) async {
    final conversationId = _conversationId;
    if (conversationId == null) return;

    final trimmedEmoji = emoji.trim();
    if (trimmedEmoji.isEmpty) return;

    // Optimistic local update so the badge appears immediately.
    final idx = _rawMessages.indexWhere((m) => m.id == messageId);
    var removing = false;
    if (idx >= 0) {
      final current = _rawMessages[idx];
      final myPreviousEmoji = _myReactionEmoji(current);
      removing = myPreviousEmoji == trimmedEmoji;
      _holdLocalReaction(messageId, removing ? null : trimmedEmoji);
      final optimistic = _applyReactionEvent(
        message: current,
        userId: _currentUserId,
        emoji: trimmedEmoji,
        // Same emoji → remove; different / none → set (replaces previous).
        action: removing ? 'remove' : 'add',
      );
      _rawMessages = [
        for (var i = 0; i < _rawMessages.length; i++)
          if (i == idx) optimistic else _rawMessages[i],
      ];
      _rebuildMessageItems();
      _emitLoaded();
    } else {
      _holdLocalReaction(messageId, trimmedEmoji);
    }

    final result = await _repository.toggleReaction(
      conversationId: conversationId,
      messageId: messageId,
      reaction: trimmedEmoji,
    );

    result.fold(
      (failure) {
        _clearLocalReactionHold(messageId);
        // Revert by reloading message list reactions from last known server
        // state is hard; soft-refresh messages instead.
        loadMessages(refresh: false);
      },
      (response) {
        final serverIdx = _rawMessages.indexWhere((m) => m.id == messageId);
        if (serverIdx == -1) return;
        if (response.data?.reactions != null) {
          final previous = _rawMessages[serverIdx];
          var serverReactions = response.data!.reactions!;
          // Changing A→B: a stale toggle response may omit B. Keep the
          // optimistic change instead of flashing back to empty.
          if (!removing) {
            final hasMine = serverReactions.any(
              (r) =>
                  r.emoji?.trim() == trimmedEmoji &&
                  (r.users ?? const [])
                      .any((u) => u.id == _currentUserId),
            );
            if (!hasMine) {
              serverReactions = _applyReactionEvent(
                message: previous.copyWith(reactions: serverReactions),
                userId: _currentUserId,
                emoji: trimmedEmoji,
                action: 'add',
              ).reactions ??
                  serverReactions;
            }
          } else if (removing) {
            // Confirm removal even if the payload still lists my old emoji.
            final stillMine = serverReactions.any(
              (r) =>
                  r.emoji?.trim() == trimmedEmoji &&
                  (r.users ?? const [])
                      .any((u) => u.id == _currentUserId),
            );
            if (stillMine) {
              serverReactions = _applyReactionEvent(
                message: previous.copyWith(reactions: serverReactions),
                userId: _currentUserId,
                emoji: trimmedEmoji,
                action: 'remove',
              ).reactions ??
                  serverReactions;
            }
          }
          // When removing, trust the patched server list — merging with the
          // pre-remove optimistic row can resurrect my emoji via keep-order.
          final merged = removing
              ? serverReactions
              : _mergeReactionsKeepOrder(
                  previous: previous.reactions,
                  server: serverReactions,
                );
          // Refresh hold so a follow-up soft-reload still respects this toggle.
          _holdLocalReaction(messageId, removing ? null : trimmedEmoji);
          if (_reactionsEqual(previous.reactions, merged)) return;
          final updated = previous.copyWith(reactions: merged);
          _rawMessages = [
            for (var i = 0; i < _rawMessages.length; i++)
              if (i == serverIdx) updated else _rawMessages[i],
          ];
          _rebuildMessageItems();
          _emitLoaded();
        } else if (removing) {
          // Empty/omitted reactions payload after remove — keep optimistic clear.
          _holdLocalReaction(messageId, null);
        }
      },
    );
  }

  String? _myReactionEmoji(ChatMessageModel message) {
    final userId = _currentUserId;
    if (userId == null) return null;
    for (final r in message.reactions ?? const <ChatReactionModel>[]) {
      if ((r.users ?? const []).any((u) => u.id == userId)) {
        final e = r.emoji?.trim();
        if (e != null && e.isNotEmpty) return e;
      }
    }
    return null;
  }

  String? _myReactionEmojiFromItem(ChatMessageItem message) {
    final userId = _currentUserId;
    if (userId == null) return null;
    for (final g in message.reactions) {
      if (g.users.any((u) => u.id == userId)) {
        final e = g.emoji.trim();
        if (e.isNotEmpty) return e;
      }
    }
    final fallback = message.reactionEmoji?.trim();
    if (fallback != null && fallback.isNotEmpty) return fallback;
    return null;
  }

  bool _reactionsEqual(
    List<ChatReactionModel>? a,
    List<ChatReactionModel>? b,
  ) {
    final left = a ?? const <ChatReactionModel>[];
    final right = b ?? const <ChatReactionModel>[];
    if (identical(left, right)) return true;
    if (left.length != right.length) return false;
    for (var i = 0; i < left.length; i++) {
      final l = left[i];
      final r = right[i];
      if (l.emoji?.trim() != r.emoji?.trim() ||
          (l.count ?? 0) != (r.count ?? 0)) {
        return false;
      }
      final lu = l.users ?? const <ChatUserModel>[];
      final ru = r.users ?? const <ChatUserModel>[];
      if (lu.length != ru.length) return false;
      for (var j = 0; j < lu.length; j++) {
        if (lu[j].id != ru[j].id) return false;
      }
    }
    return true;
  }

  /// Removes a message from this user's timeline (delete-for-me).
  void _removeMessageLocally(int messageId) {
    final idStr = '$messageId';
    _rawMessages = [
      for (final m in _rawMessages)
        if (m.id != messageId) m,
    ];
    _messages = [
      for (final m in _messages)
        if (m.id != idStr) m,
    ];
    _emitLoaded();
  }

  /// Delete for everyone (ours or a peer's): keep the bubble as the same
  /// tombstone a reload shows. The server keeps `content` set on these, and
  /// only delete-for-me rows come back with `content: null`.
  void _markMessageDeletedLocally(int messageId) {
    final idStr = '$messageId';
    final uiIdx = _messages.indexWhere((m) => m.id == idStr);
    final rawIdx = _rawMessages.indexWhere((m) => m.id == messageId);

    if (rawIdx >= 0) {
      final raw = _rawMessages[rawIdx];
      if (raw.isDeleted != true) {
        _rawMessages = [
          for (var i = 0; i < _rawMessages.length; i++)
            if (i == rawIdx)
              raw.copyWith(
                isDeleted: true,
                content: ChatMappers.deletedForEveryoneContent,
                attachments: const [],
                reactions: const [],
                replyTo: null,
              )
            else
              _rawMessages[i],
        ];
      }
    }

    if (uiIdx >= 0) {
      final current = _messages[uiIdx];
      if (!current.isDeleted) {
        _messages = [
          for (var i = 0; i < _messages.length; i++)
            if (i == uiIdx)
              current.copyWith(
                isDeleted: true,
                isDeleting: false,
                attachments: const [],
                clearReaction: true,
                clearReplyTo: true,
                clearUploadProgress: true,
              )
            else
              _messages[i],
        ];
      }
    } else if (rawIdx >= 0) {
      _rebuildMessageItems();
    }
    _emitLoaded();
  }

  static bool _isDeleteEnvelopeOk(ChatEnvelopeModel response) =>
      response.value != false;

  /// Restores the pre-delete bubble when the API rejects the delete.
  void _restoreMessageAfterFailedDelete({
    required int messageId,
    required ChatMessageItem previousUi,
    ChatMessageModel? previousRaw,
    int? rawIdx,
  }) {
    final idStr = '$messageId';
    if (previousRaw != null) {
      final existingIdx = _rawMessages.indexWhere((m) => m.id == messageId);
      if (existingIdx >= 0) {
        _rawMessages = [
          for (var i = 0; i < _rawMessages.length; i++)
            if (i == existingIdx) previousRaw else _rawMessages[i],
        ];
      } else {
        final insertRaw =
            (rawIdx ?? _rawMessages.length).clamp(0, _rawMessages.length);
        _rawMessages = [
          ..._rawMessages.take(insertRaw),
          previousRaw,
          ..._rawMessages.skip(insertRaw),
        ];
      }
    }

    final uiIdx = _messages.indexWhere((m) => m.id == idStr);
    final restored = previousUi.copyWith(isDeleting: false, isDeleted: false);
    if (uiIdx >= 0) {
      _messages = [
        for (var i = 0; i < _messages.length; i++)
          if (i == uiIdx) restored else _messages[i],
      ];
    } else {
      _messages = [..._messages, restored];
    }
    _emitLoaded();
  }

  /// Returns `false` when the server rejected the delete (local state rolled back).
  ///
  /// Own messages → delete for everyone + WhatsApp soft-delete placeholder.
  /// Others' messages → delete for me only + hide from this user's timeline.
  Future<bool> deleteMessage(int messageId) async {
    final idStr = '$messageId';
    final idx = _messages.indexWhere((m) => m.id == idStr);
    if (idx < 0) return true;
    if (_messages[idx].isDeleted || _messages[idx].isDeleting) return true;

    final previousUi = _messages[idx];
    final forEveryone = previousUi.isOutgoing;
    final rawIdx = _rawMessages.indexWhere((m) => m.id == messageId);
    final previousRaw = rawIdx >= 0 ? _rawMessages[rawIdx] : null;

    // Phase 1 — fold live bubble while the delete request runs.
    _messages = [
      for (final m in _messages)
        if (m.id == idStr) m.copyWith(isDeleting: true) else m,
    ];
    _emitLoaded();

    final conversationId = _conversationId;
    final apiFuture = conversationId == null
        ? null
        : _repository.deleteMessage(
            conversationId: conversationId,
            messageId: messageId,
            forEveryone: forEveryone,
          );

    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (_isDisposing || isClosed) return false;

    if (apiFuture == null) {
      if (forEveryone) {
        _markMessageDeletedLocally(messageId);
      } else {
        _removeMessageLocally(messageId);
      }
      return true;
    }

    final result = await apiFuture;
    if (_isDisposing || isClosed) return false;

    return result.fold(
      (failure) {
        debugPrint('Delete message failed: $failure');
        _restoreMessageAfterFailedDelete(
          messageId: messageId,
          previousUi: previousUi,
          previousRaw: previousRaw,
          rawIdx: rawIdx >= 0 ? rawIdx : null,
        );
        return false;
      },
      (response) {
        if (!_isDeleteEnvelopeOk(response)) {
          debugPrint('Delete message rejected: ${response.message}');
          _restoreMessageAfterFailedDelete(
            messageId: messageId,
            previousUi: previousUi,
            previousRaw: previousRaw,
            rawIdx: rawIdx >= 0 ? rawIdx : null,
          );
          return false;
        }
        if (forEveryone) {
          _markMessageDeletedLocally(messageId);
        } else {
          _removeMessageLocally(messageId);
        }
        return true;
      },
    );
  }

  /// Deletes many messages; each uses for-everyone or for-me based on ownership.
  Future<bool> deleteMessages(List<int> messageIds) async {
    final unique = <int>[];
    final seen = <int>{};
    for (final id in messageIds) {
      if (!seen.add(id)) continue;
      final idStr = '$id';
      final idx = _messages.indexWhere((m) => m.id == idStr);
      if (idx < 0) continue;
      if (_messages[idx].isDeleted || _messages[idx].isDeleting) continue;
      unique.add(id);
    }
    if (unique.isEmpty) return true;

    final snapshots = <int, ChatMessageItem>{
      for (final id in unique) id: _messages.firstWhere((m) => m.id == '$id'),
    };
    final rawSnapshots = <int, ChatMessageModel>{};
    final rawIndexes = <int, int>{};
    for (final id in unique) {
      final rawIdx = _rawMessages.indexWhere((m) => m.id == id);
      if (rawIdx >= 0) {
        rawSnapshots[id] = _rawMessages[rawIdx];
        rawIndexes[id] = rawIdx;
      }
    }

    _messages = [
      for (final m in _messages)
        if (unique.contains(int.tryParse(m.id)))
          m.copyWith(isDeleting: true)
        else
          m,
    ];
    _emitLoaded();

    final own = [
      for (final id in unique)
        if (snapshots[id]?.isOutgoing ?? false) id,
    ];
    final others = [
      for (final id in unique)
        if (!(snapshots[id]?.isOutgoing ?? false)) id,
    ];

    final conversationId = _conversationId;
    // Own messages: one bulk request per 100 ids. Others': delete for me.
    final bulkFutures =
        <List<int>, Future<Either<Failure, ChatEnvelopeModel>>>{};
    final mineFutures = <int, Future<Either<Failure, ChatEnvelopeModel>>>{};
    if (conversationId != null) {
      for (var i = 0; i < own.length; i += _bulkDeleteMax) {
        final chunk = own.sublist(
          i,
          i + _bulkDeleteMax > own.length ? own.length : i + _bulkDeleteMax,
        );
        bulkFutures[chunk] = _repository.deleteMessagesForEveryone(
          conversationId: conversationId,
          messageIds: chunk,
        );
      }
      for (final id in others) {
        mineFutures[id] = _repository.deleteMessage(
          conversationId: conversationId,
          messageId: id,
        );
      }
    }

    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (_isDisposing || isClosed) return false;

    if (conversationId == null) {
      own.forEach(_markMessageDeletedLocally);
      others.forEach(_removeMessageLocally);
      return true;
    }

    var anyFailed = false;
    void restore(int id) {
      anyFailed = true;
      final previousUi = snapshots[id];
      if (previousUi == null) return;
      _restoreMessageAfterFailedDelete(
        messageId: id,
        previousUi: previousUi,
        previousRaw: rawSnapshots[id],
        rawIdx: rawIndexes[id],
      );
    }

    for (final entry in bulkFutures.entries) {
      final result = await entry.value;
      if (_isDisposing || isClosed) return false;
      final deleted = result.fold(
        (failure) {
          debugPrint('Bulk delete failed: $failure');
          return const <int>{};
        },
        (response) => _bulkDeletedIds(response, requested: entry.key),
      );
      for (final id in entry.key) {
        if (deleted.contains(id)) {
          _markMessageDeletedLocally(id);
        } else {
          restore(id);
        }
      }
    }

    for (final entry in mineFutures.entries) {
      final result = await entry.value;
      if (_isDisposing || isClosed) return false;
      final ok = result.fold(
        (failure) {
          debugPrint('Delete message failed: $failure');
          return false;
        },
        (response) {
          if (_isDeleteEnvelopeOk(response)) return true;
          debugPrint('Delete message rejected: ${response.message}');
          return false;
        },
      );
      if (ok) {
        _removeMessageLocally(entry.key);
      } else {
        restore(entry.key);
      }
    }
    return !anyFailed;
  }

  static const _bulkDeleteMax = 100;

  /// Ids the server confirmed from `{ "deleted": [...], "skipped": [...] }`.
  /// Skipped ids come back to the chat and the caller shows an error.
  static Set<int> _bulkDeletedIds(
    ChatEnvelopeModel response, {
    required List<int> requested,
  }) {
    if (!_isDeleteEnvelopeOk(response)) {
      debugPrint('Bulk delete rejected: ${response.message}');
      return const <int>{};
    }
    final data = response.data;
    if (data is! Map) return requested.toSet();
    final deleted = data['deleted'];
    if (deleted is List) {
      final skipped = data['skipped'];
      if (skipped is List && skipped.isNotEmpty) {
        debugPrint('Bulk delete skipped: $skipped');
      }
      return {
        for (final raw in deleted)
          if (int.tryParse('$raw') != null) int.parse('$raw'),
      };
    }
    return requested.toSet();
  }

  int? messageIdAt(int index) {
    if (index < 0 || index >= _messages.length) return null;
    return int.tryParse(_messages[index].id);
  }

  /// Prefer first name for activity labels (typing / recording / sending).
  static bool _isNonTypingComposerActivity(ChatComposerActivity activity) {
    return activity == ChatComposerActivity.recording ||
        _isUploadComposerActivity(activity);
  }

  static bool _isUploadComposerActivity(ChatComposerActivity activity) {
    return activity.isUpload;
  }

  /// API expects whole seconds per voice file (`voice_durations[]=15`).
  static List<int> _voiceDurationsSecondsForPayload(
      _PendingSendPayload payload) {
    if (payload.voices.isEmpty) return const [];
    return List<int>.generate(payload.voices.length, (i) {
      final ms = i < payload.voiceDurationsMs.length
          ? payload.voiceDurationsMs[i]
          : (payload.voiceDurationsMs.isNotEmpty
              ? payload.voiceDurationsMs.first
              : 0);
      if (ms <= 0) return 0;
      final seconds = (ms / 1000).round();
      return seconds < 1 ? 1 : seconds;
    });
  }

  void _clearPeerComposerActivity() {
    _peerTypingClearTimer?.cancel();
    if (!_peerActivity.isActive) {
      _recomputePeerOnline();
      return;
    }
    _peerActivity = ChatComposerActivity.none;
    ChatTypingSound.stopPeerTypingClicks();
    _recomputePeerOnline();
    _emitLoaded();
  }

  bool _isCurrentChatMuted() {
    final key = ChatMutePrefs.keyFor(
      conversationId: _conversationId,
      chatType: _chatType,
      contextId: _contextId,
    );
    return ChatMutePrefs.isMuted(key);
  }

  Future<void> _playIncomingSoundIfUnmuted({int? conversationId}) async {
    await ChatMutePrefs.ensureLoaded();
    final key = ChatMutePrefs.keyFor(
      conversationId: conversationId ?? _conversationId,
      chatType: _chatType,
      contextId: _contextId,
    );
    if (ChatMutePrefs.isMuted(key)) return;
    await ChatIncomingSound.play();
  }

  /// Prefer server URLs but keep local files for instant preview/playback.
  List<ChatAttachmentItem> _mergeLocalAttachments(
    List<ChatAttachmentItem> local,
    List<ChatAttachmentItem> remote,
  ) {
    if (remote.isEmpty) return local;
    return [
      for (var i = 0; i < remote.length; i++)
        ChatAttachmentItem(
          id: remote[i].id ?? (i < local.length ? local[i].id : null),
          url: remote[i].url,
          localFile: (i < local.length ? local[i].localFile : null) ??
              remote[i].localFile,
          mimeType: remote[i].mimeType ??
              (i < local.length ? local[i].mimeType : null),
          originalName: remote[i].originalName ??
              (i < local.length ? local[i].originalName : null),
          type: remote[i].type.isNotEmpty
              ? remote[i].type
              : (i < local.length ? local[i].type : 'file'),
          durationMs: remote[i].durationMs ??
              (i < local.length ? local[i].durationMs : null),
        ),
    ];
  }

  /// Optimistic local system notice after renaming the group.
  void insertLocalSystemMessage(String text) {
    final label = text.trim();
    if (label.isEmpty || _isDisposing || isClosed) return;
    final now = DateTime.now();
    final id = 'local-system-${now.microsecondsSinceEpoch}';
    _messages = [
      ..._messages,
      ChatMessageItem(
        id: id,
        text: label,
        timeLabel: '',
        createdAt: now,
        isOutgoing: false,
        isSystem: true,
      ),
    ];
    _emitLoaded();
    unawaited(loadMessages(refresh: false));
  }

  /// Re-fetch messages so signed attachment URLs are minted again.
  /// Throttled — OpenAPI: links expire in ~30 minutes; re-read the message.
  DateTime? _lastSignedUrlRefresh;

  Future<void> refreshSignedAttachmentUrls() async {
    final now = DateTime.now();
    if (_lastSignedUrlRefresh != null &&
        now.difference(_lastSignedUrlRefresh!) < const Duration(seconds: 8)) {
      return;
    }
    _lastSignedUrlRefresh = now;
    await loadMessages(refresh: false);
  }

  /// Backend clears unread / advances to seen when messages are fetched.
  void _scheduleMarkConversationReadOnServer() {
    if (_isDisposing) return;
    _markReadDebounce?.cancel();
    _markReadDebounce = Timer(const Duration(milliseconds: 400), () {
      if (_isDisposing) return;
      unawaited(_markConversationReadOnServer());
    });
  }

  Future<void> _markConversationReadOnServer() async {
    final contextId = _contextId;
    final chatType = _chatType;
    if (contextId == null || chatType == null) return;
    // Side-effect only: getMessages marks the thread as read/seen server-side.
    await _repository.getMessages(
      contextId: contextId,
      chatType: chatType,
    );
  }

  @override
  Future<void> close() async {
    // Stop treating this chat as open immediately — otherwise messages that
    // arrive while we're back on Chats get marked read via realtime handlers.
    _isDisposing = true;
    final ownConversationId = _conversationId;
    // Clear viewing flag BEFORE async teardown so new sends aren't treated
    // as seen while we leave an archived (or normal) chat room. Only our own
    // chat — another room may be open on top of this one.
    if (ownConversationId != null) {
      _realtime.clearActiveChat(conversationId: ownConversationId);
    }
    _typingStartDebounce?.cancel();
    _typingStopTimer?.cancel();
    _peerTypingClearTimer?.cancel();
    _peerOfflineDebounce?.cancel();
    _softOnlineExpiry?.cancel();
    _markReadDebounce?.cancel();
    ChatTypingSound.stopPeerTypingClicks();
    if (_localActivity.isActive) {
      _setLocalActivity(ChatComposerActivity.none);
    }
    _stopTyping(force: true);
    await _connectivitySub?.cancel();
    await _realtimeSub?.cancel();
    _realtimeSub = null;
    peerIsOnlineLive.dispose();
    // Do NOT call getMessages here: that would mark messages that arrived
    // after leaving as seen on the server.
    if (ownConversationId != null) {
      await _realtime.unsubscribe(conversationId: ownConversationId);
    }
    return super.close();
  }
}
