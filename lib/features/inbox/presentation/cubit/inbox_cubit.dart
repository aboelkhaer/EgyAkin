import 'package:egy_akin/features/chat/data/mappers/chat_mappers.dart';
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat/data/models/chat_composer_activity.dart';
import 'package:egy_akin/features/chat/data/services/chat_archive_prefs.dart';
import 'package:egy_akin/features/chat/data/services/chat_incoming_sound.dart';
import 'package:egy_akin/features/chat/data/services/chat_mute_prefs.dart';
import 'package:egy_akin/features/chat/data/services/chat_realtime_service.dart';
import 'package:egy_akin/features/chat_room/domain/repositories/chat_room_repo.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/inbox/data/models/get_inbox_model_response.dart';
import 'package:egy_akin/features/inbox/data/models/inbox_thread.dart';
import 'package:egy_akin/features/inbox/domain/usecases/get_inbox_usecase.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_state.dart';

import '../../../../exports.dart';

class InboxCubit extends Cubit<InboxState> {
  InboxCubit(this._getInboxUsecase, this._realtime, this._chatRoomRepository)
      : super(const InboxState.initial()) {
    _realtimeSub = _realtime.events.listen(_onRealtimeEvent);
  }

  final GetInboxUsecase _getInboxUsecase;
  final ChatRealtimeService _realtime;
  final ChatRoomRepository _chatRoomRepository;

  InboxFilter _filter = InboxFilter.all;
  InboxCountsModel? _counts;
  Map<String, String> _filterTitles = const {};
  Map<String, String> _sectionTitles = const {};
  List<InboxThread> _threads = [];

  /// API `meta.total` for the current filter (all pages).
  int? _totalCount;

  /// Live archived list (same realtime overlays as the main chats list).
  List<InboxThread> _archivedThreads = [];
  final ValueNotifier<int> archivedRevision = ValueNotifier<int>(0);
  bool _archivedScreenActive = false;
  int _currentPage = 1;
  bool _isLastPage = false;
  bool _isLoadingMore = false;
  bool _isRefreshing = false;
  bool _hasLoadedOnce = false;

  /// Page-1 inbox request already running — drop duplicate opens.
  bool _inboxPageRequestInFlight = false;
  DateTime? _lastRefreshTime;
  int? _currentUserId;
  String? _myDisplayName;
  String? _myImageUrl;
  StreamSubscription<ChatRealtimeEvent>? _realtimeSub;

  /// Timers that auto-clear typing indicators if no heartbeat arrives.
  final Map<int, Timer> _typingClearTimers = {};

  /// After a message lands, ignore stale recording/sending presence briefly.
  final Map<int, DateTime> _suppressMediaActivityUntil = {};

  /// Presence members currently in a conversation channel (excluding self).
  final Map<int, Set<int>> _onlineByConversation = {};

  /// App-wide online user ids (any screen), from `presence:app`.
  final Set<int> _appOnlineUserIds = {};

  /// Avoid double-counting the same Ably `message.sent` (archived badge +2).
  final Set<int> _handledIncomingMessageIds = {};

  /// Conversations that must stay on Ably (just sent / waiting for ✓✓ / seen).
  /// Without this, the 20-channel cap drops them and receipts never arrive.
  final List<int> _priorityRealtimeConversationIds = [];

  /// Last unread count we already POSTed `receipts/delivered` for.
  /// Key: `chatType:contextId`. Prevents Home open from re-acking forever.
  final Map<String, int> _deliveredAckUnreadByKey = {};

  Timer? _ackDeliveredDebounce;
  bool _ackDeliveredInFlight = false;

  static InboxCubit get(context) => BlocProvider.of<InboxCubit>(context);

  InboxCountsModel? get counts => _counts;

  /// Archived threads with live presence / typing (for the archived screen).
  List<InboxThread> get archivedThreads => List.unmodifiable(_archivedThreads);

  int countFor(InboxFilter filter) =>
      ChatMappers.countForFilter(_counts, filter);

  /// Localized filter chip title from API (`filter_titles`), else fallback.
  String filterTitleFor(InboxFilter filter, String fallback) {
    final key = ChatMappers.inboxFilterParam(filter);
    final fromApi = _filterTitles[key]?.trim();
    if (fromApi != null && fromApi.isNotEmpty) return fromApi;
    // Legacy API keys for the same buckets.
    if (filter == InboxFilter.doctors) {
      for (final alt in ['doctors', 'people']) {
        final t = _filterTitles[alt]?.trim();
        if (t != null && t.isNotEmpty) return t;
      }
    } else if (filter == InboxFilter.groups) {
      for (final alt in ['groups', 'group']) {
        final t = _filterTitles[alt]?.trim();
        if (t != null && t.isNotEmpty) return t;
      }
    } else if (filter == InboxFilter.socialGroups) {
      for (final alt in ['social_groups', 'social_group']) {
        final t = _filterTitles[alt]?.trim();
        if (t != null && t.isNotEmpty) return t;
      }
    }
    return fallback;
  }

  /// Section header from API (`section_titles`), else fallback.
  String sectionTitleFor(String key, String fallback) {
    final fromApi = _sectionTitles[key]?.trim();
    if (fromApi != null && fromApi.isNotEmpty) return fromApi;
    return fallback;
  }

  Map<String, String> get filterTitles => Map.unmodifiable(_filterTitles);
  Map<String, String> get sectionTitles => Map.unmodifiable(_sectionTitles);

  void _applyInboxMeta(InboxDataModel? data) {
    if (data == null) return;
    if (data.counts != null) {
      _counts = _mergeInboxCounts(_counts, data.counts!);
    }
    // Keep the active tab badge in sync with the list total.
    final total = data.meta?.total;
    if (total != null) {
      _counts = _countsWithFilterTotal(
        _counts ?? const InboxCountsModel(),
        _filter,
        total,
      );
    }
    final titles = data.filterTitles;
    if (titles != null && titles.isNotEmpty) {
      _filterTitles = {
        for (final e in titles.entries)
          if (e.key.trim().isNotEmpty && e.value.trim().isNotEmpty)
            e.key.trim().toLowerCase(): e.value.trim(),
      };
    }
    final sections = data.sectionTitles;
    if (sections != null && sections.isNotEmpty) {
      _sectionTitles = {
        for (final e in sections.entries)
          if (e.key.trim().isNotEmpty && e.value.trim().isNotEmpty)
            e.key.trim().toLowerCase(): e.value.trim(),
      };
    }
  }

  InboxCountsModel _mergeInboxCounts(
    InboxCountsModel? previous,
    InboxCountsModel next,
  ) {
    if (previous == null) return next;
    return InboxCountsModel(
      all: next.all ?? previous.all,
      doctors: next.doctors ?? previous.doctors,
      people: next.people ?? previous.people,
      patients: next.patients ?? previous.patients,
      groups: next.groups ?? previous.groups,
      socialGroups: next.socialGroups ?? previous.socialGroups,
      consults: next.consults ?? previous.consults,
    );
  }

  InboxCountsModel _countsWithFilterTotal(
    InboxCountsModel counts,
    InboxFilter filter,
    int total,
  ) {
    switch (filter) {
      case InboxFilter.all:
        return counts.copyWith(all: total);
      case InboxFilter.doctors:
        return counts.copyWith(doctors: total);
      case InboxFilter.patients:
        return counts.copyWith(patients: total);
      case InboxFilter.groups:
        return counts.copyWith(groups: total);
      case InboxFilter.socialGroups:
        return counts.copyWith(socialGroups: total);
      case InboxFilter.consults:
        return counts.copyWith(consults: total);
    }
  }

  /// User ids currently shown as online in the inbox (app + conversation).
  Set<int> get onlineCounterpartUserIds {
    final ids = <int>{
      ..._appOnlineUserIds,
      ..._realtime.appOnlineUserIds,
    };
    for (final thread in _threads) {
      final peerId = _presencePeerUserId(thread);
      if (thread.isOnline && peerId != null) {
        ids.add(peerId);
      }
    }
    return ids;
  }

  /// Load inbox only on the very first call for this signed-in user.
  /// If the account changes, previous threads are wiped before loading.
  void initIfNeeded({required int currentUserId}) {
    if (_hasLoadedOnce && _currentUserId == currentUserId) return;
    if (_hasLoadedOnce &&
        _currentUserId != null &&
        _currentUserId != currentUserId) {
      clearForSignOut(disconnectRealtime: false);
    }
    _hasLoadedOnce = true;
    _currentUserId = currentUserId;
    unawaited(ChatArchivePrefs.ensureLoaded());
    // Prefetch so the Archived row can hide/show correctly on the main list.
    unawaited(loadArchivedThreads());
    loadInbox(refresh: true, currentUserId: currentUserId);
  }

  /// Wipe in-memory inbox/archive state so the next account never sees it.
  void clearForSignOut({bool disconnectRealtime = true}) {
    for (final timer in _typingClearTimers.values) {
      timer.cancel();
    }
    _typingClearTimers.clear();
    _suppressMediaActivityUntil.clear();
    _onlineByConversation.clear();
    _appOnlineUserIds.clear();
    _handledIncomingMessageIds.clear();
    _priorityRealtimeConversationIds.clear();
    _deliveredAckUnreadByKey.clear();
    _ackDeliveredDebounce?.cancel();
    _ackDeliveredDebounce = null;
    _ackDeliveredInFlight = false;

    _filter = InboxFilter.all;
    _counts = null;
    _filterTitles = const {};
    _sectionTitles = const {};
    _threads = [];
    _archivedThreads = [];
    _totalCount = null;
    _currentPage = 1;
    _isLastPage = false;
    _isLoadingMore = false;
    _isRefreshing = false;
    _hasLoadedOnce = false;
    _lastRefreshTime = null;
    _inboxPageRequestInFlight = false;
    _currentUserId = null;
    _myDisplayName = null;
    _myImageUrl = null;
    _archivedScreenActive = false;

    if (!isClosed) {
      emit(const InboxState.initial());
    }
    _notifyArchived();

    if (disconnectRealtime) {
      unawaited(_realtime.disconnect());
    }
  }

  void startLiveUpdates({
    required int currentUserId,
    String? displayName,
    String? imageUrl,
  }) {
    _currentUserId = currentUserId;
    if (displayName != null) _myDisplayName = displayName;
    if (imageUrl != null) _myImageUrl = imageUrl;
    // Enter once when needed; otherwise soft update + snapshot (WhatsApp:
    // stay Online while app is open — do not re-enter storms).
    final needEnter = !_realtime.hasEnteredAppPresence;
    unawaited(() async {
      await _realtime.ensureAppPresence(
        currentUserId: currentUserId,
        displayName: displayName ?? _myDisplayName,
        imageUrl: imageUrl ?? _myImageUrl,
        forceReenter: needEnter,
      );
      await _realtime.refreshAppPresenceSnapshot();
      if (isClosed) return;
      _reapplyAppOnlineToThreads();
      await _syncRealtimeChannels(currentUserId);
      await _realtime.refreshAppPresenceSnapshot();
      if (isClosed) return;
      _reapplyAppOnlineToThreads();
      // Catch late Ably sync without waiting minutes.
      for (final delayMs in [400, 1200]) {
        await Future<void>.delayed(Duration(milliseconds: delayMs));
        if (isClosed) return;
        await _realtime.refreshAppPresenceSnapshot();
        if (isClosed) return;
        _reapplyAppOnlineToThreads();
      }
    }());
    // Resume: only ack threads whose unread grew since the last POST.
    // Debounced + snapshot-gated so Home open does not spam receipts/delivered.
    _scheduleAckUnreadDelivered();
    // Catch up ticks only after the list has been idle. Cold start already
    // fetches once via initIfNeeded — do not fire a second inbox request.
    if (!_hasLoadedOnce || _inboxPageRequestInFlight) return;
    final now = DateTime.now();
    if (_lastRefreshTime != null &&
        now.difference(_lastRefreshTime!) < const Duration(seconds: 8)) {
      return;
    }
    unawaited(silentRefresh(currentUserId: currentUserId));
  }

  void stopLiveUpdates() {
    // No-op — realtime stays connected while the cubit is alive so you
    // remain online across Home / Chats / other tabs.
  }

  /// App returned to foreground — re-publish Online and refresh inbox dots
  /// without requiring pull-to-refresh.
  Future<void> onAppForegrounded({
    required int currentUserId,
    String? displayName,
    String? imageUrl,
  }) async {
    _currentUserId = currentUserId;
    if (displayName != null) _myDisplayName = displayName;
    if (imageUrl != null) _myImageUrl = imageUrl;
    try {
      await _realtime.onAppResumed(
        currentUserId: currentUserId,
        displayName: displayName ?? _myDisplayName,
        imageUrl: imageUrl ?? _myImageUrl,
      );
    } catch (e) {
      debugPrint('Inbox onAppForegrounded resume failed: $e');
    }
    try {
      await _realtime.ensureAppPresence(
        currentUserId: currentUserId,
        displayName: displayName ?? _myDisplayName,
        imageUrl: imageUrl ?? _myImageUrl,
        forceReenter: true,
      );
      await _realtime.refreshAppPresenceSnapshot();
    } catch (e) {
      debugPrint('Inbox onAppForegrounded presence failed: $e');
    }
    if (isClosed) return;
    _reapplyAppOnlineToThreads();
    unawaited(_syncRealtimeChannels(currentUserId));
  }

  /// Keep archived conversation channels subscribed while that screen is open.
  void setArchivedScreenActive(bool active) {
    _archivedScreenActive = active;
    final uid = _currentUserId;
    if (uid == null) return;
    unawaited(_syncRealtimeChannels(uid));
  }

  void _notifyArchived() {
    archivedRevision.value++;
  }

  /// Cap Ably channel fan-out — attaching every conversation OOMs Simulator.
  static const int _maxInboxRealtimeChannels = 24;

  void _pinRealtimeConversation(int? conversationId) {
    if (conversationId == null) return;
    _priorityRealtimeConversationIds.remove(conversationId);
    _priorityRealtimeConversationIds.insert(0, conversationId);
    while (_priorityRealtimeConversationIds.length > 12) {
      _priorityRealtimeConversationIds.removeLast();
    }
    final uid = _currentUserId;
    if (uid != null) {
      unawaited(_syncRealtimeChannels(uid));
    }
  }

  /// Subscribe to conversation channels for inbox (presence + messages).
  /// Priority: open chat → recently sent / pending receipts → unread chats →
  /// unread archived → other chats → other archived.
  /// Archived must stay subscribed even when that screen is closed, or peers
  /// never get `message.sent` and never ack delivered (sender stuck on ✓).
  Future<void> _syncRealtimeChannels(int currentUserId) async {
    final wanted = <int>{};
    final activeId = _realtime.subscribedConversationId;
    if (activeId != null) wanted.add(activeId);

    void addId(int? id) {
      if (id == null) return;
      if (wanted.length >= _maxInboxRealtimeChannels) return;
      wanted.add(id);
    }

    void addFrom(Iterable<InboxThread> threads) {
      for (final t in threads) {
        if (wanted.length >= _maxInboxRealtimeChannels) return;
        addId(t.conversationId);
      }
    }

    for (final id in _priorityRealtimeConversationIds) {
      addId(id);
    }

    // Keep channels for threads waiting on delivery/seen receipts.
    addFrom(
      _threads.where(
        (t) =>
            t.lastMessageStatus == ChatMessageStatus.sent ||
            t.lastMessageStatus == ChatMessageStatus.delivered,
      ),
    );
    addFrom(
      _archivedThreads.where(
        (t) =>
            t.lastMessageStatus == ChatMessageStatus.sent ||
            t.lastMessageStatus == ChatMessageStatus.delivered,
      ),
    );

    addFrom(_threads.where((t) => t.unreadCount > 0));
    addFrom(_archivedThreads.where((t) => t.unreadCount > 0));
    // Prefer full archived attach while that screen is open.
    if (_archivedScreenActive) {
      addFrom(_archivedThreads);
    }
    addFrom(_threads);
    // Always attach archived chats even when Archived screen is closed —
    // otherwise peers never receive messages / never ack delivered.
    addFrom(_archivedThreads);
    if (wanted.isEmpty) return;

    await _realtime.subscribeInboxConversations(
      conversationIds: wanted.toList(),
      currentUserId: currentUserId,
      displayName: _myDisplayName,
      imageUrl: _myImageUrl,
    );
  }

  void _onRealtimeEvent(ChatRealtimeEvent event) {
    switch (event) {
      case ChatMessageSentEvent(:final message):
        final conversationId = message.conversationId;
        if (conversationId == null) return;
        final messageId = message.id;
        if (messageId != null) {
          if (!_handledIncomingMessageIds.add(messageId)) {
            // Duplicate Ably delivery — do not bump unread again.
            return;
          }
          if (_handledIncomingMessageIds.length > 300) {
            _handledIncomingMessageIds.remove(
              _handledIncomingMessageIds.first,
            );
          }
        }
        final preview = ChatMappers.messagePreview(message);
        final idx =
            _threads.indexWhere((t) => t.conversationId == conversationId);
        if (idx < 0) {
          final isMine =
              _currentUserId != null && message.sender?.id == _currentUserId;
          final isViewing = _realtime.isViewingConversation(conversationId);
          final archIdx = _archivedThreads
              .indexWhere((t) => t.conversationId == conversationId);
          if (archIdx >= 0) {
            _applyIncomingToArchived(
              archIdx: archIdx,
              message: message,
              preview: preview,
              isMine: isMine,
              isViewing: isViewing,
            );
            return;
          }
          unawaited(() async {
            final hit = await ChatArchivePrefs.applyIncomingMessage(
              conversationId: conversationId,
              preview: preview,
              timeLabel: ChatMappers.formatInboxTime(
                message.createdAt ?? DateTime.now().toIso8601String(),
              ),
              becomesUnread: !isMine && !isViewing,
              clearLastMessageStatus: !isMine,
            );
            if (!hit) {
              silentRefresh();
              return;
            }
            // Prefs had the archived row but live list didn't — mirror + ack.
            await ChatArchivePrefs.ensureLoaded();
            InboxThread? archived;
            for (final t in ChatArchivePrefs.threads) {
              if (t.conversationId == conversationId) {
                archived = t;
                break;
              }
            }
            if (archived == null) return;
            final liveIdx = _archivedThreads
                .indexWhere((t) => t.conversationId == conversationId);
            if (liveIdx >= 0) {
              _archivedThreads = [
                archived,
                for (var i = 0; i < _archivedThreads.length; i++)
                  if (i != liveIdx) _archivedThreads[i],
              ];
            } else {
              _archivedThreads = [archived, ..._archivedThreads];
            }
            _notifyArchived();
            if (!isMine) {
              _markThreadDelivered(archived);
            }
          }());
          return;
        }
        final isMine =
            _currentUserId != null && message.sender?.id == _currentUserId;
        final attachments = message.attachments ?? const [];
        final imageCount =
            attachments.where(ChatMappers.isImageAttachment).length;
        final fileCount =
            attachments.where(ChatMappers.isFileAttachment).length;
        final previewKind = ChatMappers.previewKindFromText(
          preview.isEmpty ? _threads[idx].preview : preview,
        );
        final resolvedKind = imageCount > 0
            ? InboxPreviewKind.photo
            : (fileCount > 0 ? InboxPreviewKind.file : previewKind);
        final nextPreview = resolvedKind == InboxPreviewKind.photo
            ? (imageCount > 1 ? '[Images:$imageCount]' : '[Image]')
            : resolvedKind == InboxPreviewKind.file
                ? (fileCount > 1
                    ? '[Files:$fileCount]'
                    : (preview.isEmpty ? '[File]' : preview))
                : (preview.isEmpty ? _threads[idx].preview : preview);
        final previewCount = resolvedKind == InboxPreviewKind.photo
            ? (imageCount > 0 ? imageCount : 1)
            : resolvedKind == InboxPreviewKind.file
                ? (fileCount > 0 ? fileCount : 1)
                : ChatMappers.previewCountFromText(nextPreview);
        // Only treat as read when this conversation's chat room is open.
        final isViewing = _realtime.isViewingConversation(conversationId);
        final becomesUnread = !isMine && !isViewing;
        final updated = _threads[idx].copyWith(
          preview: nextPreview,
          previewKind: resolvedKind,
          previewCount: previewCount,
          timeLabel: ChatMappers.formatInboxTime(
            message.createdAt ?? DateTime.now().toIso8601String(),
          ),
          unreadCount: becomesUnread
              ? (_threads[idx].unreadCount + 1)
              : (isViewing || isMine ? 0 : _threads[idx].unreadCount),
          // Priority is for unread threads only — keep section if already viewing.
          isPriority: becomesUnread
              ? true
              : (isViewing || isMine ? false : _threads[idx].isPriority),
          lastMessageStatus: isMine
              ? _capOutgoingStatus(
                  conversationId,
                  _mergedOutgoingStatus(
                    previous: _threads[idx].lastMessageStatus,
                    fromApi: ChatMappers.messageStatusFromApi(
                      message.status,
                      isOutgoing: true,
                    ),
                  ),
                  peerUserId: message.sender?.id == _currentUserId
                      ? _threads[idx].counterpartUserId
                      : message.sender?.id,
                )
              : null,
          clearLastMessageStatus: !isMine,
          // Message arrived — drop "sending image/file" preview immediately.
          peerActivity:
              isMine ? _threads[idx].peerActivity : ChatComposerActivity.none,
          isTyping: isMine ? _threads[idx].isTyping : false,
        );
        _threads = [
          updated,
          for (var i = 0; i < _threads.length; i++)
            if (i != idx) _threads[i],
        ];
        _sortPinnedFirst();
        if (!isMine) {
          _typingClearTimers[conversationId]?.cancel();
          _suppressMediaActivityUntil[conversationId] =
              DateTime.now().add(const Duration(seconds: 3));
        }
        _emitLoaded();
        if (!isMine) {
          // Message reached this device — ack delivered even if chat isn't open.
          // Opening the chat (getMessages) is what advances status to seen.
          _markThreadDelivered(updated);
          if (!_realtime.isViewingConversation(conversationId)) {
            final muteKey = ChatMutePrefs.keyFor(
              conversationId: conversationId,
              chatType: updated.chatType,
              contextId: updated.contextId,
            );
            unawaited(() async {
              await ChatMutePrefs.ensureLoaded();
              if (!ChatMutePrefs.isMuted(muteKey)) {
                await ChatIncomingSound.play();
              }
            }());
          }
        }
      case ChatMessageDeliveredEvent(:final conversationId, :final userId):
        // Peer acknowledged delivery of our messages.
        if (_currentUserId != null && userId == _currentUserId) break;
        _upgradeOutgoingStatus(
          conversationId,
          ChatMessageStatus.delivered,
        );
      case ChatMessageReadEvent(:final conversationId, :final userId):
        if (_currentUserId != null && userId == _currentUserId) break;
        // Blue ticks only if peer is inside that chat room. Delivered while
        // they browse Chats / other screens must not look like "seen".
        final inChat = userId != null &&
            _realtime.isUserPresentInConversation(conversationId, userId);
        _upgradeOutgoingStatus(
          conversationId,
          inChat ? ChatMessageStatus.seen : ChatMessageStatus.delivered,
        );
      case ChatMessageUpdatedEvent(:final message):
        final conversationId = message.conversationId;
        if (conversationId == null) break;
        final content = (message.content ?? '').trim();
        if (content.isEmpty) break;
        final timeLabel = ChatMappers.formatInboxTime(
          message.updatedAt ??
              message.createdAt ??
              DateTime.now().toIso8601String(),
        );
        final idx =
            _threads.indexWhere((t) => t.conversationId == conversationId);
        if (idx >= 0) {
          _threads = [
            for (var i = 0; i < _threads.length; i++)
              if (i == idx)
                _threads[i].copyWith(preview: content, timeLabel: timeLabel)
              else
                _threads[i],
          ];
          _sortPinnedFirst();
          _emitLoaded();
        }
        final archIdx = _archivedThreads
            .indexWhere((t) => t.conversationId == conversationId);
        if (archIdx >= 0) {
          _archivedThreads = [
            for (var i = 0; i < _archivedThreads.length; i++)
              if (i == archIdx)
                _archivedThreads[i]
                    .copyWith(preview: content, timeLabel: timeLabel)
              else
                _archivedThreads[i],
          ];
          _notifyArchived();
        }
      case ChatMessageDeletedEvent():
      case ChatMessageReactedEvent():
        break;
      case ChatUserTypingEvent(
          :final conversationId,
          :final userId,
          :final isTyping,
          :final activity,
          :final fromPresence,
        ):
        if (_currentUserId != null && userId == _currentUserId) break;
        // Unattributed typing echoes (paste/self REST) must not mark peers typing.
        if (userId == null) break;
        final suppressedUntil = _suppressMediaActivityUntil[conversationId];
        final suppressComposer =
            suppressedUntil != null && DateTime.now().isBefore(suppressedUntil);
        if (suppressComposer) {
          // Don't flash typing/recording/sending after the message already landed.
          _setPeerActivity(conversationId, ChatComposerActivity.none);
          break;
        }
        final ChatComposerActivity next;
        if (!isTyping) {
          final idx =
              _threads.indexWhere((t) => t.conversationId == conversationId);
          final archIdx = _archivedThreads
              .indexWhere((t) => t.conversationId == conversationId);
          final current = idx >= 0
              ? _threads[idx].peerActivity
              : (archIdx >= 0 ? _archivedThreads[archIdx].peerActivity : null);
          final isUploadOrRecord = current == ChatComposerActivity.recording ||
              current == ChatComposerActivity.sendingImage ||
              current == ChatComposerActivity.sendingImages ||
              current == ChatComposerActivity.sendingFile ||
              current == ChatComposerActivity.sendingFiles;
          // Typing REST stop must not clear upload/record; presence clear may.
          if (!fromPresence && isUploadOrRecord) break;
          if (isUploadOrRecord) {
            // Block false "typing" between recording end and voice/image arrival.
            _suppressMediaActivityUntil[conversationId] =
                DateTime.now().add(const Duration(seconds: 3));
          }
          next = ChatComposerActivity.none;
        } else if (activity.isActive &&
            activity != ChatComposerActivity.typing) {
          next = activity;
        } else {
          final idx =
              _threads.indexWhere((t) => t.conversationId == conversationId);
          final archIdx = _archivedThreads
              .indexWhere((t) => t.conversationId == conversationId);
          final current = idx >= 0
              ? _threads[idx].peerActivity
              : (archIdx >= 0 ? _archivedThreads[archIdx].peerActivity : null);
          if (!fromPresence &&
              (current == ChatComposerActivity.recording ||
                  current == ChatComposerActivity.sendingImage ||
                  current == ChatComposerActivity.sendingImages ||
                  current == ChatComposerActivity.sendingFile ||
                  current == ChatComposerActivity.sendingFiles)) {
            // Don't replace recording/upload preview with generic "typing".
            break;
          }
          next = ChatComposerActivity.typing;
        }
        _setPeerActivity(conversationId, next);
        // Activity means they're present — keep inbox status in sync.
        if (next.isActive) {
          _setOnline(conversationId, peerUserId: userId, isOnline: true);
        }
      case ChatPresenceChangedEvent(
          :final conversationId,
          :final userId,
          :final clientId,
          :final isOnline,
        ):
        final id = userId ?? int.tryParse(clientId ?? '');
        if (id == null || id == _currentUserId) break;
        _setOnline(conversationId, peerUserId: id, isOnline: isOnline);
        if (!isOnline) {
          _setPeerActivity(conversationId, ChatComposerActivity.none);
        } else {
          // Peer is in this conversation channel → delivered. Seen only comes
          // from message.read while they are still present (opening the room
          // alone used to blue-tick from a stale presence snapshot on Chats).
          _upgradeOutgoingStatus(conversationId, ChatMessageStatus.delivered);
        }
      case ChatAppPresenceChangedEvent(:final userId, :final isOnline):
        if (userId == _currentUserId) break;
        _setAppOnline(userId, isOnline: isOnline);
      case ChatInboxInvalidateEvent(
          :final conversationId,
          :final contextId,
          :final chatType,
          :final removed,
        ):
        if (removed) {
          removeThreadsMatching(
            conversationId: conversationId,
            contextId: contextId,
            chatType: chatType,
          );
        } else if (conversationId != null) {
          _pinRealtimeConversation(conversationId);
        }
        unawaited(silentRefresh(bypassThrottle: true));
    }
  }

  /// Drop inbox/archived rows for a deleted or left social/case chat.
  void removeThreadsMatching({
    int? conversationId,
    int? contextId,
    String? chatType,
  }) {
    bool matches(InboxThread t) {
      if (conversationId != null && t.conversationId == conversationId) {
        return true;
      }
      if (contextId == null) return false;
      if (t.contextId != contextId) return false;
      if (chatType == null || chatType.isEmpty) return true;
      return t.chatType == chatType || t.resolvedChatType == chatType;
    }

    final before = _threads.length;
    final beforeArch = _archivedThreads.length;
    _threads = [
      for (final t in _threads)
        if (!matches(t)) t
    ];
    _archivedThreads = [
      for (final t in _archivedThreads)
        if (!matches(t)) t,
    ];
    if (_threads.length != before) {
      _sortPinnedFirst();
      _emitLoaded();
    }
    if (_archivedThreads.length != beforeArch) {
      _notifyArchived();
    }
  }

  /// Social group joined/created → refresh + notify peers.
  void notifySocialGroupJoined({required int groupId}) {
    final id = groupId;
    if (id <= 0) return;
    unawaited(silentRefresh(bypassThrottle: true));
    unawaited(
      _realtime.publishConversationCreated(
        conversationId: id,
        contextId: id,
        chatType: ChatApiType.socialGroup,
      ),
    );
  }

  /// Social group left/deleted → drop local row + notify peers.
  void notifySocialGroupRemoved({required int groupId}) {
    final id = groupId;
    if (id <= 0) return;
    removeThreadsMatching(
      contextId: id,
      chatType: ChatApiType.socialGroup,
    );
    unawaited(silentRefresh(bypassThrottle: true));
    unawaited(
      _realtime.publishInboxRefresh(
        contextId: id,
        chatType: ChatApiType.socialGroup,
        removed: true,
      ),
    );
  }

  void _upgradeOutgoingStatus(
    int conversationId,
    ChatMessageStatus next,
  ) {
    final idx = _threads.indexWhere((t) => t.conversationId == conversationId);
    final archIdx =
        _archivedThreads.indexWhere((t) => t.conversationId == conversationId);

    var changed = false;
    if (idx >= 0) {
      final current = _threads[idx].lastMessageStatus;
      final currentRank = current == null ? 1 : _statusRank(current);
      if (_statusRank(next) > currentRank) {
        changed = true;
        _threads = [
          for (var i = 0; i < _threads.length; i++)
            if (i == idx)
              _threads[i].copyWith(lastMessageStatus: next)
            else
              _threads[i],
        ];
      }
    }

    var archivedChanged = false;
    if (archIdx >= 0) {
      final current = _archivedThreads[archIdx].lastMessageStatus;
      final currentRank = current == null ? 1 : _statusRank(current);
      if (_statusRank(next) > currentRank) {
        archivedChanged = true;
        _archivedThreads = [
          for (var i = 0; i < _archivedThreads.length; i++)
            if (i == archIdx)
              _archivedThreads[i].copyWith(lastMessageStatus: next)
            else
              _archivedThreads[i],
        ];
      }
    }

    if (changed) _emitLoaded();
    if (archivedChanged) _notifyArchived();
  }

  InboxThread? _findThreadByConversation(int conversationId) {
    for (final t in _threads) {
      if (t.conversationId == conversationId) return t;
    }
    for (final t in _archivedThreads) {
      if (t.conversationId == conversationId) return t;
    }
    return null;
  }

  /// Look up a cached inbox row (e.g. push-open needs peer avatar before API).
  InboxThread? findThread({
    String? chatType,
    int? contextId,
    int? conversationId,
  }) {
    if (conversationId != null) {
      final byConversation = _findThreadByConversation(conversationId);
      if (byConversation != null) return byConversation;
    }
    if (chatType == null || chatType.isEmpty || contextId == null) {
      return null;
    }
    for (final t in _threads) {
      if (t.chatType == chatType && t.contextId == contextId) return t;
    }
    for (final t in _archivedThreads) {
      if (t.chatType == chatType && t.contextId == contextId) return t;
    }
    return null;
  }

  /// Never let an Ably/API echo downgrade ticks (e.g. delivered → sent).
  ChatMessageStatus _mergedOutgoingStatus({
    required ChatMessageStatus? previous,
    required ChatMessageStatus fromApi,
  }) {
    if (previous == null) return fromApi;
    return _statusRank(previous) >= _statusRank(fromApi) ? previous : fromApi;
  }

  /// Backend may emit `seen`/`message.read` when the peer only acked delivered
  /// (or leftover conversation presence). Cap at delivered unless they are
  /// actually in that chat room.
  ChatMessageStatus _capOutgoingStatus(
    int conversationId,
    ChatMessageStatus status, {
    int? peerUserId,
  }) {
    if (status != ChatMessageStatus.seen) return status;
    final thread = _findThreadByConversation(conversationId);
    if (thread != null && thread.isGroupLike) return status;
    final peer = peerUserId ?? thread?.counterpartUserId;
    if (peer != null &&
        _realtime.isUserPresentInConversation(conversationId, peer)) {
      return ChatMessageStatus.seen;
    }
    return ChatMessageStatus.delivered;
  }

  InboxThread _mergeLiveOutgoingStatus(
    InboxThread thread,
    ChatMessageStatus live,
  ) {
    final cappedLive = thread.conversationId == null
        ? live
        : _capOutgoingStatus(thread.conversationId!, live,
            peerUserId: thread.counterpartUserId);
    final api = thread.lastMessageStatus == null || thread.conversationId == null
        ? thread.lastMessageStatus
        : _capOutgoingStatus(
            thread.conversationId!,
            thread.lastMessageStatus!,
            peerUserId: thread.counterpartUserId,
          );
    if (api == null) return thread.copyWith(lastMessageStatus: cappedLive);
    if (_statusRank(cappedLive) <= _statusRank(api)) {
      return api == thread.lastMessageStatus
          ? thread
          : thread.copyWith(lastMessageStatus: api);
    }
    return thread.copyWith(lastMessageStatus: cappedLive);
  }

  int _statusRank(ChatMessageStatus status) {
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

  void _applyIncomingToArchived({
    required int archIdx,
    required ChatMessageModel message,
    required String preview,
    required bool isMine,
    required bool isViewing,
  }) {
    final previous = _archivedThreads[archIdx];
    final attachments = message.attachments ?? const [];
    final imageCount = attachments.where(ChatMappers.isImageAttachment).length;
    final fileCount = attachments.where(ChatMappers.isFileAttachment).length;
    final previewKind = ChatMappers.previewKindFromText(
      preview.isEmpty ? previous.preview : preview,
    );
    final resolvedKind = imageCount > 0
        ? InboxPreviewKind.photo
        : (fileCount > 0 ? InboxPreviewKind.file : previewKind);
    final nextPreview = resolvedKind == InboxPreviewKind.photo
        ? (imageCount > 1 ? '[Images:$imageCount]' : '[Image]')
        : resolvedKind == InboxPreviewKind.file
            ? (fileCount > 1
                ? '[Files:$fileCount]'
                : (preview.isEmpty ? '[File]' : preview))
            : (preview.isEmpty ? previous.preview : preview);
    final previewCount = resolvedKind == InboxPreviewKind.photo
        ? (imageCount > 0 ? imageCount : 1)
        : resolvedKind == InboxPreviewKind.file
            ? (fileCount > 0 ? fileCount : 1)
            : ChatMappers.previewCountFromText(nextPreview);
    final becomesUnread = !isMine && !isViewing;
    final updated = previous.copyWith(
      preview: nextPreview,
      previewKind: resolvedKind,
      previewCount: previewCount,
      timeLabel: ChatMappers.formatInboxTime(
        message.createdAt ?? DateTime.now().toIso8601String(),
      ),
      unreadCount: becomesUnread
          ? (previous.unreadCount + 1)
          : (isViewing || isMine ? 0 : previous.unreadCount),
      isPriority: becomesUnread
          ? true
          : (isViewing || isMine ? false : previous.isPriority),
      lastMessageStatus: isMine
          ? () {
              final merged = _mergedOutgoingStatus(
                previous: previous.lastMessageStatus,
                fromApi: ChatMappers.messageStatusFromApi(
                  message.status,
                  isOutgoing: true,
                ),
              );
              final cid = previous.conversationId;
              if (cid == null) return merged;
              return _capOutgoingStatus(
                cid,
                merged,
                peerUserId: previous.counterpartUserId,
              );
            }()
          : null,
      clearLastMessageStatus: !isMine,
      peerActivity: isMine ? previous.peerActivity : ChatComposerActivity.none,
      isTyping: isMine ? previous.isTyping : false,
    );
    _archivedThreads = [
      updated,
      for (var i = 0; i < _archivedThreads.length; i++)
        if (i != archIdx) _archivedThreads[i],
    ];
    // Absolute sync into prefs — never call applyIncomingMessage (+1) after this.
    unawaited(ChatArchivePrefs.syncThread(updated));
    _notifyArchived();
    if (!isMine) {
      final conversationId = updated.conversationId;
      if (conversationId != null) {
        _typingClearTimers[conversationId]?.cancel();
        _suppressMediaActivityUntil[conversationId] =
            DateTime.now().add(const Duration(seconds: 3));
        _markThreadDelivered(updated);
        if (!_realtime.isViewingConversation(conversationId)) {
          final muteKey = ChatMutePrefs.keyFor(
            conversationId: conversationId,
            chatType: updated.chatType,
            contextId: updated.contextId,
          );
          unawaited(() async {
            await ChatMutePrefs.ensureLoaded();
            if (!ChatMutePrefs.isMuted(muteKey)) {
              await ChatIncomingSound.play();
            }
          }());
        }
      }
    }
  }

  void _setPeerActivity(int conversationId, ChatComposerActivity activity) {
    final idx = _threads.indexWhere((t) => t.conversationId == conversationId);
    final archIdx =
        _archivedThreads.indexWhere((t) => t.conversationId == conversationId);
    if (idx < 0 && archIdx < 0) return;

    final currentMain = idx >= 0 ? _threads[idx] : null;
    final currentArch = archIdx >= 0 ? _archivedThreads[archIdx] : null;
    final sameMain = currentMain != null &&
        currentMain.peerActivity == activity &&
        currentMain.isTyping == activity.isActive;
    final sameArch = currentArch != null &&
        currentArch.peerActivity == activity &&
        currentArch.isTyping == activity.isActive;
    if ((idx < 0 || sameMain) && (archIdx < 0 || sameArch)) {
      if (activity.isActive) {
        _schedulePeerActivityClear(conversationId, activity);
      }
      return;
    }

    _typingClearTimers[conversationId]?.cancel();
    if (idx >= 0) {
      _threads = [
        for (var i = 0; i < _threads.length; i++)
          if (i == idx)
            _threads[i].copyWith(
              peerActivity: activity,
              isTyping: activity.isActive,
            )
          else
            _threads[i],
      ];
      _emitLoaded();
    }
    if (archIdx >= 0) {
      _archivedThreads = [
        for (var i = 0; i < _archivedThreads.length; i++)
          if (i == archIdx)
            _archivedThreads[i].copyWith(
              peerActivity: activity,
              isTyping: activity.isActive,
            )
          else
            _archivedThreads[i],
      ];
      _notifyArchived();
    }

    if (activity.isActive) {
      _schedulePeerActivityClear(conversationId, activity);
    }
  }

  /// Uploads wait for message/presence clear; typing/recording idle out sooner.
  void _schedulePeerActivityClear(
    int conversationId,
    ChatComposerActivity activity,
  ) {
    _typingClearTimers[conversationId]?.cancel();
    final clearAfter = activity.isUpload
        ? const Duration(minutes: 2)
        : const Duration(seconds: 6);
    _typingClearTimers[conversationId] = Timer(
      clearAfter,
      () => _setPeerActivity(conversationId, ChatComposerActivity.none),
    );
  }

  /// Apply live Ably presence onto API-mapped threads (API has no online flag).
  List<InboxThread> _withLivePresence(List<InboxThread> mapped) {
    _appOnlineUserIds
      ..clear()
      ..addAll(_realtime.appOnlineUserIds);
    final activityById = <int, ChatComposerActivity>{
      for (final t in _threads)
        if (t.conversationId != null && t.peerActivity.isActive)
          t.conversationId!: t.peerActivity,
      for (final t in _archivedThreads)
        if (t.conversationId != null && t.peerActivity.isActive)
          t.conversationId!: t.peerActivity,
    };
    final pinnedById = <String, bool>{
      for (final t in _threads)
        if (t.isPinned) t.id: true,
      for (final t in _archivedThreads)
        if (t.isPinned) t.id: true,
    };
    return [
      for (final thread in mapped)
        thread.copyWith(
          isOnline: _isThreadOnline(thread),
          peerActivity: thread.conversationId != null
              ? (activityById[thread.conversationId!] ??
                  ChatComposerActivity.none)
              : ChatComposerActivity.none,
          isPinned: pinnedById[thread.id] ?? thread.isPinned,
          isMuted: _isThreadMuted(thread),
        ),
    ];
  }

  /// Refresh presence:app members then recompute thread Online dots.
  Future<void> _refreshAndReapplyAppPresence() async {
    final uid = _currentUserId;
    if (uid != null) {
      try {
        await _realtime.ensureAppPresence(
          currentUserId: uid,
          displayName: _myDisplayName,
          imageUrl: _myImageUrl,
        );
        await _realtime.refreshAppPresenceSnapshot();
      } catch (_) {}
    } else {
      try {
        await _realtime.refreshAppPresenceSnapshot();
      } catch (_) {}
    }
    if (isClosed) return;
    _reapplyAppOnlineToThreads();
  }

  bool _isThreadMuted(InboxThread thread) {
    final key = ChatMutePrefs.keyFor(
      conversationId: thread.conversationId,
      chatType: thread.chatType,
      contextId: thread.contextId,
    );
    if (key.isNotEmpty && ChatMutePrefs.isMuted(key)) return true;
    return thread.isMuted;
  }

  void _sortPinnedFirst() {
    _threads = [
      ..._threads.where((t) => t.isPinned),
      ..._threads.where((t) => !t.isPinned),
    ];
  }

  void _sortArchivedPinnedFirst() {
    _archivedThreads = [
      ..._archivedThreads.where((t) => t.isPinned),
      ..._archivedThreads.where((t) => !t.isPinned),
    ];
  }

  bool _hasChatAddress(InboxThread thread) {
    final chatType = thread.resolvedChatType;
    final contextId = thread.resolvedContextId;
    return chatType != null &&
        chatType.isNotEmpty &&
        contextId != null &&
        contextId > 0;
  }

  Future<bool> pinThread(InboxThread thread, {required bool pinned}) async {
    if (!_hasChatAddress(thread)) return false;
    final chatType = thread.resolvedChatType!;
    final contextId = thread.resolvedContextId!;
    final idx = _threads.indexWhere((t) => t.id == thread.id);
    final inMain = idx >= 0;
    InboxThread? previous;
    if (inMain) {
      previous = _threads[idx];
      _threads = [
        for (var i = 0; i < _threads.length; i++)
          if (i == idx) previous.copyWith(isPinned: pinned) else _threads[i],
      ];
      _sortPinnedFirst();
      _emitLoaded();
    } else {
      unawaited(ChatArchivePrefs.updateThread(thread.id, isPinned: pinned));
      final archIdx = _archivedThreads.indexWhere((t) => t.id == thread.id);
      if (archIdx >= 0) {
        _archivedThreads = [
          for (var i = 0; i < _archivedThreads.length; i++)
            if (i == archIdx)
              _archivedThreads[i].copyWith(isPinned: pinned)
            else
              _archivedThreads[i],
        ];
        _sortArchivedPinnedFirst();
        _notifyArchived();
      }
    }

    final result = await _chatRoomRepository.setConversationPin(
      contextId: contextId,
      chatType: chatType,
      pinned: pinned,
    );
    return result.fold(
      (failure) {
        debugPrint('pinThread failed: ${failure.message}');
        if (inMain && previous != null) {
          final rollbackIdx = _threads.indexWhere((t) => t.id == thread.id);
          if (rollbackIdx >= 0) {
            _threads = [
              for (var i = 0; i < _threads.length; i++)
                if (i == rollbackIdx) previous! else _threads[i],
            ];
            _sortPinnedFirst();
            _emitLoaded();
          }
        } else {
          unawaited(ChatArchivePrefs.updateThread(
            thread.id,
            isPinned: thread.isPinned,
          ));
          final archIdx = _archivedThreads.indexWhere((t) => t.id == thread.id);
          if (archIdx >= 0) {
            _archivedThreads = [
              for (var i = 0; i < _archivedThreads.length; i++)
                if (i == archIdx)
                  _archivedThreads[i].copyWith(isPinned: thread.isPinned)
                else
                  _archivedThreads[i],
            ];
            _sortArchivedPinnedFirst();
            _notifyArchived();
          }
        }
        return false;
      },
      (_) => true,
    );
  }

  Future<bool> archiveThread(InboxThread thread) async {
    if (!_hasChatAddress(thread)) return false;
    final chatType = thread.resolvedChatType!;
    final contextId = thread.resolvedContextId!;
    final idx = _threads.indexWhere((t) => t.id == thread.id);
    if (idx < 0) return false;

    final previousList = List<InboxThread>.of(_threads);
    _threads = [
      for (final t in _threads)
        if (t.id != thread.id) t,
    ];
    _emitLoaded();

    final result = await _chatRoomRepository.setConversationArchive(
      contextId: contextId,
      chatType: chatType,
      archived: true,
    );
    return result.fold(
      (failure) {
        debugPrint('archiveThread failed: ${failure.message}');
        _threads = previousList;
        _emitLoaded();
        return false;
      },
      (_) {
        unawaited(ChatArchivePrefs.add(thread));
        final already = _archivedThreads.any((t) => t.id == thread.id);
        if (!already) {
          _archivedThreads = [thread, ..._archivedThreads];
          _sortArchivedPinnedFirst();
          _notifyArchived();
        }
        final uid = _currentUserId;
        if (uid != null) unawaited(_syncRealtimeChannels(uid));
        return true;
      },
    );
  }

  Future<bool> unarchiveThread(InboxThread thread) async {
    if (!_hasChatAddress(thread)) return false;
    final chatType = thread.resolvedChatType!;
    final contextId = thread.resolvedContextId!;

    final previousArchived = List<InboxThread>.of(_archivedThreads);
    final previousMain = List<InboxThread>.of(_threads);
    final wasInArchived = _archivedThreads.any((t) => t.id == thread.id);
    final alreadyInMain = _threads.any((t) => t.id == thread.id);

    // Optimistic update so archive/chats lists can animate immediately.
    if (wasInArchived) {
      _archivedThreads = [
        for (final t in _archivedThreads)
          if (t.id != thread.id) t,
      ];
      _notifyArchived();
    }
    if (!alreadyInMain) {
      _threads = [thread, ..._threads];
      _sortPinnedFirst();
      _emitLoaded();
    }
    unawaited(ChatArchivePrefs.remove(thread.id));

    final result = await _chatRoomRepository.setConversationArchive(
      contextId: contextId,
      chatType: chatType,
      archived: false,
    );
    return result.fold(
      (failure) {
        debugPrint('unarchiveThread failed: ${failure.message}');
        _archivedThreads = previousArchived;
        _threads = previousMain;
        _notifyArchived();
        _emitLoaded();
        if (wasInArchived) {
          unawaited(ChatArchivePrefs.add(thread));
        }
        return false;
      },
      (_) {
        final uid = _currentUserId;
        if (uid != null) unawaited(_syncRealtimeChannels(uid));
        return true;
      },
    );
  }

  /// Loads archived chats from `GET /inbox?filter=all&page=1&per_page=20&archived=1`.
  /// Falls back to the local archive cache if the request fails.
  Future<List<InboxThread>> loadArchivedThreads() async {
    await ChatArchivePrefs.ensureLoaded();
    final local = ChatArchivePrefs.threads;

    final result = await _getInboxUsecase.execute(
      const GetInboxParams(
        filter: 'all',
        page: 1,
        perPage: 20,
        archived: 1,
      ),
    );
    return result.fold(
      (failure) {
        debugPrint('loadArchivedThreads failed: ${failure.message}');
        _archivedThreads = _withLivePresence(local);
        _sortArchivedPinnedFirst();
        _notifyArchived();
        final uid = _currentUserId;
        if (uid != null) unawaited(_syncRealtimeChannels(uid));
        _scheduleAckUnreadDelivered();
        return _archivedThreads;
      },
      (response) {
        final items = response.data?.items ?? const [];
        final mapped =
            items.map(ChatMappers.toInboxThread).toList(growable: false);
        final live = _withLivePresence(mapped);
        _archivedThreads = live;
        _sortArchivedPinnedFirst();
        unawaited(ChatArchivePrefs.replaceAll(live));
        _notifyArchived();
        final uid = _currentUserId;
        if (uid != null) unawaited(_syncRealtimeChannels(uid));
        _scheduleAckUnreadDelivered();
        return live;
      },
    );
  }

  Future<bool> hideThread(InboxThread thread) async {
    if (!_hasChatAddress(thread)) return false;
    final chatType = thread.resolvedChatType!;
    final contextId = thread.resolvedContextId!;
    final idx = _threads.indexWhere((t) => t.id == thread.id);
    if (idx < 0) return false;

    final previousList = List<InboxThread>.of(_threads);
    _threads = [
      for (final t in _threads)
        if (t.id != thread.id) t,
    ];
    _emitLoaded();

    final result = await _chatRoomRepository.setConversationHidden(
      contextId: contextId,
      chatType: chatType,
      hidden: true,
    );
    return result.fold(
      (failure) {
        debugPrint('hideThread failed: ${failure.message}');
        _threads = previousList;
        _emitLoaded();
        return false;
      },
      (_) => true,
    );
  }

  Future<bool> markThreadUnread(InboxThread thread) async {
    if (!_hasChatAddress(thread)) return false;
    final chatType = thread.resolvedChatType!;
    final contextId = thread.resolvedContextId!;
    final idx = _threads.indexWhere((t) => t.id == thread.id);
    final archIdx = _archivedThreads.indexWhere((t) => t.id == thread.id);
    final inMain = idx >= 0;
    InboxThread? previous;
    InboxThread? previousArchived;
    if (inMain) {
      previous = _threads[idx];
      final nextUnread = previous.unreadCount > 0 ? previous.unreadCount : 1;
      _threads = [
        for (var i = 0; i < _threads.length; i++)
          if (i == idx)
            previous.copyWith(unreadCount: nextUnread, isPriority: true)
          else
            _threads[i],
      ];
      _sortPinnedFirst();
      _emitLoaded();
    } else if (archIdx >= 0) {
      previousArchived = _archivedThreads[archIdx];
      final nextUnread =
          previousArchived.unreadCount > 0 ? previousArchived.unreadCount : 1;
      _archivedThreads = [
        for (var i = 0; i < _archivedThreads.length; i++)
          if (i == archIdx)
            previousArchived.copyWith(unreadCount: nextUnread, isPriority: true)
          else
            _archivedThreads[i],
      ];
      unawaited(ChatArchivePrefs.updateThread(
        thread.id,
        unreadCount: nextUnread,
      ));
      _notifyArchived();
    } else {
      final nextUnread = thread.unreadCount > 0 ? thread.unreadCount : 1;
      unawaited(ChatArchivePrefs.updateThread(
        thread.id,
        unreadCount: nextUnread,
      ));
    }

    final result = await _chatRoomRepository.setConversationUnread(
      contextId: contextId,
      chatType: chatType,
      unread: true,
    );
    return result.fold(
      (failure) {
        debugPrint('markThreadUnread failed: ${failure.message}');
        if (inMain && previous != null) {
          final rollbackIdx = _threads.indexWhere((t) => t.id == thread.id);
          if (rollbackIdx >= 0) {
            _threads = [
              for (var i = 0; i < _threads.length; i++)
                if (i == rollbackIdx) previous! else _threads[i],
            ];
            _sortPinnedFirst();
            _emitLoaded();
          }
        } else if (previousArchived != null) {
          final rollbackIdx =
              _archivedThreads.indexWhere((t) => t.id == thread.id);
          if (rollbackIdx >= 0) {
            _archivedThreads = [
              for (var i = 0; i < _archivedThreads.length; i++)
                if (i == rollbackIdx)
                  previousArchived!
                else
                  _archivedThreads[i],
            ];
            _notifyArchived();
          }
          unawaited(ChatArchivePrefs.updateThread(
            thread.id,
            unreadCount: thread.unreadCount,
          ));
        } else {
          unawaited(ChatArchivePrefs.updateThread(
            thread.id,
            unreadCount: thread.unreadCount,
          ));
        }
        return false;
      },
      (_) => true,
    );
  }

  Future<bool> muteThread(InboxThread thread, {required bool mute}) async {
    if (!_hasChatAddress(thread)) return false;
    final chatType = thread.resolvedChatType!;
    final contextId = thread.resolvedContextId!;
    final idx = _threads.indexWhere((t) => t.id == thread.id);
    if (idx < 0) return false;

    final previous = _threads[idx];
    final muteKey = ChatMutePrefs.keyFor(
      conversationId: thread.conversationId,
      chatType: thread.chatType,
      contextId: thread.contextId,
    );
    _threads = [
      for (var i = 0; i < _threads.length; i++)
        if (i == idx) previous.copyWith(isMuted: mute) else _threads[i],
    ];
    _emitLoaded();
    unawaited(ChatMutePrefs.setMuted(muteKey, mute));

    final result = await _chatRoomRepository.setConversationMute(
      contextId: contextId,
      chatType: chatType,
      mute: mute,
    );
    return result.fold(
      (failure) {
        debugPrint('muteThread failed: ${failure.message}');
        final rollbackIdx = _threads.indexWhere((t) => t.id == thread.id);
        if (rollbackIdx >= 0) {
          _threads = [
            for (var i = 0; i < _threads.length; i++)
              if (i == rollbackIdx) previous else _threads[i],
          ];
          _emitLoaded();
        }
        unawaited(ChatMutePrefs.setMuted(muteKey, previous.isMuted));
        return false;
      },
      (_) => true,
    );
  }

  /// Peer user id for app-online dots (1:1 / consult only).
  int? _presencePeerUserId(InboxThread thread) {
    if (thread.isGroupLike) return null;
    if (thread.counterpartUserId != null) return thread.counterpartUserId;
    final t = thread.resolvedChatType;
    if (t == 'private' || thread.source == 'consultation') {
      return thread.contextId ?? thread.resolvedContextId;
    }
    return null;
  }

  bool _isThreadOnline(InboxThread thread) {
    // Groups / patient case chats never show personal online status.
    if (thread.isGroupLike) return false;
    final peerId = _presencePeerUserId(thread);
    if (peerId != null &&
        (_appOnlineUserIds.contains(peerId) ||
            _realtime.appOnlineUserIds.contains(peerId))) {
      return true;
    }
    final conversationId = thread.conversationId;
    if (conversationId == null) return false;
    final members = _onlineByConversation[conversationId];
    if (members == null || members.isEmpty) return false;
    if (peerId != null) return members.contains(peerId);
    // Never treat "someone in channel" as Online without a peer id — that
    // only flipped green after opening the room and hid app-presence misses.
    return false;
  }

  void _setAppOnline(int userId, {required bool isOnline}) {
    if (isOnline) {
      _appOnlineUserIds.add(userId);
    } else {
      _appOnlineUserIds.remove(userId);
      // App-offline wins: drop conversation-presence ghosts from typing/messages.
      for (final members in _onlineByConversation.values) {
        members.remove(userId);
      }
    }
    _reapplyAppOnlineToThreads();
  }

  /// Recompute [InboxThread.isOnline] from app + conversation presence sets.
  void _reapplyAppOnlineToThreads() {
    _appOnlineUserIds
      ..clear()
      ..addAll(_realtime.appOnlineUserIds);

    var changed = false;
    final nextThreads = <InboxThread>[];
    for (final thread in _threads) {
      final next = _isThreadOnline(thread);
      if (thread.isOnline == next) {
        nextThreads.add(thread);
      } else {
        changed = true;
        nextThreads.add(thread.copyWith(isOnline: next));
      }
    }
    if (changed) {
      _threads = nextThreads;
      _schedulePresenceEmit();
    }

    var archivedChanged = false;
    final nextArchived = <InboxThread>[];
    for (final thread in _archivedThreads) {
      final next = _isThreadOnline(thread);
      if (thread.isOnline == next) {
        nextArchived.add(thread);
      } else {
        archivedChanged = true;
        nextArchived.add(thread.copyWith(isOnline: next));
      }
    }
    if (archivedChanged) {
      _archivedThreads = nextArchived;
      _notifyArchived();
    }
  }

  void _schedulePresenceEmit() {
    if (isClosed) return;
    _emitLoaded();
  }

  void _setOnline(
    int conversationId, {
    required int peerUserId,
    required bool isOnline,
  }) {
    final members = _onlineByConversation.putIfAbsent(
      conversationId,
      () => <int>{},
    );
    if (isOnline) {
      members.add(peerUserId);
    } else {
      members.remove(peerUserId);
    }

    final idx = _threads.indexWhere((t) => t.conversationId == conversationId);
    final archIdx =
        _archivedThreads.indexWhere((t) => t.conversationId == conversationId);
    if (idx < 0 && archIdx < 0) return;

    if (idx >= 0) {
      final nextOnline = _isThreadOnline(_threads[idx]);
      if (_threads[idx].isOnline != nextOnline) {
        _threads = [
          for (var i = 0; i < _threads.length; i++)
            if (i == idx)
              _threads[i].copyWith(isOnline: nextOnline)
            else
              _threads[i],
        ];
        _schedulePresenceEmit();
      }
    }

    if (archIdx >= 0) {
      final nextOnline = _isThreadOnline(_archivedThreads[archIdx]);
      if (_archivedThreads[archIdx].isOnline != nextOnline) {
        _archivedThreads = [
          for (var i = 0; i < _archivedThreads.length; i++)
            if (i == archIdx)
              _archivedThreads[i].copyWith(isOnline: nextOnline)
            else
              _archivedThreads[i],
        ];
        _notifyArchived();
      }
    }
  }

  Future<bool> markThreadRead(InboxThread thread) async {
    final idx = _threads.indexWhere((t) => t.id == thread.id);
    final archIdx = _archivedThreads.indexWhere((t) => t.id == thread.id);
    final inMain = idx >= 0;
    InboxThread? previous;
    InboxThread? previousArchived;
    if (inMain) {
      if (_threads[idx].unreadCount == 0 && !_threads[idx].isPriority) {
        return true;
      }
      previous = _threads[idx];
      _threads = [
        for (var i = 0; i < _threads.length; i++)
          if (i == idx)
            previous.copyWith(unreadCount: 0, isPriority: false)
          else
            _threads[i],
      ];
      _emitLoaded();
    } else if (archIdx >= 0) {
      previousArchived = _archivedThreads[archIdx];
      if (previousArchived.unreadCount == 0 && !previousArchived.isPriority) {
        return true;
      }
      _archivedThreads = [
        for (var i = 0; i < _archivedThreads.length; i++)
          if (i == archIdx)
            previousArchived.copyWith(unreadCount: 0, isPriority: false)
          else
            _archivedThreads[i],
      ];
      unawaited(ChatArchivePrefs.updateThread(thread.id, unreadCount: 0));
      _notifyArchived();
    } else {
      if (thread.unreadCount == 0 && !thread.isPriority) return true;
      unawaited(ChatArchivePrefs.updateThread(thread.id, unreadCount: 0));
    }

    if (!_hasChatAddress(thread)) return true;
    final result = await _chatRoomRepository.setConversationUnread(
      contextId: thread.resolvedContextId!,
      chatType: thread.resolvedChatType!,
      unread: false,
    );
    return result.fold(
      (failure) {
        debugPrint('markThreadRead failed: ${failure.message}');
        if (inMain && previous != null) {
          final rollbackIdx = _threads.indexWhere((t) => t.id == thread.id);
          if (rollbackIdx >= 0) {
            _threads = [
              for (var i = 0; i < _threads.length; i++)
                if (i == rollbackIdx) previous! else _threads[i],
            ];
            _emitLoaded();
          }
        } else if (previousArchived != null) {
          final rollbackIdx =
              _archivedThreads.indexWhere((t) => t.id == thread.id);
          if (rollbackIdx >= 0) {
            _archivedThreads = [
              for (var i = 0; i < _archivedThreads.length; i++)
                if (i == rollbackIdx)
                  previousArchived!
                else
                  _archivedThreads[i],
            ];
            _notifyArchived();
          }
          unawaited(ChatArchivePrefs.updateThread(
            thread.id,
            unreadCount: thread.unreadCount,
          ));
        } else {
          unawaited(ChatArchivePrefs.updateThread(
            thread.id,
            unreadCount: thread.unreadCount,
          ));
        }
        return false;
      },
      (_) => true,
    );
  }

  /// Clear unread + priority when user opens / leaves a conversation.
  void markConversationRead(int conversationId) {
    unawaited(ChatArchivePrefs.clearUnreadForConversation(conversationId));
    final idx = _threads.indexWhere((t) => t.conversationId == conversationId);
    if (idx >= 0) {
      final thread = _threads[idx];
      _clearDeliveredAckForThread(thread);
      if (thread.unreadCount != 0 || thread.isPriority) {
        _threads = [
          for (var i = 0; i < _threads.length; i++)
            if (i == idx)
              _threads[i].copyWith(unreadCount: 0, isPriority: false)
            else
              _threads[i],
        ];
        _emitLoaded();
      }
    }
    final archIdx =
        _archivedThreads.indexWhere((t) => t.conversationId == conversationId);
    if (archIdx < 0) return;
    final archived = _archivedThreads[archIdx];
    _clearDeliveredAckForThread(archived);
    if (archived.unreadCount == 0 && !archived.isPriority) return;
    _archivedThreads = [
      for (var i = 0; i < _archivedThreads.length; i++)
        if (i == archIdx)
          _archivedThreads[i].copyWith(unreadCount: 0, isPriority: false)
        else
          _archivedThreads[i],
    ];
    _notifyArchived();
  }

  /// Ack delivery for a thread (message reached this device, chat may be closed).
  void _markThreadDelivered(InboxThread thread) {
    if (!_shouldAckDelivered(thread)) return;
    final contextId = thread.resolvedContextId!;
    final chatType = thread.resolvedChatType!;
    _rememberDeliveredAck(thread);
    unawaited(
      _chatRoomRepository.markDelivered(
        contextId: contextId,
        chatType: chatType,
      ),
    );
  }

  String? _deliveryAckKey(InboxThread thread) {
    final contextId = thread.resolvedContextId;
    final chatType = thread.resolvedChatType;
    if (contextId == null || chatType == null || chatType.isEmpty) return null;
    return '$chatType:$contextId';
  }

  bool _shouldAckDelivered(InboxThread thread) {
    final key = _deliveryAckKey(thread);
    if (key == null) return false;
    final unread = thread.unreadCount;
    // Realtime incoming with unread already applied, or first-ever ack.
    if (unread <= 0) {
      return !_deliveredAckUnreadByKey.containsKey(key);
    }
    final lastAckedUnread = _deliveredAckUnreadByKey[key];
    if (lastAckedUnread != null && unread <= lastAckedUnread) return false;
    return true;
  }

  void _rememberDeliveredAck(InboxThread thread) {
    final key = _deliveryAckKey(thread);
    if (key == null) return;
    final unread = thread.unreadCount;
    final prev = _deliveredAckUnreadByKey[key] ?? -1;
    if (unread >= prev) {
      _deliveredAckUnreadByKey[key] = unread;
    }
  }

  void _clearDeliveredAckForThread(InboxThread thread) {
    final key = _deliveryAckKey(thread);
    if (key == null) return;
    _deliveredAckUnreadByKey.remove(key);
  }

  /// Coalesce Home open: loadInbox + archived + startLiveUpdates → one batch.
  void _scheduleAckUnreadDelivered() {
    _ackDeliveredDebounce?.cancel();
    _ackDeliveredDebounce = Timer(const Duration(milliseconds: 600), () {
      _ackUnreadDeliveredNow();
    });
  }

  /// After inbox sync, unread threads on-device → mark delivered (not seen).
  /// Snapshot + debounce so the same group is not POSTed on every Home open.
  void _ackUnreadDelivered() => _scheduleAckUnreadDelivered();

  void _ackUnreadDeliveredNow() {
    if (_ackDeliveredInFlight) return;
    final pending = <InboxThread>[];
    final seenKeys = <String>{};

    void consider(InboxThread thread) {
      if (thread.unreadCount <= 0) return;
      final conversationId = thread.conversationId;
      if (conversationId != null &&
          conversationId == _realtime.subscribedConversationId) {
        return;
      }
      if (!_shouldAckDelivered(thread)) return;
      final key = _deliveryAckKey(thread);
      if (key == null || !seenKeys.add(key)) return;
      pending.add(thread);
    }

    for (final thread in _threads) {
      consider(thread);
      if (pending.length >= 12) break;
    }
    if (pending.length < 12) {
      for (final thread in _archivedThreads) {
        consider(thread);
        if (pending.length >= 12) break;
      }
    }
    if (pending.length < 12) {
      for (final thread in ChatArchivePrefs.threads) {
        consider(thread);
        if (pending.length >= 12) break;
      }
    }
    if (pending.isEmpty) return;

    for (final thread in pending) {
      _rememberDeliveredAck(thread);
    }

    _ackDeliveredInFlight = true;
    unawaited(() async {
      try {
        const batch = 3;
        for (var i = 0; i < pending.length; i += batch) {
          final slice = pending.skip(i).take(batch).toList();
          await Future.wait([
            for (final thread in slice)
              () async {
                try {
                  await _chatRoomRepository.markDelivered(
                    contextId: thread.resolvedContextId!,
                    chatType: thread.resolvedChatType!,
                  );
                } catch (_) {}
              }(),
          ]);
        }
      } finally {
        _ackDeliveredInFlight = false;
      }
    }());
  }

  int get totalUnreadCount =>
      _threads.fold<int>(0, (sum, t) => sum + t.unreadCount);

  void _emitLoaded({
    bool isLoadingMore = false,
    bool isRefreshing = false,
  }) {
    emit(
      InboxState.loaded(
        threads: List.of(_threads),
        counts: _counts,
        filter: _filter,
        isLastPage: _isLastPage,
        currentPage: _currentPage,
        totalCount: _totalCount,
        isLoadingMore: isLoadingMore,
        isRefreshing: isRefreshing,
      ),
    );
  }

  /// Prefer API meta; also treat an under-filled / empty page as the last page.
  bool _resolveIsLastPage(
    InboxPaginatorMetaModel? meta, {
    required int fetchedCount,
  }) {
    if (fetchedCount <= 0) return true;

    final perPage = meta?.perPage;
    if (perPage != null && perPage > 0 && fetchedCount < perPage) {
      return true;
    }

    if (meta?.currentPage != null && meta?.lastPage != null) {
      return meta!.currentPage! >= meta.lastPage!;
    }

    // Missing / incomplete meta: stop paging rather than looping forever.
    return true;
  }

  /// Instant preview update after sending from chat room.
  void applyOutgoingPreview({
    required String chatType,
    required int contextId,
    int? conversationId,
    required String preview,
    int? previewCount,
  }) {
    final idx = _threads.indexWhere((t) {
      if (conversationId != null && t.conversationId == conversationId) {
        return true;
      }
      return t.chatType == chatType && t.contextId == contextId;
    });
    if (idx < 0) {
      silentRefresh();
      return;
    }
    final kind = ChatMappers.previewKindFromText(preview);
    final count = previewCount ?? ChatMappers.previewCountFromText(preview);
    final previous = _threads[idx];
    final resolvedConversationId = conversationId ?? previous.conversationId;
    final updated = previous.copyWith(
      preview: preview,
      previewKind: kind,
      previewCount: count,
      timeLabel: AppStrings.now,
      lastMessageStatus: ChatMessageStatus.sent,
      conversationId: resolvedConversationId,
      unreadCount: 0,
      isPriority: false,
    );
    _threads = [
      updated,
      for (var i = 0; i < _threads.length; i++)
        if (i != idx) _threads[i],
    ];
    _sortPinnedFirst();
    _emitLoaded();
    // Stay on this Ably channel so message.delivered / message.read update ticks.
    _pinRealtimeConversation(resolvedConversationId);
  }

  Future<void> loadInbox({
    InboxFilter? filter,
    bool refresh = false,
    int? currentUserId,
    bool soft = false,
  }) async {
    if (filter != null) _filter = filter;
    // Home shell and the chats tab both start this on open.
    if (refresh && (_inboxPageRequestInFlight || _isRefreshing)) return;

    if (refresh) {
      _currentPage = 1;
      // Soft refresh keeps the previous last-page flag so a short list
      // doesn't trigger load-more while the request is in flight.
      if (!soft) {
        _isLastPage = false;
        _threads = [];
        _totalCount = null;
      }
    }
    final isPageOne = _currentPage == 1;
    if (isPageOne) {
      _inboxPageRequestInFlight = true;
      _lastRefreshTime = DateTime.now();
    }
    if (soft) {
      _emitLoaded(isRefreshing: true);
    } else if (refresh || _threads.isEmpty) {
      emit(const InboxState.loading());
    }

    try {
      await ChatMutePrefs.ensureLoaded();
      final result = await _getInboxUsecase.execute(
        GetInboxParams(
          filter: ChatMappers.inboxFilterParam(_filter),
          page: _currentPage,
        ),
      );

      result.fold(
        (failure) {
          if (soft) {
            _emitLoaded();
          } else {
            emit(InboxState.error(failure.message));
          }
        },
        (response) {
          final data = response.data;
          _applyInboxMeta(data);
          final items = data?.items ?? const [];
          final mapped = _withLivePresence(
            items.map(ChatMappers.toInboxThread).toList(),
          );
          _threads =
              refresh || _currentPage == 1 ? mapped : [..._threads, ...mapped];
          _sortPinnedFirst();

          _isLastPage =
              _resolveIsLastPage(data?.meta, fetchedCount: items.length);
          _totalCount = data?.meta?.total ?? _totalCount;

          _hasLoadedOnce = true;
          _emitLoaded();
          if (currentUserId != null) {
            unawaited(_syncRealtimeChannels(currentUserId));
          }
          // Re-sync live Online after API replace (API has no online flag).
          unawaited(_refreshAndReapplyAppPresence());
          _ackUnreadDelivered();
        },
      );
    } finally {
      if (isPageOne) _inboxPageRequestInFlight = false;
    }
  }

  /// Refresh without wiping UI / showing full-screen loader.
  /// Throttled: at most once per 10 seconds to avoid redundant API calls.
  ///
  /// [forceReadConversationId]: clear local unread for a thread the user just
  /// left (chat room). [bypassThrottle] when returning from a chat so the
  /// list reflects server read state immediately.
  Future<void> silentRefresh({
    int? currentUserId,
    int? forceReadConversationId,
    bool bypassThrottle = false,
  }) async {
    if (forceReadConversationId != null) {
      markConversationRead(forceReadConversationId);
    }
    if (_isRefreshing || _inboxPageRequestInFlight) return;
    final now = DateTime.now();
    if (!bypassThrottle &&
        _lastRefreshTime != null &&
        now.difference(_lastRefreshTime!).inSeconds < 10) {
      return;
    }
    _isRefreshing = true;
    _inboxPageRequestInFlight = true;
    _lastRefreshTime = now;
    _currentPage = 1;

    try {
      final result = await _getInboxUsecase.execute(
        GetInboxParams(
          filter: ChatMappers.inboxFilterParam(_filter),
          page: 1,
        ),
      );

      final uid = currentUserId ?? _currentUserId;

      result.fold(
        (_) {
          // Keep local read state if the API call failed.
          if (forceReadConversationId != null) {
            markConversationRead(forceReadConversationId);
          }
        },
        (response) {
          final data = response.data;
          _applyInboxMeta(data);
          final items = data?.items ?? const [];
          // Preserve live unread bumps that arrived during this refresh, then
          // merge API data. Do NOT force unread to 0 after sync — that made
          // messages received on the chats list look already read.
          final liveUnreadById = <int, int>{
            for (final t in _threads)
              if (t.conversationId != null && t.unreadCount > 0)
                t.conversationId!: t.unreadCount,
          };
          final liveStatusById = <int, ChatMessageStatus>{
            for (final t in _threads)
              if (t.conversationId != null && t.lastMessageStatus != null)
                t.conversationId!: t.lastMessageStatus!,
          };
          _threads = _withLivePresence(
            [
              for (final item in items)
                () {
                  final t = ChatMappers.toInboxThread(item);
                  final status = t.lastMessageStatus;
                  final cid = t.conversationId;
                  if (status == null || cid == null) return t;
                  return t.copyWith(
                    lastMessageStatus: _capOutgoingStatus(
                      cid,
                      status,
                      peerUserId: t.counterpartUserId,
                    ),
                  );
                }(),
            ],
          );
          if (liveUnreadById.isNotEmpty) {
            _threads = [
              for (final t in _threads)
                if (t.conversationId != null &&
                    liveUnreadById.containsKey(t.conversationId) &&
                    (liveUnreadById[t.conversationId!] ?? 0) > t.unreadCount)
                  t.copyWith(
                    unreadCount: liveUnreadById[t.conversationId!]!,
                    isPriority: true,
                  )
                else
                  t,
            ];
          }
          if (liveStatusById.isNotEmpty) {
            _threads = [
              for (final t in _threads)
                if (t.conversationId != null &&
                    liveStatusById.containsKey(t.conversationId))
                  _mergeLiveOutgoingStatus(
                    t,
                    liveStatusById[t.conversationId!]!,
                  )
                else
                  t,
            ];
          }
          _sortPinnedFirst();
          _isLastPage =
              _resolveIsLastPage(data?.meta, fetchedCount: items.length);
          _totalCount = data?.meta?.total ?? _totalCount;
          _emitLoaded();
          if (uid != null) {
            unawaited(_syncRealtimeChannels(uid));
          }
          // API wipe must not leave stale Offline — reapply Ably app presence.
          unawaited(_refreshAndReapplyAppPresence());
          _ackUnreadDelivered();
        },
      );
    } finally {
      _isRefreshing = false;
      _inboxPageRequestInFlight = false;
    }
  }

  Future<void> changeFilter(InboxFilter filter) {
    if (_filter == filter) return Future.value();
    _filter = filter;
    // Soft so filter switches keep the list and use the tabs progress bar.
    return loadInbox(refresh: true, soft: true);
  }

  Future<void> refresh() => loadInbox(refresh: true, soft: true);

  bool get _isSoftRefreshing => state.maybeWhen(
        loaded: (_, __, ___, ____, _____, ______, _______, isRefreshing) =>
            isRefreshing,
        orElse: () => false,
      );

  Future<void> loadMore() async {
    if (_isLastPage || _isLoadingMore || _isSoftRefreshing) return;
    _isLoadingMore = true;
    _emitLoaded(isLoadingMore: true);
    _currentPage += 1;

    final result = await _getInboxUsecase.execute(
      GetInboxParams(
        filter: ChatMappers.inboxFilterParam(_filter),
        page: _currentPage,
      ),
    );

    _isLoadingMore = false;

    result.fold(
      (failure) {
        _currentPage -= 1;
        // Keep existing threads; don't wipe the list on page-2 failure.
        _emitLoaded();
      },
      (response) {
        final data = response.data;
        _applyInboxMeta(data);
        final items = data?.items ?? const [];
        _threads = [
          ..._threads,
          ..._withLivePresence(items.map(ChatMappers.toInboxThread).toList()),
        ];
        _sortPinnedFirst();

        _isLastPage =
            _resolveIsLastPage(data?.meta, fetchedCount: items.length);
        _totalCount = data?.meta?.total ?? _totalCount;

        _emitLoaded();
        final uid = _currentUserId;
        if (uid != null) {
          _syncRealtimeChannels(uid);
        }
      },
    );
  }

  @override
  Future<void> close() {
    stopLiveUpdates();
    _realtimeSub?.cancel();
    for (final timer in _typingClearTimers.values) {
      timer.cancel();
    }
    _typingClearTimers.clear();
    archivedRevision.dispose();
    return super.close();
  }
}
