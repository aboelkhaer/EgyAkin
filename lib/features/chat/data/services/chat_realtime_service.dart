import 'dart:convert';

import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat/data/models/chat_composer_activity.dart';

import '../../../../exports.dart';

/// Ably presence channel events for a conversation.
sealed class ChatRealtimeEvent {
  const ChatRealtimeEvent();
}

class ChatMessageSentEvent extends ChatRealtimeEvent {
  final ChatMessageModel message;
  const ChatMessageSentEvent(this.message);
}

/// Peer (or this device on another session) edited a message's content.
class ChatMessageUpdatedEvent extends ChatRealtimeEvent {
  final ChatMessageModel message;
  const ChatMessageUpdatedEvent(this.message);
}

class ChatMessageDeletedEvent extends ChatRealtimeEvent {
  final int messageId;
  final int conversationId;
  const ChatMessageDeletedEvent({
    required this.messageId,
    required this.conversationId,
  });
}

class ChatMessageReactedEvent extends ChatRealtimeEvent {
  final int messageId;
  final int conversationId;
  final int? userId;
  final String? reaction;
  final String? action;
  const ChatMessageReactedEvent({
    required this.messageId,
    required this.conversationId,
    this.userId,
    this.reaction,
    this.action,
  });
}

class ChatMessageReadEvent extends ChatRealtimeEvent {
  final int conversationId;
  final int? userId;
  final int? lastReadMessageId;

  /// Server time of the read (`read_at`).
  final String? readAt;
  const ChatMessageReadEvent({
    required this.conversationId,
    this.userId,
    this.lastReadMessageId,
    this.readAt,
  });
}

class ChatMessageDeliveredEvent extends ChatRealtimeEvent {
  final int conversationId;
  final int? userId;

  /// Server time of the delivery (`delivered_at`). Events can arrive late, so
  /// the phone's clock is not a substitute.
  final String? deliveredAt;
  const ChatMessageDeliveredEvent({
    required this.conversationId,
    this.userId,
    this.deliveredAt,
  });
}

class ChatUserTypingEvent extends ChatRealtimeEvent {
  final int conversationId;
  final int? userId;
  final String? userName;
  final bool isTyping;
  final ChatComposerActivity activity;

  /// Presence updates carry explicit activity (incl. clear). Typing REST does not.
  final bool fromPresence;
  const ChatUserTypingEvent({
    required this.conversationId,
    this.userId,
    this.userName,
    required this.isTyping,
    this.activity = ChatComposerActivity.typing,
    this.fromPresence = false,
  });
}

/// Peer entered/left the conversation presence channel (in-chat).
class ChatPresenceChangedEvent extends ChatRealtimeEvent {
  final int conversationId;
  final int? userId;
  final String? clientId;
  final bool isOnline;
  const ChatPresenceChangedEvent({
    required this.conversationId,
    required this.isOnline,
    this.userId,
    this.clientId,
  });
}

/// `inbox.updated` on the user's private channel: a new message in one of the
/// user's chats. The server does not send it for muted chats.
class ChatInboxUpdatedEvent extends ChatRealtimeEvent {
  final int conversationId;

  /// Normalized [ChatApiType] value.
  final String? chatType;

  /// Id to open the chat with.
  final int? contextId;
  final String? conversationName;

  /// Already translated by the server, no brackets (e.g. "Photo" / "صورة").
  final String? messagePreview;
  final int? messageId;
  final int? senderId;
  final String? senderName;
  final String? createdAt;
  const ChatInboxUpdatedEvent({
    required this.conversationId,
    this.chatType,
    this.contextId,
    this.conversationName,
    this.messagePreview,
    this.messageId,
    this.senderId,
    this.senderName,
    this.createdAt,
  });
}

/// Peer entered/left the app-wide online channel (any screen in the app).
class ChatAppPresenceChangedEvent extends ChatRealtimeEvent {
  final int userId;
  final bool isOnline;
  const ChatAppPresenceChangedEvent({
    required this.userId,
    required this.isOnline,
  });
}

class _ChannelBinding {
  final ably.RealtimeChannel channel;
  final StreamSubscription<ably.Message> subscription;
  StreamSubscription<ably.PresenceMessage>? presenceSubscription;
  bool isActiveChat;
  bool hasEnteredPresence;

  _ChannelBinding({
    required this.channel,
    required this.subscription,
    required this.isActiveChat,
    required this.hasEnteredPresence,
  });
}

/// Ably realtime for chat:
/// - `presence:app` — Online = member of this channel (enter on open/resume,
///   leave on background; no periodic updates),
/// - `private:App.Models.User.{id}` — `inbox.updated` for any chat,
/// - `presence:conversation.{id}` — the open chat room (presence entered), or
///   listen-only for the top rows while the Chats list is on screen, so they
///   update live and show typing / recording / sending.
class ChatRealtimeService with WidgetsBindingObserver {
  ChatRealtimeService(this._apiServices) {
    WidgetsBinding.instance.addObserver(this);
  }

  final ApiServices _apiServices;

  /// App-wide online channel (token grants `subscribe` + `presence`).
  static const appPresenceChannel = 'presence:app';

  static String userChannelName(int userId) => 'private:App.Models.User.$userId';

  static String conversationChannelName(int conversationId) =>
      'presence:conversation.$conversationId';

  /// Ably removes a connection that dropped without a leave after this long.
  static const _remainPresentForMs = '15000';

  /// Ably minimum. Protocol heartbeats are not billed as messages.
  static const _heartbeatIntervalMs = '5000';

  /// Offline only after a leave plus this grace, so a quick reconnect or
  /// app switch never flashes Offline.
  static const _appOfflineGrace = Duration(seconds: 2);
  static const _presenceGetTimeout = Duration(seconds: 4);

  /// Brief app switches must not leave presence (and reconnect afterwards).
  static const _backgroundLeaveDelay = Duration(seconds: 1);

  static const _presenceWatchdogEvery = Duration(seconds: 5);
  static const _minPresenceRepairBackoff = Duration(seconds: 3);
  static const _maxPresenceRepairBackoff = Duration(seconds: 30);

  ably.Realtime? _realtime;
  StreamSubscription<ably.ConnectionStateChange>? _connectionStateSubscription;
  final _eventsController = StreamController<ChatRealtimeEvent>.broadcast();

  /// Client the app-wide channels were created on. Channel objects of a
  /// closed / failed client can still read "attached" in Dart.
  ably.Realtime? _appChannelsRealtime;

  ably.RealtimeChannel? _appPresenceChannel;
  ably.RealtimeChannel? _appPresenceSubscribedChannel;
  StreamSubscription<ably.PresenceMessage>? _appPresenceSubscription;
  bool _hasEnteredAppPresence = false;
  Future<void>? _ensureAppPresenceFuture;

  ably.RealtimeChannel? _userChannel;
  ably.RealtimeChannel? _userChannelSubscribedChannel;
  StreamSubscription<ably.Message>? _userChannelSubscription;

  /// Capability string in use when Ably refused the user channel (40160).
  /// Not retried until the token capability changes.
  String? _userChannelDeniedForCapability;

  final Map<int, _ChannelBinding> _bindings = {};
  int? _activeChatConversationId;
  Future<void>? _subscribeFuture;
  int? _subscribeFutureConversationId;

  /// Conversations the Chats list wants to hear from while it is on screen
  /// (listen-only: messages, receipts, typing / recording / upload activity —
  /// never a presence enter). Suspended while a chat room is open.
  Set<int> _inboxListenIds = const {};
  Future<void>? _inboxSyncFuture;
  bool _inboxSyncQueued = false;

  /// Raw capability from the last token.
  String? _lastCapability;

  /// Conversations the current token cannot access (Ably 40160).
  final Set<int> _capabilityDeniedConversationIds = {};

  final Set<int> _appOnlineUserIds = {};

  /// Live `presence:app` memberships per user (`connectionId|clientId`). Ably
  /// sends one leave per connection, so a second device or a stale
  /// connection must not grey out a present peer.
  final Map<int, Set<String>> _appOnlineMembersByUser = {};
  final Map<String, int> _appPresenceClientToUserId = {};
  final Map<int, Timer> _pendingAppOfflineChecks = {};

  /// Leave events often omit presence data — map clientId → userId from enters.
  final Map<String, int> _presenceClientToUserId = {};

  /// Online user ids per open conversation channel (in-chat presence).
  final Map<int, Set<int>> _lastOnlineByConversation = {};

  int? _presenceUserId;
  String? _presenceDisplayName;
  String? _presenceImageUrl;

  /// Composer activity last published on the open chat's presence.
  ChatComposerActivity _localComposerActivity = ChatComposerActivity.none;

  Future<void>? _connectFuture;
  Future<void>? _authorizeFuture;
  DateTime? _lastAuthorizeTime;

  Timer? _backgroundLeaveTimer;
  bool _isLeavingForBackground = false;

  /// False from hidden/paused until resumed — nothing re-enters presence for
  /// a backgrounded app.
  bool _appInForeground = true;
  Timer? _presenceWatchdogTimer;
  Duration _presenceRepairBackoff = _minPresenceRepairBackoff;
  Future<void>? _presenceRepairFuture;
  DateTime? _lastPresenceRepairAt;
  int _resumeInFlight = 0;
  bool _lifecycleAttached = true;

  /// Bumped on every lifecycle transition so an in-flight [onAppPaused] cannot
  /// close a connection that [onAppResumed] already rebuilt.
  int _lifecycleEpoch = 0;

  Stream<ChatRealtimeEvent> get events => _eventsController.stream;

  int? get subscribedConversationId => _activeChatConversationId;

  /// True only while a chat room screen is open for this conversation.
  bool isViewingConversation(int conversationId) =>
      _activeChatConversationId == conversationId;

  /// This conversation's own channel is attached (open chat or a Chats-list
  /// listener), so its `message.sent` already reaches the inbox.
  bool isReceivingConversation(int conversationId) =>
      _bindings[conversationId]?.channel.state == ably.ChannelState.attached;

  /// Whether [userId] is in the open chat's presence (inside that chat room).
  bool isUserPresentInConversation(int conversationId, int userId) {
    final members = _lastOnlineByConversation[conversationId];
    return members != null && members.contains(userId);
  }

  /// App-wide online (any screen), not conversation presence.
  bool isUserAppOnline(int userId) => _appOnlineUserIds.contains(userId);

  /// True after a successful app-online enter (any screen).
  bool get hasEnteredAppPresence => _hasEnteredAppPresence;

  Set<int> get appOnlineUserIds => Set.unmodifiable(_appOnlineUserIds);

  /// Enter `presence:app` from the local session (Splash / Home / deep link /
  /// post-login). Safe to call repeatedly.
  Future<void> bootstrapFromLocalSession({bool forceReenter = true}) async {
    final lifecycle = WidgetsBinding.instance.lifecycleState;
    if (lifecycle == AppLifecycleState.paused ||
        lifecycle == AppLifecycleState.detached ||
        lifecycle == AppLifecycleState.hidden) {
      return;
    }

    try {
      final doctor = await sl<AppPreferences>().getDoctorData();
      final userId = doctor?.id ?? 0;
      if (userId == 0) return;

      final displayName = doctorName(
        firstName: doctor?.firstName,
        lastName: doctor?.lastName,
        role: '',
      );

      await ensureAppPresence(
        currentUserId: userId,
        displayName: displayName,
        imageUrl: doctor?.image,
        forceReenter: forceReenter,
      );
    } catch (e) {
      debugPrint('Ably bootstrapFromLocalSession failed: $e');
    }
  }

  /// Chat room closed (dispose / pop). Leaves the chat's presence and drops
  /// its channel right away so we are never "in the chat" from the Chats list.
  /// With [conversationId], only clears when that chat is the open one (a
  /// room closing underneath another room must not clear the top one).
  void clearActiveChat({int? conversationId}) {
    final id = _activeChatConversationId;
    if (conversationId != null && id != conversationId) return;
    _activeChatConversationId = null;
    _localComposerActivity = ChatComposerActivity.none;
    if (id != null) unawaited(_releaseChat(id));
  }

  /// Leave a closed chat's presence. Its channel stays attached (listen-only)
  /// when the Chats list wants it, otherwise it is detached. Then the list's
  /// other listeners come back.
  Future<void> _releaseChat(int conversationId) async {
    if (!_isOpen(conversationId)) {
      if (_inboxListenIds.contains(conversationId)) {
        await _downgradeToListener(conversationId);
      } else {
        await _detachChannel(conversationId);
      }
    }
    unawaited(_syncInboxListeners());
  }

  Future<void> _downgradeToListener(int conversationId) async {
    final binding = _bindings[conversationId];
    if (binding == null || _isOpen(conversationId)) return;
    binding.isActiveChat = false;
    if (!binding.hasEnteredPresence) return;
    binding.hasEnteredPresence = false;
    try {
      await binding.channel.presence.leave();
    } catch (e) {
      debugPrint('Ably presence leave (chat closed) failed: $e');
    }
  }

  /// Chats list on screen: listen to these conversations so rows update live
  /// and show typing / recording / sending. Only the open chat's channel is
  /// kept while a chat room is open; the listeners return when it closes.
  Future<void> listenToInboxConversations(Iterable<int> conversationIds) {
    _inboxListenIds = conversationIds.toSet();
    return _syncInboxListeners();
  }

  Future<void> stopListeningToInbox() {
    _inboxListenIds = const {};
    return _syncInboxListeners();
  }

  Future<void> _syncInboxListeners() {
    final running = _inboxSyncFuture;
    if (running != null) {
      _inboxSyncQueued = true;
      return running;
    }
    final future = () async {
      try {
        do {
          _inboxSyncQueued = false;
          await _doSyncInboxListeners();
        } while (_inboxSyncQueued);
      } finally {
        _inboxSyncFuture = null;
      }
    }();
    _inboxSyncFuture = future;
    return future;
  }

  Future<void> _doSyncInboxListeners() async {
    final userId = _presenceUserId;
    final wanted = (_activeChatConversationId == null &&
            _appInForeground &&
            userId != null)
        ? _inboxListenIds
        : const <int>{};

    for (final id in _bindings.keys.toList()) {
      final binding = _bindings[id];
      if (binding == null || binding.isActiveChat) continue;
      if (id == _activeChatConversationId) continue;
      final healthy = binding.channel.state == ably.ChannelState.attached ||
          binding.channel.state == ably.ChannelState.attaching;
      if (!wanted.contains(id) || !healthy) await _detachChannel(id);
    }
    if (wanted.isEmpty || userId == null) return;

    await _ensureConnected(clientId: '$userId');
    if (_realtime?.connection.state != ably.ConnectionState.connected) return;
    for (final id in wanted.toList()) {
      if (_activeChatConversationId != null) return;
      if (!_inboxListenIds.contains(id) || _bindings.containsKey(id)) continue;
      await _attachListener(id);
    }
  }

  Future<void> _attachListener(int conversationId) async {
    if (!_tokenAllowsConversation(conversationId)) return;
    final name = conversationChannelName(conversationId);
    final ably.RealtimeChannel channel;
    try {
      channel = await _freshChannel(name);
    } catch (_) {
      return;
    }
    // Subscribe before attaching so the presence sync's members (and any
    // activity they already have) reach the list.
    final sub = channel.subscribe().listen(
          (msg) => _onMessage(msg, conversationId: conversationId),
          onError: (Object e) => debugPrint('Ably subscribe error: $e'),
        );
    final presenceSub = channel.presence.subscribe().listen(
          (msg) => _emitPresence(conversationId, msg),
          onError: (Object e) => debugPrint('Ably presence error: $e'),
        );
    try {
      await _attachOrRecoverChannel(channel);
    } catch (e) {
      unawaited(sub.cancel());
      unawaited(presenceSub.cancel());
      if (_isCapabilityDeniedError(e)) {
        _capabilityDeniedConversationIds.add(conversationId);
      } else {
        debugPrint('Ably inbox listen failed ($conversationId): $e');
      }
      if (channel.state == ably.ChannelState.failed) {
        try {
          _realtime?.channels.release(name);
        } catch (_) {}
      }
      return;
    }

    final stillWanted = _activeChatConversationId == null &&
        _inboxListenIds.contains(conversationId) &&
        !_bindings.containsKey(conversationId);
    if (!stillWanted) {
      unawaited(sub.cancel());
      unawaited(presenceSub.cancel());
      // The open chat may own this same channel object now.
      if (_activeChatConversationId != conversationId &&
          !_bindings.containsKey(conversationId)) {
        await _detach(channel);
      }
      return;
    }
    _bindings[conversationId] = _ChannelBinding(
      channel: channel,
      subscription: sub,
      isActiveChat: false,
      hasEnteredPresence: false,
    )..presenceSubscription = presenceSub;
  }

  /// Join the app-wide online channel and the user's inbox channel.
  ///
  /// [forceReenter] verifies our own membership in the local presence set and
  /// re-enters only if Ably dropped it — never a blind re-publish.
  Future<void> ensureAppPresence({
    required int currentUserId,
    String? displayName,
    String? imageUrl,
    bool forceReenter = false,
  }) async {
    _presenceUserId = currentUserId;
    if (displayName != null) _presenceDisplayName = displayName;
    if (imageUrl != null) _presenceImageUrl = imageUrl;
    _startPresenceWatchdog();

    final existing = _ensureAppPresenceFuture;
    if (existing != null) {
      await existing;
      if (_hasEnteredAppPresence && !forceReenter) return;
    }

    final future = _doEnsureAppPresence(
      currentUserId: currentUserId,
      verifySelf: forceReenter,
    );
    _ensureAppPresenceFuture = future;
    try {
      await future;
    } finally {
      if (identical(_ensureAppPresenceFuture, future)) {
        _ensureAppPresenceFuture = null;
      }
    }
  }

  Future<void> _doEnsureAppPresence({
    required int currentUserId,
    required bool verifySelf,
  }) async {
    // Online means the app is open — never (re)enter from the background.
    if (!_appInForeground) return;

    await _ensureConnected(clientId: '$currentUserId');
    await _authorizeIfNeeded();
    final realtime = _realtime;
    if (realtime == null || !_appInForeground) return;
    if (realtime.connection.state != ably.ConnectionState.connected) return;
    if (!identical(_appChannelsRealtime, realtime)) {
      _discardAppChannels();
      _appChannelsRealtime = realtime;
    }

    await _ensureUserChannel(currentUserId);
    await _attachAndEnterAppPresence(verifySelf: verifySelf);
    // The Chats list may have asked before we knew the user / had a client.
    unawaited(_syncInboxListeners());
  }

  Future<bool> _attachAndEnterAppPresence({required bool verifySelf}) async {
    try {
      var channel = _appPresenceChannel;
      final healthy = channel != null &&
          identical(_appChannelsRealtime, _realtime) &&
          channel.state == ably.ChannelState.attached &&
          _hasEnteredAppPresence;
      if (healthy && !verifySelf) return true;

      if (channel == null ||
          channel.state == ably.ChannelState.failed ||
          channel.state == ably.ChannelState.detached) {
        channel = await _freshChannel(appPresenceChannel);
        _appPresenceChannel = channel;
      }
      await _attachOrRecoverChannel(channel);
      if (channel.state != ably.ChannelState.attached) {
        throw StateError(
          'Ably $appPresenceChannel not attached (state=${channel.state.name})',
        );
      }

      // A released / recreated channel is a new object; the old subscription
      // never fires again.
      if (!identical(_appPresenceSubscribedChannel, channel)) {
        unawaited(_appPresenceSubscription?.cancel());
        _appPresenceSubscription = channel.presence.subscribe().listen(
              _onAppPresenceMessage,
              onError: (_) {},
            );
        _appPresenceSubscribedChannel = channel;
      }

      var needEnter = !_hasEnteredAppPresence;
      if (!needEnter && verifySelf) {
        needEnter = !await _isSelfListed(channel);
      }
      if (needEnter) {
        if (!_appInForeground) return false;
        await channel.presence.enter(
          _presencePayload(activity: ChatComposerActivity.none),
        );
        _hasEnteredAppPresence = true;
        // Our own enter echo can land after this get(); the roster is only
        // trusted for removals once it lists us, so read it again shortly.
        Timer(const Duration(milliseconds: 1500), () {
          unawaited(refreshAppPresenceSnapshot());
        });
      }
      await _syncAppRoster(channel);
      return true;
    } catch (e) {
      debugPrint('Ably $appPresenceChannel attach/enter failed: $e');
      return false;
    }
  }

  /// Local presence set only — no Ably messages.
  Future<bool> _isSelfListed(ably.RealtimeChannel channel) async {
    final self = _presenceUserId;
    if (self == null) return false;
    try {
      final members = await channel.presence
          .get(const ably.RealtimePresenceParams(waitForSync: true))
          .timeout(_presenceGetTimeout);
      final connectionId = _realtime?.connection.id;
      return members.any(
        (m) =>
            _userIdFromPresence(m) == self &&
            (connectionId == null || m.connectionId == connectionId),
      );
    } catch (_) {
      // Can't tell — assume present rather than re-publish.
      return true;
    }
  }

  /// Release Failed/Detached channel instances so the next attach works.
  Future<ably.RealtimeChannel> _freshChannel(String channelName) async {
    final realtime = _realtime!;
    try {
      final existing = realtime.channels.get(channelName);
      final state = existing.state;
      if (state == ably.ChannelState.failed ||
          state == ably.ChannelState.detached) {
        try {
          // ably_flutter release is sync void — do not await.
          realtime.channels.release(channelName);
        } catch (_) {}
      }
    } catch (_) {}
    return realtime.channels.get(channelName);
  }

  /// Re-read the `presence:app` member list (local; no Ably messages).
  Future<void> refreshAppPresenceSnapshot() async {
    final channel = _appPresenceChannel;
    if (channel == null || !_hasEnteredAppPresence) return;
    if (channel.state != ably.ChannelState.attached) return;
    await _syncAppRoster(channel);
  }

  /// Marks everyone in the roster Online. When the roster is complete (it
  /// lists our own membership), also starts the Offline check for peers it no
  /// longer lists — their leave was missed while we were disconnected.
  Future<void> _syncAppRoster(ably.RealtimeChannel channel) async {
    final List<ably.PresenceMessage> members;
    try {
      members = await channel.presence
          .get(const ably.RealtimePresenceParams(waitForSync: true))
          .timeout(_presenceGetTimeout);
    } catch (_) {
      return;
    }
    final self = _presenceUserId;
    final roster = <int, Set<String>>{};
    var includesSelf = false;
    for (final msg in members) {
      final userId = _userIdFromPresence(msg);
      if (userId == null) continue;
      if (userId == self) {
        includesSelf = true;
        continue;
      }
      final clientId = msg.clientId;
      if (clientId != null) _appPresenceClientToUserId[clientId] = userId;
      roster.putIfAbsent(userId, () => <String>{}).add(_appMemberKey(msg));
    }

    roster.forEach((userId, keys) {
      for (final key in keys) {
        _markAppMemberPresent(userId, key);
      }
    });
    if (!includesSelf) return;

    for (final userId in _appOnlineUserIds.toList()) {
      final keys = _appOnlineMembersByUser[userId];
      keys?.removeWhere((key) => !(roster[userId]?.contains(key) ?? false));
      if (keys == null || keys.isEmpty) _scheduleAppOfflineCheck(userId);
    }
  }

  void _onAppPresenceMessage(ably.PresenceMessage msg) {
    final action = msg.action;
    final isOnline = action == ably.PresenceAction.enter ||
        action == ably.PresenceAction.present ||
        action == ably.PresenceAction.update;
    final isOffline = action == ably.PresenceAction.leave ||
        action == ably.PresenceAction.absent;
    if (!isOnline && !isOffline) return;

    final clientId = msg.clientId;
    var userId = _userIdFromPresence(msg);
    if (userId != null && clientId != null) {
      _appPresenceClientToUserId[clientId] = userId;
    } else if (userId == null && clientId != null) {
      userId = _appPresenceClientToUserId[clientId];
    }
    if (userId == null || userId == _presenceUserId) return;

    final memberKey = _appMemberKey(msg);
    if (isOnline) {
      _markAppMemberPresent(userId, memberKey);
      return;
    }

    final members = _appOnlineMembersByUser[userId];
    members?.remove(memberKey);
    if (members != null && members.isNotEmpty) return;
    _scheduleAppOfflineCheck(userId);
  }

  static String _appMemberKey(ably.PresenceMessage msg) =>
      '${msg.connectionId ?? ''}|${msg.clientId ?? ''}';

  void _markAppMemberPresent(int userId, String memberKey) {
    _pendingAppOfflineChecks.remove(userId)?.cancel();
    _appOnlineMembersByUser
        .putIfAbsent(userId, () => <String>{})
        .add(memberKey);
    if (!_appOnlineUserIds.add(userId)) return;
    _eventsController.add(
      ChatAppPresenceChangedEvent(userId: userId, isOnline: true),
    );
  }

  void _scheduleAppOfflineCheck(int userId) {
    if (!_appOnlineUserIds.contains(userId)) return;
    _pendingAppOfflineChecks[userId] ??= Timer(_appOfflineGrace, () {
      _pendingAppOfflineChecks.remove(userId);
      unawaited(_confirmAppOffline(userId));
    });
  }

  Future<void> _confirmAppOffline(int userId) async {
    bool stillListed() =>
        _appOnlineMembersByUser[userId]?.isNotEmpty ?? false;
    if (stillListed() || !_appOnlineUserIds.contains(userId)) return;

    // A newer connection may be present without us having seen its enter.
    final channel = _appPresenceChannel;
    final live = channel != null &&
        identical(_appChannelsRealtime, _realtime) &&
        channel.state == ably.ChannelState.attached;
    if (!live) {
      // Our own connection is down — keep the last known state; the roster
      // sync after reconnect settles it.
      if (_appInForeground) _scheduleAppOfflineCheck(userId);
      return;
    }
    try {
      final members = await channel.presence
          .get(const ably.RealtimePresenceParams(waitForSync: true))
          .timeout(_presenceGetTimeout);
      for (final msg in members) {
        if (_userIdFromPresence(msg) != userId) continue;
        _markAppMemberPresent(userId, _appMemberKey(msg));
      }
    } catch (_) {
      if (_appInForeground) _scheduleAppOfflineCheck(userId);
      return;
    }
    if (stillListed() || _pendingAppOfflineChecks.containsKey(userId)) return;
    _setAppUserOffline(userId);
  }

  void _setAppUserOffline(int userId) {
    _pendingAppOfflineChecks.remove(userId)?.cancel();
    _appOnlineMembersByUser.remove(userId);
    if (!_appOnlineUserIds.remove(userId)) return;
    _eventsController.add(
      ChatAppPresenceChangedEvent(userId: userId, isOnline: false),
    );
  }

  void _cancelPendingAppOfflineChecks() {
    for (final timer in _pendingAppOfflineChecks.values) {
      timer.cancel();
    }
    _pendingAppOfflineChecks.clear();
  }

  Future<void> _ensureUserChannel(int userId) async {
    final realtime = _realtime;
    if (realtime == null ||
        realtime.connection.state != ably.ConnectionState.connected) {
      return;
    }
    final denied = _userChannelDeniedForCapability;
    if (denied != null && denied == (_lastCapability ?? '')) return;

    final name = userChannelName(userId);
    var channel = _userChannel;
    if (channel != null &&
        channel.name == name &&
        identical(_userChannelSubscribedChannel, channel) &&
        channel.state == ably.ChannelState.attached) {
      return;
    }
    try {
      if (channel != null && channel.name != name) {
        // Different account on this client.
        unawaited(_userChannelSubscription?.cancel());
        _userChannelSubscription = null;
        _userChannelSubscribedChannel = null;
        final old = channel;
        unawaited(_detach(old));
        channel = null;
      }
      if (channel == null ||
          channel.state == ably.ChannelState.failed ||
          channel.state == ably.ChannelState.detached) {
        channel = await _freshChannel(name);
      }
      _userChannel = channel;
      if (!identical(_userChannelSubscribedChannel, channel)) {
        unawaited(_userChannelSubscription?.cancel());
        _userChannelSubscription = channel.subscribe().listen(
              _onUserChannelMessage,
              onError: (Object e) => debugPrint('Ably user channel error: $e'),
            );
        _userChannelSubscribedChannel = channel;
      }
      await _attachOrRecoverChannel(channel);
      _userChannelDeniedForCapability = null;
      debugPrint('Ably $name attached — listening for inbox.updated');
    } catch (e) {
      if (_isCapabilityDeniedError(e)) {
        _userChannelDeniedForCapability = _lastCapability ?? '';
        debugPrint('Ably $name not granted by token — inbox stays on GET /inbox');
        return;
      }
      debugPrint('Ably user channel attach failed: $e');
    }
  }

  void _onUserChannelMessage(ably.Message message) {
    final name = message.name;
    final data = _asMap(message.data);
    if (name == null || data == null) return;
    switch (name) {
      case 'inbox.updated':
        final conversationId = _asInt(data['conversation_id']);
        debugPrint('Ably inbox.updated conversation=$conversationId');
        if (conversationId == null) return;
        _eventsController.add(
          ChatInboxUpdatedEvent(
            conversationId: conversationId,
            chatType: ChatApiType.fromApi(
              (data['conversation_type'] ?? data['chat_type'])?.toString(),
            ),
            contextId: _asInt(data['context_id']),
            conversationName: data['conversation_name']?.toString(),
            messagePreview: data['message_preview']?.toString(),
            messageId: _asInt(data['message_id']),
            senderId: _asInt(data['sender_id']),
            senderName: data['sender_name']?.toString(),
            createdAt: data['created_at']?.toString(),
          ),
        );
      case 'message.read':
      case 'message.delivered':
        final conversationId = _asInt(data['conversation_id']);
        if (conversationId == null) return;
        _onMessage(message, conversationId: conversationId);
      default:
        debugPrint('Ably user channel event ignored: $name');
    }
  }

  static bool _capabilityAllowsChannel(String? capability, String channelName) {
    if (capability == null || capability.trim().isEmpty) return false;

    dynamic decoded;
    try {
      decoded = jsonDecode(capability);
      if (decoded is String) {
        decoded = jsonDecode(decoded);
      }
    } catch (_) {
      return capability.contains(channelName) ||
          capability.contains('presence:conversation.') ||
          capability.contains('presence:*') ||
          capability.contains('"*":') ||
          capability.contains('"*"');
    }

    if (decoded is! Map) return false;
    for (final key in decoded.keys) {
      if (_channelMatchesCapabilityResource(channelName, key.toString())) {
        return true;
      }
    }
    return false;
  }

  static bool _channelMatchesCapabilityResource(
    String channelName,
    String resource,
  ) {
    if (resource == '*' || resource == '[*]*' || resource == '*:*') {
      return true;
    }
    if (resource == channelName) return true;
    // Ably prefix wildcard: "presence:conversation.*" → presence:conversation.46
    if (resource.endsWith('*')) {
      final prefix = resource.substring(0, resource.length - 1);
      return channelName.startsWith(prefix);
    }
    return false;
  }

  bool _tokenAllowsConversation(int conversationId) {
    if (_capabilityDeniedConversationIds.contains(conversationId)) {
      return false;
    }
    // Never seen a capability string — allow the attempt; denial is
    // handled on 40160.
    final cap = _lastCapability;
    if (cap == null || cap.trim().isEmpty) return true;
    return _capabilityAllowsChannel(
        cap, conversationChannelName(conversationId));
  }

  void _rememberCapability(String? capability) {
    final previous = _lastCapability;
    _lastCapability = capability;
    if (capability == null || capability.isEmpty || capability == previous) {
      return;
    }
    // A new token may grant channels that were refused before.
    _userChannelDeniedForCapability = null;
    _capabilityDeniedConversationIds.removeWhere(
      (id) => _capabilityAllowsChannel(capability, conversationChannelName(id)),
    );
  }

  /// Only Ably's capability refusal. A generic 401 (e.g. expired token) must
  /// not mark a channel as denied.
  static bool _isCapabilityDeniedError(Object e) {
    final s = e.toString();
    return s.contains('40160') ||
        s.contains('denied access based on given capability');
  }

  Future<ably.TokenRequest> _fetchTokenRequest(
      ably.TokenParams /* unused */ _) async {
    final model = await _apiServices.getAblyToken();
    _rememberCapability(model.capability);
    return ably.TokenRequest.fromMap(<String, dynamic>{
      if (model.keyName != null) 'keyName': model.keyName,
      if (model.ttl != null) 'ttl': model.ttl,
      if (model.capability != null) 'capability': model.capability,
      if (model.clientId != null) 'clientId': model.clientId,
      if (model.timestamp != null) 'timestamp': model.timestamp,
      if (model.nonce != null) 'nonce': model.nonce,
      if (model.mac != null) 'mac': model.mac,
    });
  }

  Future<void> _ensureConnected({String? clientId}) async {
    if (_realtime != null) {
      final state = _realtime!.connection.state;
      if (state == ably.ConnectionState.connected) {
        return;
      }
      if (state == ably.ConnectionState.connecting) {
        if (_connectFuture != null) {
          await _connectFuture;
        } else {
          await _waitForConnectionConnected();
        }
        if (_realtime?.connection.state == ably.ConnectionState.connected) {
          return;
        }
        // Stuck Connecting with no in-flight owner — recreate below.
        if (_connectFuture == null) {
          await _discardDeadRealtime();
        }
      } else if (state == ably.ConnectionState.disconnected ||
          state == ably.ConnectionState.suspended) {
        try {
          await _realtime!.connection.connect();
          await _waitForConnectionConnected();
          if (_realtime?.connection.state == ably.ConnectionState.connected) {
            return;
          }
        } catch (e) {
          debugPrint('Ably reconnect failed: $e');
        }
        // Reconnect timed out / failed — recreate so authCallback runs clean.
        await _discardDeadRealtime();
      } else if (state == ably.ConnectionState.closing ||
          state == ably.ConnectionState.closed ||
          state == ably.ConnectionState.failed) {
        await _discardDeadRealtime();
      }
    }

    if (_realtime?.connection.state == ably.ConnectionState.connected) {
      return;
    }

    if (_connectFuture != null) {
      await _connectFuture;
      if (_realtime?.connection.state == ably.ConnectionState.connected) {
        return;
      }
      await _waitForConnectionConnected();
      if (_realtime?.connection.state == ably.ConnectionState.connected) {
        return;
      }
      // Shared connect did not finish connected — try a fresh client.
      if (_connectFuture == null) {
        await _discardDeadRealtime();
      } else {
        return;
      }
    }

    if (_realtime?.connection.state == ably.ConnectionState.connected) {
      return;
    }

    _connectFuture = _doConnect(clientId);
    try {
      await _connectFuture;
    } finally {
      _connectFuture = null;
    }
  }

  Future<void> _discardDeadRealtime() async {
    final dead = _realtime;
    if (dead == null) return;
    _discardRealtimeBoundState();
    _lastAuthorizeTime = null;
    try {
      await dead.close();
    } catch (_) {}
    if (identical(_realtime, dead)) _realtime = null;
  }

  Future<void> _waitForConnectionConnected({
    Duration timeout = const Duration(seconds: 10),
  }) async {
    final realtime = _realtime;
    if (realtime == null) return;
    if (realtime.connection.state == ably.ConnectionState.connected) return;
    try {
      await realtime.connection
          .on(ably.ConnectionEvent.connected)
          .first
          .timeout(timeout);
    } catch (e) {
      debugPrint('Ably wait-for-connected: $e');
    }
  }

  Future<void> _doConnect(String? clientId) async {
    final options = ably.ClientOptions(
      autoConnect: true,
      clientId: clientId,
      authCallback: _fetchTokenRequest,
      transportParams: const {
        'remainPresentFor': _remainPresentForMs,
        'heartbeatInterval': _heartbeatIntervalMs,
      },
    );
    final realtime = ably.Realtime(options: options);
    _realtime = realtime;
    _watchConnection(realtime);

    await _waitForConnectionConnected();
    // The connection already fetched a token via authCallback.
    if (_realtime?.connection.state == ably.ConnectionState.connected) {
      _lastAuthorizeTime = DateTime.now();
    }
  }

  /// Ably re-attaches channels and re-enters presence by itself after a
  /// drop; re-read the roster once it's back, and rebuild the client if the
  /// connection failed (it never recovers from Failed on its own).
  void _watchConnection(ably.Realtime realtime) {
    unawaited(_connectionStateSubscription?.cancel());
    var connectedBefore = false;
    _connectionStateSubscription = realtime.connection.on().listen(
      (change) {
        if (!identical(realtime, _realtime)) return;
        switch (change.current) {
          case ably.ConnectionState.connected:
            if (connectedBefore) unawaited(refreshAppPresenceSnapshot());
            connectedBefore = true;
          case ably.ConnectionState.failed:
            unawaited(
              _repairPresence('connection failed: ${change.reason?.message}'),
            );
          default:
            break;
        }
      },
      onError: (_) {},
    );
  }

  /// App-wide channels and their subscriptions die with their client.
  void _discardAppChannels() {
    unawaited(_appPresenceSubscription?.cancel());
    unawaited(_userChannelSubscription?.cancel());
    _appPresenceSubscription = null;
    _userChannelSubscription = null;
    _appPresenceSubscribedChannel = null;
    _userChannelSubscribedChannel = null;
    _appPresenceChannel = null;
    _userChannel = null;
    _appChannelsRealtime = null;
    _hasEnteredAppPresence = false;
  }

  /// Before replacing a closed / failed client: drop everything bound to it
  /// so the next attach runs on the new connection. The open chat id is kept
  /// and re-attached by [onAppResumed].
  void _discardRealtimeBoundState() {
    unawaited(_connectionStateSubscription?.cancel());
    _connectionStateSubscription = null;
    _discardAppChannels();
    for (final binding in _bindings.values) {
      unawaited(binding.presenceSubscription?.cancel());
      unawaited(binding.subscription.cancel());
    }
    _bindings.clear();
    _lastOnlineByConversation.clear();
  }

  /// Rate-limited authorize — at most once per 30 seconds.
  ///
  /// Only when already Connected. Calling `auth.authorize()` while
  /// disconnected makes ably_flutter return [ErrorInfo] where Dart expects
  /// [TokenDetails] (`type 'ErrorInfo' is not a subtype of type 'TokenDetails?'`).
  /// Reconnect via [_ensureConnected] / authCallback instead.
  Future<void> _authorizeIfNeeded() async {
    final realtime = _realtime;
    if (realtime == null ||
        realtime.connection.state != ably.ConnectionState.connected) {
      return;
    }
    final now = DateTime.now();
    if (_lastAuthorizeTime != null &&
        now.difference(_lastAuthorizeTime!).inSeconds < 30) {
      return;
    }
    if (_authorizeFuture != null) {
      await _authorizeFuture;
      return;
    }
    _authorizeFuture = _doAuthorize();
    try {
      await _authorizeFuture;
    } finally {
      _authorizeFuture = null;
    }
  }

  Future<void> _doAuthorize() async {
    final realtime = _realtime;
    if (realtime == null ||
        realtime.connection.state != ably.ConnectionState.connected) {
      return;
    }
    try {
      await realtime.auth.authorize();
      _lastAuthorizeTime = DateTime.now();
    } catch (e) {
      // ably_flutter iOS returns ErrorInfo as the method-channel value on
      // auth failure, which surfaces as a TypeError cast rather than AblyException.
      debugPrint('Ably authorize failed: $e');
    }
  }

  Future<void> _enterPresence(
    ably.RealtimeChannel channel, {
    required int currentUserId,
    String? displayName,
    String? imageUrl,
  }) async {
    if (channel.state != ably.ChannelState.attached) {
      await _attachOrRecoverChannel(channel);
    }
    if (channel.state != ably.ChannelState.attached) {
      throw StateError(
        'Ably channel ${channel.name} not attached '
        '(state=${channel.state.name})',
      );
    }
    await channel.presence.enter(_presenceData(
      currentUserId: currentUserId,
      displayName: displayName,
      imageUrl: imageUrl,
      activity: _localComposerActivity,
    ));
  }

  /// Attach when possible. Failed channels must be released + recreated —
  /// attach alone cannot leave Failed.
  Future<void> _attachOrRecoverChannel(ably.RealtimeChannel channel) async {
    await _ensureConnected(
      clientId: _presenceUserId != null ? '$_presenceUserId' : null,
    );
    final realtime = _realtime;
    if (realtime == null ||
        realtime.connection.state != ably.ConnectionState.connected) {
      throw StateError(
        'Ably connection not connected '
        '(state=${realtime?.connection.state.name}) — cannot attach ${channel.name}',
      );
    }

    if (channel.state == ably.ChannelState.attached) return;
    if (channel.state == ably.ChannelState.failed) {
      throw StateError(
        'Ably channel ${channel.name} is Failed — needs release/recreate',
      );
    }
    if (channel.state == ably.ChannelState.detaching) {
      await _waitForChannelTerminalAttach(channel);
      if (channel.state == ably.ChannelState.failed) {
        throw StateError(
          'Ably channel ${channel.name} is Failed — needs release/recreate',
        );
      }
    }
    // attach() succeeds at once on an attached channel and waits on an
    // attaching one, so its success is the truth. ably_flutter only updates
    // `state` from a state-change stream that can lag the call — or miss it
    // entirely on a channel object created just before — which left channels
    // reading "initialized" while attached (presence enter / activity
    // updates then refused to run).
    await channel.attach();
    channel.state = ably.ChannelState.attached;
  }

  /// Same reason as the attach: record the detach ourselves rather than wait
  /// on ably_flutter's state stream.
  Future<void> _detach(ably.RealtimeChannel channel) async {
    try {
      await channel.detach();
      channel.state = ably.ChannelState.detached;
    } catch (_) {}
  }

  Future<void> _waitForChannelTerminalAttach(
    ably.RealtimeChannel channel,
  ) async {
    if (channel.state == ably.ChannelState.attached ||
        channel.state == ably.ChannelState.failed ||
        channel.state == ably.ChannelState.detached) {
      return;
    }
    try {
      await channel
          .on()
          .firstWhere(
            (change) =>
                change.current == ably.ChannelState.attached ||
                change.current == ably.ChannelState.failed ||
                change.current == ably.ChannelState.detached,
          )
          .timeout(const Duration(seconds: 3));
    } catch (e) {
      debugPrint('Ably wait attach (${channel.name}) failed: $e');
    }
  }

  /// Presence enter/get require Attached. If the channel is Failed/Detached,
  /// release it and recreate the binding.
  Future<_ChannelBinding?> _ensureConversationChannelAttached({
    required int conversationId,
    required _ChannelBinding binding,
  }) async {
    if (_realtime == null) return null;
    if (!_tokenAllowsConversation(conversationId)) return null;

    await _ensureConnected(
      clientId: _presenceUserId != null ? '$_presenceUserId' : null,
    );
    if (_realtime?.connection.state != ably.ConnectionState.connected) {
      return null;
    }

    var current = binding;
    final state = current.channel.state;
    if (state == ably.ChannelState.attached) return current;

    if (state == ably.ChannelState.failed ||
        state == ably.ChannelState.detached) {
      current = await _recoverFailedConversationChannel(
            conversationId: conversationId,
            previous: current,
          ) ??
          current;
      return current.channel.state == ably.ChannelState.attached
          ? current
          : null;
    }

    try {
      await _attachOrRecoverChannel(current.channel);
    } catch (e) {
      if (_isCapabilityDeniedError(e)) {
        _capabilityDeniedConversationIds.add(conversationId);
        await _detachChannel(conversationId);
        return null;
      }
      debugPrint('Ably ensure attach failed ($conversationId): $e');
      if (current.channel.state == ably.ChannelState.failed ||
          current.channel.state == ably.ChannelState.detached) {
        current = await _recoverFailedConversationChannel(
              conversationId: conversationId,
              previous: current,
            ) ??
            current;
      }
    }

    return current.channel.state == ably.ChannelState.attached ? current : null;
  }

  Future<_ChannelBinding?> _recoverFailedConversationChannel({
    required int conversationId,
    required _ChannelBinding previous,
  }) async {
    final realtime = _realtime;
    if (realtime == null) return null;
    if (!_tokenAllowsConversation(conversationId)) return null;

    final channelName = previous.channel.name;
    try {
      await previous.presenceSubscription?.cancel();
    } catch (_) {}
    try {
      await previous.subscription.cancel();
    } catch (_) {}
    try {
      realtime.channels.release(channelName);
    } catch (e) {
      try {
        await previous.channel.detach();
      } catch (_) {}
      try {
        realtime.channels.release(channelName);
      } catch (_) {}
    }

    try {
      await _ensureConnected(
        clientId: _presenceUserId != null ? '$_presenceUserId' : null,
      );
      final live = _realtime;
      if (live == null ||
          live.connection.state != ably.ConnectionState.connected) {
        return null;
      }
      final channel = live.channels.get(channelName);
      await channel.attach();
      if (channel.state != ably.ChannelState.attached) return null;

      final sub = channel.subscribe().listen(
            (msg) => _onMessage(msg, conversationId: conversationId),
            onError: (Object e) => debugPrint('Ably subscribe error: $e'),
          );
      final next = _ChannelBinding(
        channel: channel,
        subscription: sub,
        isActiveChat: previous.isActiveChat,
        // Failed wiped presence membership — must re-enter.
        hasEnteredPresence: false,
      );
      _bindings[conversationId] = next;
      return next;
    } catch (e) {
      if (_isCapabilityDeniedError(e)) {
        _capabilityDeniedConversationIds.add(conversationId);
        try {
          _realtime?.channels.release(channelName);
        } catch (_) {}
        _bindings.remove(conversationId);
        return null;
      }
      debugPrint('Ably channel re-attach failed ($conversationId): $e');
      return null;
    }
  }

  Map<String, dynamic> _presenceData({
    required int currentUserId,
    String? displayName,
    String? imageUrl,
    required ChatComposerActivity activity,
  }) {
    return {
      'name': displayName ?? '',
      'image': imageUrl ?? '',
      'user_id': currentUserId,
      'activity': activity.apiValue,
    };
  }

  Map<String, dynamic> _presencePayload({
    required ChatComposerActivity activity,
  }) {
    return _presenceData(
      currentUserId: _presenceUserId ?? 0,
      displayName: _presenceDisplayName,
      imageUrl: _presenceImageUrl,
      activity: activity,
    );
  }

  /// Typing / recording / upload status on the open chat's presence. Called
  /// on changes, plus the chat room's keep-alive while the user is still
  /// typing or recording (peers' indicators expire without it).
  Future<void> updateComposerActivity({
    required int conversationId,
    required ChatComposerActivity activity,
  }) async {
    if (_activeChatConversationId != conversationId) return;
    _localComposerActivity = activity;
    var binding = _bindings[conversationId];
    final userId = _presenceUserId;
    if (binding == null || userId == null) return;

    try {
      if (binding.channel.state != ably.ChannelState.attached) {
        final ready = await _ensureConversationChannelAttached(
          conversationId: conversationId,
          binding: binding,
        );
        if (ready == null) return;
        binding = ready;
      }
      if (_activeChatConversationId != conversationId) return;
      // update() also enters when Ably dropped our membership.
      await binding.channel.presence
          .update(_presencePayload(activity: activity));
      binding.hasEnteredPresence = true;
    } catch (e) {
      debugPrint('Ably presence activity update failed: $e');
    }
  }

  void _emitPresence(
    int conversationId,
    ably.PresenceMessage msg,
  ) {
    final action = msg.action;
    final isOnline = action == ably.PresenceAction.enter ||
        action == ably.PresenceAction.present ||
        action == ably.PresenceAction.update;
    final isOffline = action == ably.PresenceAction.leave ||
        action == ably.PresenceAction.absent;
    if (!isOnline && !isOffline) return;

    final clientId = msg.clientId;
    var userId = _userIdFromPresence(msg);
    if (userId != null && clientId != null && clientId.isNotEmpty) {
      _presenceClientToUserId[clientId] = userId;
    } else if (userId == null && clientId != null && clientId.isNotEmpty) {
      // Leave/absent often has empty data — recover user id from enter map.
      userId = _presenceClientToUserId[clientId];
    }

    if (isOnline && userId != null) {
      _lastOnlineByConversation
          .putIfAbsent(conversationId, () => <int>{})
          .add(userId);
    } else if (isOffline && userId != null) {
      _lastOnlineByConversation[conversationId]?.remove(userId);
      if (clientId != null) _presenceClientToUserId.remove(clientId);
    }

    _eventsController.add(
      ChatPresenceChangedEvent(
        conversationId: conversationId,
        clientId: clientId,
        userId: userId,
        isOnline: isOnline,
      ),
    );

    // Composer activity rides on presence updates. Never echo our own.
    if (userId != null && userId == _presenceUserId) return;

    final data = _presenceDataMap(msg);
    if (isOffline) {
      _eventsController.add(
        ChatUserTypingEvent(
          conversationId: conversationId,
          userId: userId,
          userName: data?['name']?.toString(),
          isTyping: false,
          activity: ChatComposerActivity.none,
          fromPresence: true,
        ),
      );
    } else if (action == ably.PresenceAction.update) {
      final activity = ChatComposerActivity.fromApi(
        data?['activity'] ?? data?['Activity'],
      );
      _eventsController.add(
        ChatUserTypingEvent(
          conversationId: conversationId,
          userId: userId,
          userName: data?['name']?.toString(),
          isTyping: activity.isActive,
          activity: activity.isActive ? activity : ChatComposerActivity.none,
          fromPresence: true,
        ),
      );
    }
  }

  Map<dynamic, dynamic>? _presenceDataMap(ably.PresenceMessage msg) {
    final data = msg.data;
    if (data is Map) return data;
    if (data is String && data.isNotEmpty) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map) return decoded;
      } catch (_) {}
    }
    return null;
  }

  int? _userIdFromPresence(ably.PresenceMessage msg) {
    // Prefer explicit user_id in presence data — Ably clientId may differ
    // from the app user id.
    final map = _presenceDataMap(msg);
    if (map != null) {
      final raw = map['user_id'] ?? map['userId'];
      if (raw is int) return raw;
      if (raw is num) return raw.toInt();
      final parsed = int.tryParse(raw?.toString() ?? '');
      if (parsed != null) return parsed;
    }
    return int.tryParse(msg.clientId ?? '');
  }

  Future<void> _startPresenceListening({
    required int conversationId,
    required _ChannelBinding binding,
    int? currentUserId,
  }) async {
    binding.presenceSubscription ??=
        binding.channel.presence.subscribe().listen(
              (msg) => _emitPresence(conversationId, msg),
              onError: (Object e) => debugPrint('Ably presence error: $e'),
            );
    await _emitCurrentPresenceMembers(
      conversationId: conversationId,
      binding: binding,
      currentUserId: currentUserId,
    );
  }

  /// Broadcast who is in the chat right now (local presence set).
  Future<void> _emitCurrentPresenceMembers({
    required int conversationId,
    required _ChannelBinding binding,
    int? currentUserId,
  }) async {
    final ready = await _ensureConversationChannelAttached(
      conversationId: conversationId,
      binding: binding,
    );
    if (ready == null) return;
    try {
      final members = await ready.channel.presence
          .get(const ably.RealtimePresenceParams(waitForSync: true))
          .timeout(_presenceGetTimeout);
      final currentlyOnline = <int>{};
      for (final member in members) {
        final clientId = member.clientId;
        final userId = _userIdFromPresence(member);
        if (userId != null && clientId != null && clientId.isNotEmpty) {
          _presenceClientToUserId[clientId] = userId;
        }
        if (currentUserId != null &&
            (clientId == '$currentUserId' || userId == currentUserId)) {
          continue;
        }
        if (clientId == null && userId == null) continue;
        if (userId != null) currentlyOnline.add(userId);
        _eventsController.add(
          ChatPresenceChangedEvent(
            conversationId: conversationId,
            clientId: clientId,
            userId: userId,
            isOnline: true,
          ),
        );
      }
      // Additive: a get() right after a presence update can omit peers who
      // are still there. Real leaves come through [_emitPresence].
      _lastOnlineByConversation[conversationId] = {
        ...?_lastOnlineByConversation[conversationId],
        ...currentlyOnline,
      };
    } catch (e) {
      debugPrint('Ably presence get failed: $e');
    }
  }

  void _startPresenceWatchdog() {
    _presenceWatchdogTimer ??= Timer.periodic(
      _presenceWatchdogEvery,
      (_) => _checkOwnPresence(),
    );
  }

  void _stopPresenceWatchdog() {
    _presenceWatchdogTimer?.cancel();
    _presenceWatchdogTimer = null;
  }

  /// Online for as long as the app is open: re-establish our channels when
  /// the connection or a channel died while we stayed in the foreground.
  /// Reads local state only — no Ably traffic while healthy.
  void _checkOwnPresence() {
    if (_presenceUserId == null ||
        !_appInForeground ||
        _isLeavingForBackground) {
      return;
    }
    final realtime = _realtime;
    final conn = realtime?.connection.state;
    if (conn == ably.ConnectionState.connecting) return;
    if (realtime == null || conn != ably.ConnectionState.connected) {
      unawaited(_repairPresence('connection ${conn?.name ?? 'missing'}'));
      return;
    }

    final app = _appPresenceChannel;
    final appHealthy = _hasEnteredAppPresence &&
        app != null &&
        identical(_appChannelsRealtime, realtime) &&
        app.state == ably.ChannelState.attached;
    final activeId = _activeChatConversationId;
    final activeBinding = activeId == null ? null : _bindings[activeId];
    final activeUnbound = activeId != null &&
        !_capabilityDeniedConversationIds.contains(activeId) &&
        (activeBinding == null ||
            activeBinding.channel.state != ably.ChannelState.attached);
    if (!appHealthy || activeUnbound) {
      unawaited(
        _repairPresence(
          'app-online ${app?.state.name ?? 'missing'}, '
          'open chat bound=${!activeUnbound}',
        ),
      );
      return;
    }

    final userChannel = _userChannel;
    final denied = _userChannelDeniedForCapability != null &&
        _userChannelDeniedForCapability == (_lastCapability ?? '');
    if (!denied &&
        (userChannel == null ||
            userChannel.state != ably.ChannelState.attached)) {
      unawaited(_repairPresence('user channel', light: true));
    }
    // Re-attach Chats-list listeners that dropped (diff only when healthy).
    if (_inboxListenIds.isNotEmpty && activeId == null) {
      unawaited(_syncInboxListeners());
    }
  }

  /// [light] only re-runs the app-wide attach; otherwise the full resume path
  /// (reconnect, re-enter, re-attach the open chat).
  Future<void> _repairPresence(String reason, {bool light = false}) async {
    final userId = _presenceUserId;
    if (userId == null || !_appInForeground || _isLeavingForBackground) {
      return;
    }
    if (_presenceRepairFuture != null || _resumeInFlight > 0) return;
    final now = DateTime.now();
    final last = _lastPresenceRepairAt;
    if (last != null && now.difference(last) < _presenceRepairBackoff) return;
    _lastPresenceRepairAt = now;
    debugPrint('Ably presence repair: $reason');

    final future = light
        ? ensureAppPresence(currentUserId: userId)
        : onAppResumed(
            currentUserId: userId,
            displayName: _presenceDisplayName,
            imageUrl: _presenceImageUrl,
          );
    _presenceRepairFuture = future;
    try {
      await future;
    } catch (e) {
      debugPrint('Ably presence repair failed: $e');
    } finally {
      _presenceRepairFuture = null;
    }

    final healthy = _hasEnteredAppPresence &&
        _realtime?.connection.state == ably.ConnectionState.connected;
    if (healthy) {
      _presenceRepairBackoff = _minPresenceRepairBackoff;
    } else {
      final next = _presenceRepairBackoff * 2;
      _presenceRepairBackoff =
          next > _maxPresenceRepairBackoff ? _maxPresenceRepairBackoff : next;
    }
  }

  /// App backgrounded: leave presence so peers see Offline right away, then
  /// close the connection. From here on, delivery receipts come from pushes.
  ///
  /// [_lifecycleEpoch] stops a late `close()` from undoing a quick resume.
  Future<void> onAppPaused() async {
    if (_isLeavingForBackground) return;
    final epoch = ++_lifecycleEpoch;
    _isLeavingForBackground = true;
    try {
      _stopPresenceWatchdog();
      _cancelPendingAppOfflineChecks();

      final tasks = <Future<void>>[];
      final appChannel = _appPresenceChannel;
      if (appChannel != null && _hasEnteredAppPresence) {
        _hasEnteredAppPresence = false;
        tasks.add(() async {
          try {
            await appChannel.presence.leave();
          } catch (_) {}
        }());
      }
      for (final binding in _bindings.values) {
        if (!binding.hasEnteredPresence) continue;
        binding.hasEnteredPresence = false;
        final channel = binding.channel;
        tasks.add(() async {
          try {
            await channel.presence.leave();
          } catch (_) {}
        }());
      }
      if (tasks.isNotEmpty) {
        try {
          await Future.wait(tasks).timeout(const Duration(milliseconds: 450));
        } on TimeoutException {
          debugPrint('Ably presence leave (pause) timed out');
        }
      }

      if (epoch != _lifecycleEpoch) return;
      final realtime = _realtime;
      _discardRealtimeBoundState();
      try {
        await realtime?.close().timeout(const Duration(milliseconds: 400));
      } catch (e) {
        debugPrint('Ably close (pause) failed: $e');
      }
      if (epoch != _lifecycleEpoch) return;

      if (identical(_realtime, realtime)) _realtime = null;
      _connectFuture = null;
      _ensureAppPresenceFuture = null;
      _authorizeFuture = null;
      _lastAuthorizeTime = null;
    } finally {
      if (epoch == _lifecycleEpoch) {
        _isLeavingForBackground = false;
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        // Notification shade / permission sheets fire inactive without the
        // user leaving the app — stay Online.
        break;
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _appInForeground = false;
        _scheduleBackgroundLeave();
      case AppLifecycleState.resumed:
        _appInForeground = true;
        _cancelBackgroundLeave();
        _lifecycleEpoch++;
        _isLeavingForBackground = false;
        final userId = _presenceUserId;
        if (userId != null) {
          unawaited(
            onAppResumed(
              currentUserId: userId,
              displayName: _presenceDisplayName,
              imageUrl: _presenceImageUrl,
            ),
          );
        } else {
          unawaited(bootstrapFromLocalSession(forceReenter: true));
        }
    }
  }

  void _scheduleBackgroundLeave() {
    _backgroundLeaveTimer ??= Timer(_backgroundLeaveDelay, () {
      _backgroundLeaveTimer = null;
      unawaited(onAppPaused());
    });
  }

  void _cancelBackgroundLeave() {
    _backgroundLeaveTimer?.cancel();
    _backgroundLeaveTimer = null;
  }

  /// App resumed — restore app-wide online, the inbox channel and the open
  /// chat's presence.
  Future<void> onAppResumed({
    required int currentUserId,
    String? displayName,
    String? imageUrl,
  }) async {
    _resumeInFlight++;
    try {
      await _restoreAfterResume(
        currentUserId: currentUserId,
        displayName: displayName,
        imageUrl: imageUrl,
      );
    } finally {
      _resumeInFlight--;
    }
  }

  Future<void> _restoreAfterResume({
    required int currentUserId,
    String? displayName,
    String? imageUrl,
  }) async {
    // Cancel an in-flight pause so it cannot close the connection we rebuild.
    _cancelBackgroundLeave();
    _lifecycleEpoch++;
    _isLeavingForBackground = false;

    _presenceUserId = currentUserId;
    if (displayName != null) _presenceDisplayName = displayName;
    if (imageUrl != null) _presenceImageUrl = imageUrl;
    _startPresenceWatchdog();

    // Let an in-flight pause abort before we reconnect.
    await Future<void>.delayed(const Duration(milliseconds: 80));
    if (!_appInForeground) return;

    final current = _realtime;
    final conn = current?.connection.state;
    if (current != null &&
        (conn == ably.ConnectionState.closed ||
            conn == ably.ConnectionState.failed ||
            conn == ably.ConnectionState.closing)) {
      _discardRealtimeBoundState();
      try {
        await current.close();
      } catch (_) {}
      if (identical(_realtime, current)) _realtime = null;
      _connectFuture = null;
      _ensureAppPresenceFuture = null;
    }

    await _ensureConnected(clientId: '$currentUserId');
    await _authorizeIfNeeded();
    if (!_appInForeground) return;

    try {
      await ensureAppPresence(
        currentUserId: currentUserId,
        displayName: displayName ?? _presenceDisplayName,
        imageUrl: imageUrl ?? _presenceImageUrl,
        forceReenter: true,
      );
    } catch (e) {
      debugPrint('Ably ensureAppPresence on resume failed: $e');
    }
    if (!_hasEnteredAppPresence && _appInForeground) {
      // One retry after a short delay (common right after OS wake).
      await Future<void>.delayed(const Duration(milliseconds: 350));
      try {
        await ensureAppPresence(
          currentUserId: currentUserId,
          displayName: displayName ?? _presenceDisplayName,
          imageUrl: imageUrl ?? _presenceImageUrl,
          forceReenter: true,
        );
      } catch (e) {
        debugPrint('Ably ensureAppPresence on resume retry failed: $e');
      }
    }

    final activeId = _activeChatConversationId;
    if (activeId != null && _appInForeground) {
      await subscribeToConversation(
        conversationId: activeId,
        currentUserId: currentUserId,
        displayName: displayName ?? _presenceDisplayName,
        imageUrl: imageUrl ?? _presenceImageUrl,
      );
    }
    unawaited(_syncInboxListeners());
  }

  /// Chat room open: attach this conversation's channel and enter its
  /// presence. Any other conversation channel is dropped — only the open
  /// chat is attached.
  Future<void> subscribeToConversation({
    required int conversationId,
    required int currentUserId,
    String? displayName,
    String? imageUrl,
  }) async {
    _presenceUserId = currentUserId;
    if (displayName != null) _presenceDisplayName = displayName;
    if (imageUrl != null) _presenceImageUrl = imageUrl;
    if (_activeChatConversationId != conversationId) {
      _localComposerActivity = ChatComposerActivity.none;
    }
    _activeChatConversationId = conversationId;

    final inFlight = _subscribeFuture;
    if (inFlight != null && _subscribeFutureConversationId == conversationId) {
      await inFlight;
      if (_isOpenChatHealthy(conversationId)) return;
    }

    final future = _doSubscribeToConversation(
      conversationId: conversationId,
      currentUserId: currentUserId,
    );
    _subscribeFuture = future;
    _subscribeFutureConversationId = conversationId;
    try {
      await future;
    } finally {
      if (identical(_subscribeFuture, future)) {
        _subscribeFuture = null;
        _subscribeFutureConversationId = null;
      }
    }
  }

  bool _isOpenChatHealthy(int conversationId) {
    final binding = _bindings[conversationId];
    return _activeChatConversationId == conversationId &&
        binding != null &&
        binding.channel.state == ably.ChannelState.attached &&
        binding.hasEnteredPresence;
  }

  bool _isOpen(int conversationId) =>
      _activeChatConversationId == conversationId && _appInForeground;

  Future<void> _doSubscribeToConversation({
    required int conversationId,
    required int currentUserId,
  }) async {
    await ensureAppPresence(currentUserId: currentUserId);
    if (!_isOpen(conversationId)) return;

    await _ensureConnected(clientId: '$currentUserId');
    // A chat created or joined after the token was issued needs a new token.
    final bound = _bindings[conversationId];
    final attached =
        bound != null && bound.channel.state == ably.ChannelState.attached;
    if (!attached &&
        !_capabilityAllowsChannel(
          _lastCapability,
          conversationChannelName(conversationId),
        )) {
      _lastAuthorizeTime = null;
    }
    await _authorizeIfNeeded();
    if (_capabilityAllowsChannel(
      _lastCapability,
      conversationChannelName(conversationId),
    )) {
      _capabilityDeniedConversationIds.remove(conversationId);
    }
    if (!_isOpen(conversationId)) return;

    for (final id in _bindings.keys.toList()) {
      if (id != conversationId) await _detachChannel(id);
    }
    if (!_tokenAllowsConversation(conversationId)) return;
    if (_realtime == null) return;

    var binding = _bindings[conversationId];
    if (binding != null) {
      binding = await _ensureConversationChannelAttached(
            conversationId: conversationId,
            binding: binding,
          ) ??
          _bindings[conversationId];
      if (binding == null) return;
    } else {
      final channelName = conversationChannelName(conversationId);
      final channel = await _freshChannel(channelName);
      try {
        await _attachOrRecoverChannel(channel);
      } catch (e) {
        if (_isCapabilityDeniedError(e)) {
          _capabilityDeniedConversationIds.add(conversationId);
          debugPrint('Ably skip $channelName — token capability denied');
        } else {
          debugPrint('Ably channel attach failed ($conversationId): $e');
        }
        if (channel.state == ably.ChannelState.failed) {
          try {
            _realtime?.channels.release(channelName);
          } catch (_) {}
        }
        return;
      }
      if (!_isOpen(conversationId)) {
        await _detach(channel);
        return;
      }
      final sub = channel.subscribe().listen(
            (msg) => _onMessage(msg, conversationId: conversationId),
            onError: (Object e) => debugPrint('Ably subscribe error: $e'),
          );
      binding = _ChannelBinding(
        channel: channel,
        subscription: sub,
        isActiveChat: true,
        hasEnteredPresence: false,
      );
      _bindings[conversationId] = binding;
    }
    binding.isActiveChat = true;

    if (!binding.hasEnteredPresence) {
      try {
        await _enterPresence(
          binding.channel,
          currentUserId: currentUserId,
          displayName: _presenceDisplayName,
          imageUrl: _presenceImageUrl,
        );
        binding.hasEnteredPresence = true;
      } catch (e) {
        if (_isCapabilityDeniedError(e)) {
          _capabilityDeniedConversationIds.add(conversationId);
          await _detachChannel(conversationId);
          return;
        }
        debugPrint('Ably presence enter (chat) failed: $e');
      }
    }
    // Closed while entering — do not stay "in the chat" from the Chats list.
    if (!_isOpen(conversationId)) {
      await _detachChannel(conversationId);
      return;
    }
    await _startPresenceListening(
      conversationId: conversationId,
      binding: binding,
      currentUserId: currentUserId,
    );
  }

  void _onMessage(
    ably.Message message, {
    required int conversationId,
  }) {
    final name = message.name;
    final data = _asMap(message.data);
    if (name == null || data == null) {
      debugPrint('Ably skip message name=$name data=${message.data}');
      return;
    }

    // Channel is already scoped to this conversation; many receipts omit
    // conversation_id in the payload — fall back to the channel id.
    int? eventConversationId(Map<String, dynamic> payload) {
      return _asInt(
            payload['conversation_id'] ??
                payload['conversationId'] ??
                payload['conversation'],
          ) ??
          conversationId;
    }

    try {
      switch (name) {
        case 'message.sent':
          final map = _asMap(data['message']) ??
              (data.containsKey('id') || data.containsKey('content')
                  ? data
                  : null);
          if (map != null) {
            map.putIfAbsent('conversation_id', () => conversationId);
            _eventsController.add(
              ChatMessageSentEvent(ChatMessageModel.fromJson(map)),
            );
          } else {
            debugPrint('Ably message.sent missing payload: $data');
          }
        case 'message.updated':
        case 'message.edited':
          final map = _asMap(data['message']) ??
              (data.containsKey('id') || data.containsKey('content')
                  ? data
                  : null);
          if (map != null) {
            map.putIfAbsent('conversation_id', () => conversationId);
            map['is_edited'] = true;
            _eventsController.add(
              ChatMessageUpdatedEvent(ChatMessageModel.fromJson(map)),
            );
          } else {
            debugPrint('Ably $name missing payload: $data');
          }
        case 'message.deleted':
          final messageId = _asInt(data['message_id']);
          final eventId = eventConversationId(data);
          if (messageId != null && eventId != null) {
            _eventsController.add(
              ChatMessageDeletedEvent(
                messageId: messageId,
                conversationId: eventId,
              ),
            );
          }
        case 'message.reacted':
          final messageId = _asInt(data['message_id']);
          final eventId = eventConversationId(data);
          if (messageId != null && eventId != null) {
            _eventsController.add(
              ChatMessageReactedEvent(
                messageId: messageId,
                conversationId: eventId,
                userId: _asInt(data['user_id']),
                reaction: data['reaction']?.toString(),
                action: data['action']?.toString(),
              ),
            );
          }
        case 'message.read':
          // Prefer the channel id — payload conversation_id is often wrong
          // or missing and would drop the receipt in the open chat room.
          _eventsController.add(
            ChatMessageReadEvent(
              conversationId: conversationId,
              userId: _asInt(
                data['user_id'] ??
                    data['userId'] ??
                    data['reader_id'] ??
                    data['readerId'],
              ),
              lastReadMessageId: _asInt(
                data['last_read_message_id'] ?? data['lastReadMessageId'],
              ),
              readAt: (data['read_at'] ?? data['readAt'])?.toString(),
            ),
          );
        case 'message.delivered':
          _eventsController.add(
            ChatMessageDeliveredEvent(
              conversationId: conversationId,
              userId: _asInt(
                data['user_id'] ?? data['userId'] ?? data['reader_id'],
              ),
              deliveredAt: data['delivered_at']?.toString(),
            ),
          );
        case 'user.typing':
          final eventId = eventConversationId(data);
          if (eventId != null) {
            final typingRaw = data['is_typing'];
            final isTyping = typingRaw == true ||
                typingRaw == 1 ||
                typingRaw?.toString() == 'true';
            var activity = ChatComposerActivity.fromApi(
              data['activity'] ?? data['typing_activity'] ?? data['type'],
            );
            if (isTyping && activity == ChatComposerActivity.none) {
              activity = ChatComposerActivity.typing;
            }
            if (!isTyping) {
              activity = ChatComposerActivity.none;
            }
            _eventsController.add(
              ChatUserTypingEvent(
                conversationId: eventId,
                userId: _asInt(
                  data['user_id'] ??
                      data['userId'] ??
                      data['sender_id'] ??
                      data['senderId'],
                ),
                userName: data['user_name']?.toString() ??
                    data['userName']?.toString() ??
                    data['name']?.toString(),
                isTyping: isTyping,
                activity: activity,
              ),
            );
          }
        case 'message.pinned':
          // Pinned-message banner is not built yet.
          break;
        default:
          debugPrint('Ably unknown event: $name');
      }
    } catch (e, st) {
      debugPrint('Ably event parse failed ($name): $e\n$st');
    }
  }

  Map<String, dynamic>? _asMap(dynamic value) {
    if (value == null) return null;
    if (value is Map) {
      return _deepStringKeyedMap(value);
    }
    if (value is String) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is Map) return _deepStringKeyedMap(decoded);
      } catch (_) {}
    }
    return null;
  }

  /// Ably often delivers `_Map<Object?, Object?>`; json_serializable needs
  /// deeply typed `Map<String, dynamic>` (including nested sender/attachments).
  Map<String, dynamic> _deepStringKeyedMap(Map<dynamic, dynamic> source) {
    final result = <String, dynamic>{};
    source.forEach((key, value) {
      result[key.toString()] = _deepJsonValue(value);
    });
    return result;
  }

  dynamic _deepJsonValue(dynamic value) {
    if (value is Map) {
      return _deepStringKeyedMap(value);
    }
    if (value is List) {
      return value.map(_deepJsonValue).toList();
    }
    return value;
  }

  int? _asInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

  Future<void> _detachChannel(int conversationId) async {
    final binding = _bindings.remove(conversationId);
    if (binding == null) return;
    _lastOnlineByConversation.remove(conversationId);
    try {
      await binding.presenceSubscription?.cancel();
    } catch (_) {}
    try {
      await binding.subscription.cancel();
    } catch (_) {}
    // Re-opened meanwhile — the new binding owns the same channel object.
    if (_isOpen(conversationId) || _bindings.containsKey(conversationId)) {
      return;
    }
    try {
      if (binding.hasEnteredPresence) {
        binding.hasEnteredPresence = false;
        await binding.channel.presence.leave();
      }
      if (_isOpen(conversationId) || _bindings.containsKey(conversationId)) {
        return;
      }
      await _detach(binding.channel);
    } catch (_) {}
  }

  /// Chat room closed: leave its presence (the channel stays listen-only if
  /// the Chats list wants it). Skipped if the same chat was re-opened before
  /// the old room finished closing.
  Future<void> unsubscribe({int? conversationId}) async {
    final id = conversationId ?? _activeChatConversationId;
    if (id == null) return;
    if (conversationId != null && _activeChatConversationId == conversationId) {
      return;
    }
    if (_activeChatConversationId == id) {
      _activeChatConversationId = null;
      _localComposerActivity = ChatComposerActivity.none;
    }
    await _releaseChat(id);
  }

  Future<void> disconnect() async {
    // Signed out — nothing may re-enter presence for this account.
    _presenceUserId = null;
    _activeChatConversationId = null;
    _inboxListenIds = const {};
    _localComposerActivity = ChatComposerActivity.none;
    _stopPresenceWatchdog();
    _cancelPendingAppOfflineChecks();
    _cancelBackgroundLeave();

    final appChannel = _appPresenceChannel;
    if (appChannel != null && _hasEnteredAppPresence) {
      try {
        await appChannel.presence.leave();
      } catch (_) {}
    }
    final userChannel = _userChannel;
    if (userChannel != null) {
      await _detach(userChannel);
    }
    for (final id in _bindings.keys.toList()) {
      await _detachChannel(id);
    }
    _discardAppChannels();
    await _connectionStateSubscription?.cancel();
    _connectionStateSubscription = null;

    _ensureAppPresenceFuture = null;
    _subscribeFuture = null;
    _subscribeFutureConversationId = null;
    _presenceRepairBackoff = _minPresenceRepairBackoff;
    _lastPresenceRepairAt = null;
    _userChannelDeniedForCapability = null;
    _capabilityDeniedConversationIds.clear();
    _lastCapability = null;
    _appOnlineUserIds.clear();
    _appOnlineMembersByUser.clear();
    _appPresenceClientToUserId.clear();
    _lastOnlineByConversation.clear();
    _presenceClientToUserId.clear();
    try {
      await _realtime?.close();
    } catch (_) {}
    _realtime = null;
    _connectFuture = null;
    _authorizeFuture = null;
    _lastAuthorizeTime = null;
  }

  Future<void> dispose() async {
    if (_lifecycleAttached) {
      WidgetsBinding.instance.removeObserver(this);
      _lifecycleAttached = false;
    }
    await disconnect();
    await _eventsController.close();
  }
}
