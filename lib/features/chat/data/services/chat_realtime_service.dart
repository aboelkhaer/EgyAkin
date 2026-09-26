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
  const ChatMessageReadEvent({
    required this.conversationId,
    this.userId,
    this.lastReadMessageId,
  });
}

class ChatMessageDeliveredEvent extends ChatRealtimeEvent {
  final int conversationId;
  final int? userId;
  const ChatMessageDeliveredEvent({
    required this.conversationId,
    this.userId,
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

/// Peer entered/left the app-wide online channel (any screen in the app).
class ChatInboxInvalidateEvent extends ChatRealtimeEvent {
  final int? conversationId;
  final int? contextId;
  final String? chatType;

  /// True when a conversation was deleted / left and should drop from inbox.
  final bool removed;
  const ChatInboxInvalidateEvent({
    this.conversationId,
    this.contextId,
    this.chatType,
    this.removed = false,
  });
}

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

/// Ably realtime for chat — conversation channels + app-wide online presence.
class ChatRealtimeService with WidgetsBindingObserver {
  ChatRealtimeService(this._apiServices) {
    // Observe lifecycle so presence leave starts before the OS suspends the
    // network (inactive), and kill/crash still times out quickly via Ably params.
    WidgetsBinding.instance.addObserver(this);
  }

  final ApiServices _apiServices;

  /// App-wide online channel. Backend now grants `presence:app`
  /// (`subscribe` + `presence`) — prefer that so all clients meet.
  /// Keep `presence:conversation.app` as fallback / dual-enter during
  /// rollout so peers still on the old name stay mutual.
  static const primaryAppPresenceChannel = 'presence:app';

  /// Previous preferred name — fallback + dual-subscribe during migration.
  static const legacyAppPresenceChannel = 'presence:conversation.app';

  /// Active app-online channel (heartbeats).
  String _appPresenceChannelName = primaryAppPresenceChannel;

  /// Public name of the channel currently used for app-wide online.
  String get appPresenceChannelName => _appPresenceChannelName;

  /// After abrupt disconnect, Ably default keeps members ~15s. Min is 1000ms.
  static const _remainPresentForMs = '15000';

  /// Ably minimum is 5000ms. With the ~10s server margin, Abrupt disconnect
  /// detection is still ~15s — we layer an app heartbeat below for ~5s offline.
  static const _heartbeatIntervalMs = '5000';

  /// How often we `presence.update` while foregrounded.
  static const _appHeartbeatEvery = Duration(seconds: 2);

  ably.Realtime? _realtime;
  final Map<int, _ChannelBinding> _bindings = {};
  int? _activeChatConversationId;
  final _eventsController = StreamController<ChatRealtimeEvent>.broadcast();

  ably.RealtimeChannel? _appPresenceChannel;
  StreamSubscription<ably.PresenceMessage>? _appPresenceSubscription;
  StreamSubscription<ably.Message>? _appMessageSubscription;
  /// Second app-online channel so peers on the other name still see us.
  ably.RealtimeChannel? _secondaryAppPresenceChannel;
  StreamSubscription<ably.PresenceMessage>? _secondaryAppPresenceSubscription;
  bool _hasEnteredAppPresence = false;
  /// Channels we successfully entered — avoid cancel/re-enter storms that
  /// made Online one-way (I see peers, they still see me Offline).
  final Set<String> _enteredAppChannelNames = {};

  /// Realtime client the app-online channels were created on. Channels of a
  /// closed / failed client can still read "attached" in Dart while every
  /// heartbeat silently goes nowhere — peers then see us Offline in-app.
  ably.Realtime? _appPresenceRealtime;
  ably.RealtimeChannel? _appPresenceSubscribedChannel;
  ably.RealtimeChannel? _secondaryAppPresenceSubscribedChannel;
  StreamSubscription<ably.ConnectionStateChange>? _connectionStateSubscription;

  /// True after a successful attach/enter on whichever app-online channel works.
  bool _tokenAllowsAppPresence = false;

  /// App-online channel names Ably refused (40160) under the current token
  /// capability. Skipped until the capability changes, so a refused name is
  /// not re-attached on every call and can never block the other one.
  final Set<String> _deniedAppPresenceChannels = {};

  /// Every app-online channel is currently refused by the token.
  bool _appPresenceCapabilityDenied = false;

  /// Raw capability from the last token (for conversation channel checks).
  String? _lastCapability;

  /// Deduplicate concurrent [ensureAppPresence] calls (Home + Inbox + resume).
  Future<void>? _ensureAppPresenceFuture;

  /// Conversations the current token cannot access (Ably 40160). Skip retries
  /// until the next token refresh so we don't spam Failed re-attach loops.
  final Set<int> _capabilityDeniedConversationIds = {};
  final Set<int> _appOnlineUserIds = {};
  /// Live app-online memberships per user (`channel|connectionId|clientId`).
  /// Ably sends one leave per connection, so a stale connection (reconnect,
  /// second device, the other app channel) must not grey a present peer.
  final Map<int, Set<String>> _appOnlineMembersByUser = {};
  final Map<String, int> _appPresenceClientToUserId = {};

  /// Offline is only published after this grace + a roster re-check. Peers
  /// heartbeat every [_appHeartbeatEvery], so anyone still in the app
  /// cancels the pending Offline before it shows.
  final Map<int, Timer> _pendingAppOfflineChecks = {};
  static const _appOfflineGrace = Duration(seconds: 3);
  static const _presenceGetTimeout = Duration(seconds: 4);

  /// Roster reconciliation only expires peers silent at least this long.
  static const _appPresenceSilentAfter = Duration(seconds: 8);

  /// Leave events often omit presence data — map clientId → userId from enters.
  final Map<String, int> _presenceClientToUserId = {};

  /// Last known online user ids per conversation (to emit offline on sync).
  final Map<int, Set<int>> _lastOnlineByConversation = {};

  /// Last time we saw each user on any presence channel (app or conversation).
  final Map<int, DateTime> _lastPresenceSeenAt = {};

  /// Users who publish `ts` heartbeats — only these are stale-swept (~5s).
  /// Clients without heartbeats still rely on Ably leave (~15s).
  final Set<int> _heartbeatCapableUserIds = {};

  /// Conversation ids to re-attach after background `connection.close()`.
  final Set<int> _pendingResubscribeIds = {};

  /// Presence profile used when restoring after app resume.
  int? _presenceUserId;
  String? _presenceDisplayName;
  String? _presenceImageUrl;

  /// Last composer activity we published on the active conversation channel.
  /// Heartbeats must preserve this or peers see typing flicker (none → typing).
  ChatComposerActivity _localComposerActivity = ChatComposerActivity.none;

  /// Guards to prevent redundant connect/authorize calls.
  Future<void>? _connectFuture;
  Future<void>? _authorizeFuture;
  DateTime? _lastAuthorizeTime;
  Timer? _activePresenceSyncTimer;
  Timer? _lifecycleLeaveTimer;
  /// Debounced Offline — WhatsApp-style: brief app-switcher / permission
  /// sheets must NOT leave presence while the user is still "in" the app.
  Timer? _backgroundLeaveTimer;
  static const _backgroundLeaveDelay = Duration(seconds: 3);
  Timer? _appHeartbeatTimer;
  bool _isLeavingForBackground = false;

  /// False from hidden/paused until resumed — the watchdog never re-enters
  /// presence for a backgrounded app.
  bool _appInForeground = true;
  Timer? _presenceWatchdogTimer;
  static const _presenceWatchdogEvery = Duration(seconds: 4);
  static const _minPresenceRepairBackoff = Duration(seconds: 3);
  static const _maxPresenceRepairBackoff = Duration(seconds: 30);
  Duration _presenceRepairBackoff = _minPresenceRepairBackoff;
  Future<void>? _presenceRepairFuture;
  DateTime? _lastPresenceRepairAt;
  int _resumeInFlight = 0;

  /// Soft leave on brief `inactive` (notification shade / tap) — keep Ably
  /// bindings so resume does not re-attach every conversation (jetsam risk).
  bool _softLeftPresence = false;
  bool _lifecycleAttached = true;

  /// Bumped on every lifecycle transition so an in-flight [onAppPaused] cannot
  /// close a connection that [onAppResumed] already rebuilt (left users stuck
  /// Offline after returning from background).
  int _lifecycleEpoch = 0;

  Stream<ChatRealtimeEvent> get events => _eventsController.stream;

  int? get subscribedConversationId => _activeChatConversationId;

  /// True only while a chat room screen is open for this conversation.
  bool isViewingConversation(int conversationId) =>
      _activeChatConversationId == conversationId;

  /// Whether [userId] is currently in the conversation channel presence
  /// (opened that chat — not merely online in the app / on Chats list).
  bool isUserPresentInConversation(int conversationId, int userId) {
    final members = _lastOnlineByConversation[conversationId];
    return members != null && members.contains(userId);
  }

  /// App-wide online (any screen), not conversation presence.
  bool isUserAppOnline(int userId) => _appOnlineUserIds.contains(userId);

  /// True after a successful app-online enter (any screen).
  bool get hasEnteredAppPresence => _hasEnteredAppPresence;

  Set<int> get appOnlineUserIds => Set.unmodifiable(_appOnlineUserIds);

  /// Enter [presence:app] from local session (any screen — Splash / Home /
  /// deep link / post-login). Does not require Home or a chat room.
  ///
  /// Safe to call repeatedly; coalesces with [ensureAppPresence].
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

  /// Clear active chat synchronously (call from chat room dispose / pop).
  /// Also leaves conversation presence immediately so the backend stops
  /// treating us as reading while we are only on the Chats list.
  void clearActiveChat() {
    final id = _activeChatConversationId;
    _activeChatConversationId = null;
    _localComposerActivity = ChatComposerActivity.none;
    _stopActivePresenceSync();
    if (id != null) {
      final binding = _bindings[id];
      if (binding != null) {
        unawaited(_leaveConversationPresence(binding, reason: 'clearActiveChat'));
      }
    }
  }

  /// Leave conversation presence. Safe when already absent. Always clear the
  /// local flag — Ably may auto-re-enter after reconnect even if we think we
  /// already left, which falsely marks messages as seen from Chats.
  Future<void> _leaveConversationPresence(
    _ChannelBinding binding, {
    required String reason,
  }) async {
    try {
      await binding.channel.presence.leave();
    } catch (e) {
      debugPrint('Ably presence leave ($reason) failed: $e');
    }
    binding.hasEnteredPresence = false;
  }

  /// Only skip when Ably itself refused every app-online channel we tried.
  /// Never skip presence:app based on parsing the capability JSON alone —
  /// that historically blocked Online entirely while chat-room presence still
  /// worked.
  bool get _appPresenceKnownDenied => _appPresenceCapabilityDenied;

  /// Enter the app-wide online channel. Call while the app is foregrounded
  /// (Home / Chats / any tab) — does not affect conversation read receipts.
  ///
  /// Uses [primaryAppPresenceChannel] (`presence:app`) so Online is mutual
  /// with the backend grant. Also enters [legacyAppPresenceChannel] while the
  /// token grants it, and falls back to it if presence:app is refused.
  ///
  /// [forceReenter] — always publish enter/update (app resume / soft return)
  /// so peers see online immediately instead of waiting on a later heartbeat.
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

    // Coalesce overlapping Home / Inbox / resume callers onto one enter.
    final existing = _ensureAppPresenceFuture;
    if (existing != null) {
      await existing;
      if (_hasEnteredAppPresence && !forceReenter) return;
      if (_hasEnteredAppPresence && forceReenter) {
        // Prior enter finished — still bump so peers see us ASAP.
      } else if (_appPresenceKnownDenied) {
        return;
      }
    }

    final future = _doEnsureAppPresence(
      currentUserId: currentUserId,
      forceReenter: forceReenter,
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
    required bool forceReenter,
  }) async {
    _softLeftPresence = false;
    // Online means the app is open — never (re)enter from the background.
    if (!_appInForeground) return;

    await _ensureConnected(clientId: '$currentUserId');
    await _authorizeIfNeeded();
    final realtime = _realtime;
    if (realtime == null || !_appInForeground) return;
    if (!identical(_appPresenceRealtime, realtime)) {
      _discardAppPresenceChannels();
      _appPresenceRealtime = realtime;
    }

    // presence:app always first; the legacy name only while the token still
    // grants it. Only a real 40160 from Ably removes a name from this list.
    var candidates = _appPresenceCandidates();
    if (candidates.isEmpty) {
      await _refreshAppPresenceCapability();
      candidates = _appPresenceCandidates();
      if (candidates.isEmpty) {
        _appPresenceCapabilityDenied = true;
        debugPrint(
          'Ably app-online skipped — token denies both '
          '$primaryAppPresenceChannel and $legacyAppPresenceChannel',
        );
        return;
      }
    }

    // First name that attaches owns heartbeats + roster; the next is extra.
    final remaining = [...candidates];
    String? primaryName;
    while (primaryName == null && remaining.isNotEmpty) {
      final name = remaining.removeAt(0);
      final ok = await _attachAndEnterAppPresence(
        currentUserId: currentUserId,
        forceReenter: forceReenter,
        channelName: name,
        asPrimary: true,
      );
      if (ok) {
        primaryName = name;
      } else if (_realtime?.connection.state !=
          ably.ConnectionState.connected) {
        // Connection dropped mid-attach — not a denial; the watchdog retries.
        return;
      }
    }
    _appPresenceCapabilityDenied = primaryName == null &&
        candidates.every(_deniedAppPresenceChannels.contains);
    if (primaryName == null) return;

    if (remaining.isEmpty) {
      _dropSecondaryAppPresence();
      return;
    }
    await _attachAndEnterAppPresence(
      currentUserId: currentUserId,
      forceReenter: forceReenter,
      channelName: remaining.first,
      asPrimary: false,
    );
  }

  List<String> _appPresenceCandidates() => [
        if (!_deniedAppPresenceChannels.contains(primaryAppPresenceChannel))
          primaryAppPresenceChannel,
        if (!_deniedAppPresenceChannels.contains(legacyAppPresenceChannel) &&
            !_knownCapabilityOmits(legacyAppPresenceChannel))
          legacyAppPresenceChannel,
      ];

  /// Used for the legacy name only. The token is signed with this exact
  /// capability string, so a channel it omits is certain to be refused.
  /// presence:app is always attempted and left to Ably to decide.
  bool _knownCapabilityOmits(String channelName) {
    final cap = _lastCapability;
    if (cap == null || cap.trim().isEmpty) return false;
    return !_capabilityAllowsChannel(cap, channelName);
  }

  /// Only Ably's capability refusal — a generic 401 (e.g. expired token) must
  /// not park presence:app.
  static bool _isAppChannelCapabilityError(Object e) {
    final s = e.toString();
    return s.contains('40160') ||
        s.contains('denied access based on given capability');
  }

  void _dropSecondaryAppPresence() {
    final channel = _secondaryAppPresenceChannel;
    if (channel == null) return;
    // After a primary/secondary swap both refs can be the same channel.
    if (!identical(channel, _appPresenceChannel)) {
      _enteredAppChannelNames.remove(channel.name);
    }
    unawaited(_secondaryAppPresenceSubscription?.cancel());
    _secondaryAppPresenceSubscription = null;
    _secondaryAppPresenceSubscribedChannel = null;
    _secondaryAppPresenceChannel = null;
  }

  /// Attach + enter one app-online channel. Returns true on success.
  /// [asPrimary] owns heartbeats; secondary only publishes + listens.
  Future<bool> _attachAndEnterAppPresence({
    required int currentUserId,
    required bool forceReenter,
    required String channelName,
    required bool asPrimary,
  }) async {
    try {
      final existing = asPrimary
          ? _appPresenceChannel
          : _secondaryAppPresenceChannel;
      final alreadyHealthy = existing != null &&
          existing.name == channelName &&
          identical(_appPresenceRealtime, _realtime) &&
          existing.state == ably.ChannelState.attached &&
          _enteredAppChannelNames.contains(channelName);

      // Fast path: stay present, just refresh roster (no cancel/re-enter).
      if (alreadyHealthy && !forceReenter) {
        if (asPrimary) {
          _appPresenceChannel = existing;
          _appPresenceChannelName = channelName;
        } else {
          _secondaryAppPresenceChannel = existing;
        }
        _hasEnteredAppPresence = true;
        await _emitAppPresenceSnapshot(channelOverride: existing);
        return true;
      }

      final channel =
          alreadyHealthy ? existing : await _freshChannel(channelName);
      if (asPrimary) {
        _appPresenceChannel = channel;
        _appPresenceChannelName = channelName;
      } else {
        _secondaryAppPresenceChannel = channel;
      }
      await _attachOrRecoverChannel(channel);
      if (channel.state != ably.ChannelState.attached) {
        throw StateError(
          'Ably $channelName not attached (state=${channel.state.name})',
        );
      }

      // Subscribe once per channel instance — cancel/resubscribe on the same
      // channel dropped present-sync. A released / recreated channel is a new
      // object, and its old subscription never fires again.
      if (asPrimary) {
        if (!identical(_appPresenceSubscribedChannel, channel)) {
          unawaited(_appPresenceSubscription?.cancel());
          unawaited(_appMessageSubscription?.cancel());
          _appPresenceSubscription = channel.presence.subscribe().listen(
                (msg) => _onAppPresenceMessage(msg, channelName),
                onError: (_) {},
              );
          _appMessageSubscription = channel.subscribe().listen(
                _onAppChannelMessage,
                onError: (_) {},
              );
          _appPresenceSubscribedChannel = channel;
        }
      } else if (!identical(_secondaryAppPresenceSubscribedChannel, channel)) {
        unawaited(_secondaryAppPresenceSubscription?.cancel());
        _secondaryAppPresenceSubscription =
            channel.presence.subscribe().listen(
                  (msg) => _onAppPresenceMessage(msg, channelName),
                  onError: (_) {},
                );
        _secondaryAppPresenceSubscribedChannel = channel;
      }

      final needEnter =
          !_enteredAppChannelNames.contains(channelName) || forceReenter;
      try {
        if (needEnter) {
          await _enterPresence(
            channel,
            currentUserId: currentUserId,
            displayName: _presenceDisplayName,
            imageUrl: _presenceImageUrl,
          );
        } else {
          await channel.presence.update(
            _presencePayload(activity: ChatComposerActivity.none),
          );
        }
      } catch (_) {
        await _enterPresence(
          channel,
          currentUserId: currentUserId,
          displayName: _presenceDisplayName,
          imageUrl: _presenceImageUrl,
        );
      }
      _enteredAppChannelNames.add(channelName);
      _hasEnteredAppPresence = true;

      _tokenAllowsAppPresence = true;
      _appPresenceCapabilityDenied = false;
      _deniedAppPresenceChannels.remove(channelName);

      if (asPrimary) {
        _startAppHeartbeat();
        _startAppPresenceSync();
      }
      await _emitAppPresenceSnapshot(channelOverride: channel);
      return true;
    } catch (e) {
      final denied = _isAppChannelCapabilityError(e);
      if (denied) {
        _deniedAppPresenceChannels.add(channelName);
        debugPrint(
          'Ably $channelName not granted by token — skipping it until the '
          'capability changes',
        );
      } else {
        debugPrint('Ably $channelName attach/enter failed: $e');
      }
      if (denied && asPrimary && !_hasEnteredAppPresence) {
        _tokenAllowsAppPresence = false;
      }
      if (asPrimary && !_hasEnteredAppPresence) {
        _appPresenceChannel = null;
        _stopAppPresenceSync();
        _stopAppHeartbeat();
      }
      if (!asPrimary) {
        // A dead secondary would block roster reconciliation; the next
        // ensureAppPresence retries it on a fresh channel.
        _dropSecondaryAppPresence();
      }
      return false;
    }
  }

  /// Release Failed/Detached channel instances so resume can attach again.
  /// Without this, background→foreground keeps a Failed channel and Online
  /// only recovers after a manual pull-to-refresh.
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

  /// Pull capability from a fresh Ably token so we pick up backend grants
  /// without waiting on a race. Also clears hard-deny so fallback can retry.
  Future<void> _refreshAppPresenceCapability() async {
    try {
      final model = await _apiServices.getAblyToken();
      _rememberCapability(model.capability);
      if (_capabilityAllowsAppPresence(model.capability)) {
        _appPresenceCapabilityDenied = false;
      }
      if (_tokenAllowsAppPresence && _realtime != null) {
        try {
          await _realtime!.auth.authorize();
        } catch (_) {}
      }
    } catch (e) {
      debugPrint('Ably capability refresh failed: $e');
    }
  }

  Future<void> _leaveAppPresence() async {
    if (_hasEnteredAppPresence) {
      for (final channel in [_appPresenceChannel, _secondaryAppPresenceChannel]) {
        if (channel == null) continue;
        try {
          await channel.presence.leave();
        } catch (_) {}
      }
    }
    _hasEnteredAppPresence = false;
    _enteredAppChannelNames.clear();
  }

  /// Re-query app-online members (e.g. when opening member search / chat room).
  Future<void> refreshAppPresenceSnapshot() async {
    final primaryChannel = _appPresenceChannel;
    final secondaryChannel = _secondaryAppPresenceChannel;
    final primary = await _emitAppPresenceSnapshot();
    final secondary = secondaryChannel == null
        ? null
        : await _emitAppPresenceSnapshot(channelOverride: secondaryChannel);
    if (primaryChannel == null || primary == null) return;
    if (secondaryChannel != null && secondary == null) return;
    _reconcileAppPresence({
      primaryChannel.name: primary,
      if (secondaryChannel != null && secondary != null)
        secondaryChannel.name: secondary,
    });
  }

  /// Drop memberships Ably no longer lists (their leave was missed while we
  /// were detached / reconnecting) and start the Offline check for peers that
  /// are gone from every app channel. Only called with trusted rosters.
  void _reconcileAppPresence(Map<String, Map<int, Set<String>>> rosters) {
    final now = DateTime.now();
    for (final userId in _appOnlineUserIds.toList()) {
      final keys = _appOnlineMembersByUser[userId];
      keys?.removeWhere((key) {
        final channelName = key.substring(0, key.indexOf('|'));
        return !(rosters[channelName]?[userId]?.contains(key) ?? false);
      });
      if (keys != null && keys.isNotEmpty) continue;
      final lastSeen = _lastPresenceSeenAt[userId];
      if (lastSeen != null &&
          now.difference(lastSeen) < _appPresenceSilentAfter) {
        continue;
      }
      _scheduleAppOfflineCheck(userId);
    }
  }

  void _onAppChannelMessage(ably.Message message) {
    final name = message.name;
    final isCreate = name == 'conversation.created' || name == 'inbox.refresh';
    final isDelete =
        name == 'conversation.deleted' || name == 'conversation.removed';
    if (!isCreate && !isDelete) return;
    final data = _asMap(message.data) ?? const <String, dynamic>{};
    final removedFlag = data['removed'] == true ||
        data['removed'] == 1 ||
        data['removed']?.toString() == 'true';
    _eventsController.add(
      ChatInboxInvalidateEvent(
        conversationId: _asInt(
          data['conversation_id'] ?? data['conversationId'],
        ),
        contextId: _asInt(data['context_id'] ?? data['contextId']),
        chatType: data['chat_type']?.toString() ?? data['chatType']?.toString(),
        removed: isDelete || removedFlag,
      ),
    );
  }

  /// Notify peers that a brand-new conversation exists so their inbox can
  /// refresh even before they subscribe to the conversation channel.
  Future<void> publishConversationCreated({
    required int conversationId,
    int? contextId,
    String? chatType,
  }) async {
    final channel = _appPresenceChannel;
    if (channel == null || !_tokenAllowsAppPresence) return;
    try {
      await channel.publish(
        name: 'conversation.created',
        data: {
          'conversation_id': conversationId,
          if (contextId != null) 'context_id': contextId,
          if (chatType != null) 'chat_type': chatType,
        },
      );
    } catch (e) {
      debugPrint('Ably conversation.created publish failed: $e');
    }
  }

  /// Ask peers to refresh inbox (or drop a removed social/case chat).
  Future<void> publishInboxRefresh({
    int? conversationId,
    int? contextId,
    String? chatType,
    bool removed = false,
  }) async {
    final channel = _appPresenceChannel;
    if (channel == null || !_tokenAllowsAppPresence) return;
    try {
      await channel.publish(
        name: removed ? 'conversation.deleted' : 'inbox.refresh',
        data: {
          if (conversationId != null) 'conversation_id': conversationId,
          if (contextId != null) 'context_id': contextId,
          if (chatType != null) 'chat_type': chatType,
          if (removed) 'removed': true,
        },
      );
    } catch (e) {
      debugPrint('Ably inbox.refresh publish failed: $e');
    }
  }

  /// Marks everyone in [channel]'s roster Online. Returns each peer's member
  /// keys when the roster can be trusted for removals (synced and includes
  /// our own membership), otherwise null.
  Future<Map<int, Set<String>>?> _emitAppPresenceSnapshot({
    ably.RealtimeChannel? channelOverride,
  }) async {
    final channel = channelOverride ?? _appPresenceChannel;
    if (channel == null || !_hasEnteredAppPresence) return null;
    try {
      // waitForSync is critical — get() without params can return [] before
      // Ably finishes sync, so Chats stayed Offline until a peer re-entered
      // (Home refresh). Retry briefly if the first sync still looks empty.
      List<ably.PresenceMessage> members = const [];
      for (var attempt = 0; attempt < 4; attempt++) {
        await _waitForPresenceSync(channel);
        members = await channel.presence
            .get(const ably.RealtimePresenceParams(waitForSync: true))
            .timeout(_presenceGetTimeout);
        if (members.isNotEmpty || attempt == 3) break;
        await Future<void>.delayed(
          Duration(milliseconds: 120 * (attempt + 1)),
        );
      }
      final self = _presenceUserId;
      final channelName = channel.name;
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
        roster
            .putIfAbsent(userId, () => <String>{})
            .add(_appMemberKey(channelName, msg));
      }

      // Adding is always safe. An empty / partial get() must never mark
      // peers Offline.
      roster.forEach((userId, keys) {
        _touchPresenceSeen(userId);
        for (final key in keys) {
          _markAppMemberPresent(userId, key);
        }
      });
      return includesSelf ? roster : null;
    } catch (_) {
      // Channel not attached / failed — ignore (no console spam).
      return null;
    }
  }

  /// Wait until Ably finishes presence sync (or a short timeout).
  Future<void> _waitForPresenceSync(ably.RealtimeChannel channel) async {
    final presence = channel.presence;
    if (presence.syncComplete == true) return;
    final deadline = DateTime.now().add(const Duration(milliseconds: 2000));
    while (DateTime.now().isBefore(deadline)) {
      if (presence.syncComplete == true) return;
      await Future<void>.delayed(const Duration(milliseconds: 40));
    }
  }

  /// True when the Ably token capability map includes either app-online channel
  /// (preferred `presence:app` or fallback `presence:conversation.app`).
  static bool _capabilityAllowsAppPresence(String? capability) {
    return _capabilityAllowsChannel(capability, primaryAppPresenceChannel) ||
        _capabilityAllowsChannel(capability, legacyAppPresenceChannel);
  }

  /// Whether [capability] grants access to [channelName].
  /// Supports Ably wildcards like `presence:conversation.*` / `presence:*` / `*`.
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

  static String conversationChannelName(int conversationId) =>
      'presence:conversation.$conversationId';

  bool _tokenAllowsConversation(int conversationId) {
    if (_capabilityDeniedConversationIds.contains(conversationId)) {
      return false;
    }
    // If we have never seen a capability string, allow the attach attempt —
    // authCallback may still be racing. Denial is handled on 40160.
    final cap = _lastCapability;
    if (cap == null || cap.trim().isEmpty) return true;
    return _capabilityAllowsChannel(
        cap, conversationChannelName(conversationId));
  }

  void _rememberCapability(String? capability) {
    final previous = _lastCapability;
    _lastCapability = capability;
    // Null/empty capability string is common even when the signed token
    // grants channels — do NOT flip _tokenAllowsAppPresence to false here.
    if (capability != null && capability.trim().isNotEmpty) {
      final allowsPreferred =
          _capabilityAllowsChannel(capability, primaryAppPresenceChannel);
      final allowsFallback =
          _capabilityAllowsChannel(capability, legacyAppPresenceChannel);
      final allows = allowsPreferred || allowsFallback;
      _tokenAllowsAppPresence = allows;
      if (allows) _appPresenceCapabilityDenied = false;
    }
    // New token may grant channels that were previously denied.
    if (capability != null && capability.isNotEmpty && capability != previous) {
      _deniedAppPresenceChannels.clear();
      _capabilityDeniedConversationIds.removeWhere(
        (id) => _capabilityAllowsChannel(
          capability,
          conversationChannelName(id),
        ),
      );
    }
  }

  static bool _isCapabilityDeniedError(Object e) {
    final s = e.toString();
    return s.contains('40160') ||
        s.contains('denied access based on given capability') ||
        s.contains('statusCode=401') ||
        s.contains('Channel denied access');
  }

  void _markConversationCapabilityDenied(int conversationId) {
    _capabilityDeniedConversationIds.add(conversationId);
  }

  void _onAppPresenceMessage(ably.PresenceMessage msg, String channelName) {
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
    if (userId == null) return;
    if (userId == _presenceUserId) return;

    final memberKey = _appMemberKey(channelName, msg);
    if (isOnline) {
      _touchPresenceSeen(userId, data: _presenceDataMap(msg));
      _markAppMemberPresent(userId, memberKey);
      return;
    }

    // One leave per connection — another connection or the other app
    // channel may still carry this user.
    final members = _appOnlineMembersByUser[userId];
    members?.remove(memberKey);
    if (members != null && members.isNotEmpty) return;
    _scheduleAppOfflineCheck(userId);
  }

  static String _appMemberKey(String channelName, ably.PresenceMessage msg) =>
      '$channelName|${msg.connectionId ?? ''}|${msg.clientId ?? ''}';

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
    var verified = false;
    for (final channel in _liveAppPresenceChannels()) {
      try {
        final members = await channel.presence
            .get(const ably.RealtimePresenceParams(waitForSync: true))
            .timeout(_presenceGetTimeout);
        verified = true;
        for (final msg in members) {
          if (_userIdFromPresence(msg) != userId) continue;
          _touchPresenceSeen(userId);
          _markAppMemberPresent(userId, _appMemberKey(channel.name, msg));
        }
      } catch (_) {}
    }
    if (stillListed() || _pendingAppOfflineChecks.containsKey(userId)) return;
    if (!verified) {
      // Our own connection / channels are down — keep the last known state
      // and retry; the roster sync after reconnect / resume settles it.
      if (_appInForeground) _scheduleAppOfflineCheck(userId);
      return;
    }
    _setAppUserOffline(userId);
  }

  void _setAppUserOffline(int userId) {
    _pendingAppOfflineChecks.remove(userId)?.cancel();
    _appOnlineMembersByUser.remove(userId);
    _clearPresenceSeen(userId);
    if (!_appOnlineUserIds.remove(userId)) return;
    _eventsController.add(
      ChatAppPresenceChangedEvent(userId: userId, isOnline: false),
    );
  }

  List<ably.RealtimeChannel> _liveAppPresenceChannels() {
    final realtime = _realtime;
    if (realtime == null || !identical(_appPresenceRealtime, realtime)) {
      return const [];
    }
    return [
      for (final channel in [_appPresenceChannel, _secondaryAppPresenceChannel])
        if (channel != null && channel.state == ably.ChannelState.attached)
          channel,
    ];
  }

  void _cancelPendingAppOfflineChecks() {
    for (final timer in _pendingAppOfflineChecks.values) {
      timer.cancel();
    }
    _pendingAppOfflineChecks.clear();
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
      // Attach/presence require Connected — never return while still Connecting.
      if (state == ably.ConnectionState.connected) {
        return;
      }
      if (state == ably.ConnectionState.connecting) {
        await _waitForConnectionConnected();
        return;
      }
      // After background leave / brief disconnect, reconnect the same client.
      if (state == ably.ConnectionState.disconnected ||
          state == ably.ConnectionState.suspended) {
        try {
          await _realtime!.connection.connect();
          await _waitForConnectionConnected();
          return;
        } catch (e) {
          debugPrint('Ably reconnect failed: $e');
        }
      }
      if (state == ably.ConnectionState.closing ||
          state == ably.ConnectionState.closed ||
          state == ably.ConnectionState.failed) {
        final dead = _realtime!;
        _discardRealtimeBoundState();
        try {
          await dead.close();
        } catch (_) {}
        if (identical(_realtime, dead)) _realtime = null;
      }
    }

    // Deduplicate concurrent connect calls.
    if (_connectFuture != null) {
      await _connectFuture;
      // Prior connect may still be mid-flight — wait until Connected.
      if (_realtime?.connection.state == ably.ConnectionState.connected) {
        return;
      }
      await _waitForConnectionConnected();
      return;
    }

    _connectFuture = _doConnect(clientId);
    try {
      await _connectFuture;
    } finally {
      _connectFuture = null;
    }
  }

  /// Channel.attach() throws "Can't attach when not in an active state" unless
  /// the Realtime connection is Connected.
  ///
  /// Keep the timeout tight so [presence:app] enter stays ~1s instead of
  /// hanging peers on "Offline" while the sender can already chat.
  Future<void> _waitForConnectionConnected({
    Duration timeout = const Duration(seconds: 5),
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
      // Faster offline when peer force-quits / loses network without leave().
      transportParams: const {
        'remainPresentFor': _remainPresentForMs,
        'heartbeatInterval': _heartbeatIntervalMs,
      },
    );
    final realtime = ably.Realtime(options: options);
    _realtime = realtime;
    _watchConnection(realtime);

    try {
      await _waitForConnectionConnected();
      // The connection itself already fetched a token via authCallback,
      // so mark authorize as fresh to avoid a redundant second token call.
      if (_realtime?.connection.state == ably.ConnectionState.connected) {
        _lastAuthorizeTime = DateTime.now();
      }
    } catch (e) {
      debugPrint('Ably wait-for-connected: $e');
    }
  }

  /// Ably re-attaches and re-enters by itself after a drop; bump presence as
  /// soon as it's back, and rebuild the client if the connection failed while
  /// the app is still open (it never recovers on its own from Failed).
  void _watchConnection(ably.Realtime realtime) {
    unawaited(_connectionStateSubscription?.cancel());
    var connectedBefore = false;
    _connectionStateSubscription = realtime.connection.on().listen(
      (change) {
        if (!identical(realtime, _realtime)) return;
        switch (change.current) {
          case ably.ConnectionState.connected:
            if (connectedBefore) {
              unawaited(_sendAppPresenceHeartbeat());
              unawaited(refreshAppPresenceSnapshot());
            }
            connectedBefore = true;
          case ably.ConnectionState.failed:
            unawaited(
              _repairAppPresence(
                'connection failed: ${change.reason?.message}',
              ),
            );
          default:
            break;
        }
      },
      onError: (_) {},
    );
  }

  /// App-online channels and subscriptions die with their Realtime client.
  void _discardAppPresenceChannels() {
    unawaited(_appPresenceSubscription?.cancel());
    unawaited(_appMessageSubscription?.cancel());
    unawaited(_secondaryAppPresenceSubscription?.cancel());
    _appPresenceSubscription = null;
    _appMessageSubscription = null;
    _secondaryAppPresenceSubscription = null;
    _appPresenceSubscribedChannel = null;
    _secondaryAppPresenceSubscribedChannel = null;
    _appPresenceChannel = null;
    _secondaryAppPresenceChannel = null;
    _appPresenceRealtime = null;
    _hasEnteredAppPresence = false;
    _enteredAppChannelNames.clear();
  }

  /// Before replacing a closed / failed client: drop everything bound to it
  /// so the next attach/enter runs on the new connection. Conversation
  /// channels are queued for re-attach (see [onAppResumed]).
  void _discardRealtimeBoundState() {
    unawaited(_connectionStateSubscription?.cancel());
    _connectionStateSubscription = null;
    _discardAppPresenceChannels();
    _pendingResubscribeIds.addAll(_bindings.keys);
    final activeId = _activeChatConversationId;
    if (activeId != null) _pendingResubscribeIds.add(activeId);
    for (final binding in _bindings.values) {
      unawaited(binding.presenceSubscription?.cancel());
      unawaited(binding.subscription.cancel());
    }
    _bindings.clear();
  }

  /// Rate-limited authorize — at most once per 30 seconds.
  Future<void> _authorizeIfNeeded() async {
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
    try {
      await _realtime!.auth.authorize();
      _lastAuthorizeTime = DateTime.now();
    } catch (e) {
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
      activity: ChatComposerActivity.none,
    ));
  }

  /// Attach when possible. Failed channels must be released + recreated by
  /// [_ensureConversationChannelAttached] — attach alone cannot leave Failed.
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

    var state = channel.state;
    if (state == ably.ChannelState.attached) return;
    if (state == ably.ChannelState.failed) {
      throw StateError(
        'Ably channel ${channel.name} is Failed — needs release/recreate',
      );
    }
    // Detaching → wait for Detached, then attach. Attaching/suspended → wait.
    if (state == ably.ChannelState.detaching ||
        state == ably.ChannelState.attaching ||
        state == ably.ChannelState.suspended) {
      await _waitForChannelTerminalAttach(channel);
      state = channel.state;
      if (state == ably.ChannelState.attached) return;
      if (state == ably.ChannelState.failed) {
        throw StateError(
          'Ably channel ${channel.name} is Failed — needs release/recreate',
        );
      }
      if (state != ably.ChannelState.detached &&
          state != ably.ChannelState.initialized) {
        return;
      }
    }
    await channel.attach();
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
  /// release it and recreate subscriptions so presence can work again.
  Future<_ChannelBinding?> _ensureConversationChannelAttached({
    required int conversationId,
    required _ChannelBinding binding,
  }) async {
    final realtime = _realtime;
    if (realtime == null) return null;

    if (!_tokenAllowsConversation(conversationId)) {
      return null;
    }

    // Never call channel.attach while the connection is connecting/closed.
    await _ensureConnected(
      clientId: _presenceUserId != null ? '$_presenceUserId' : null,
    );
    if (_realtime?.connection.state != ably.ConnectionState.connected) {
      debugPrint(
        'Ably ensure attach skipped ($conversationId): connection not connected '
        '(state=${_realtime?.connection.state.name})',
      );
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
        _markConversationCapabilityDenied(conversationId);
        await _detachChannel(conversationId);
        return null;
      }
      debugPrint(
        'Ably ensure attach failed ($conversationId): $e',
      );
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

    if (!_tokenAllowsConversation(conversationId)) {
      return null;
    }

    final channelName = previous.channel.name;
    final wasActive = previous.isActiveChat;

    try {
      await previous.presenceSubscription?.cancel();
    } catch (_) {}
    try {
      await previous.subscription.cancel();
    } catch (_) {}

    try {
      // Failed / Detached can be released without a successful detach.
      realtime.channels.release(channelName);
    } catch (e) {
      debugPrint('Ably channel release failed ($conversationId): $e');
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
        debugPrint(
          'Ably channel re-attach skipped ($conversationId): '
          'connection not connected',
        );
        return null;
      }
      final channel = live.channels.get(channelName);
      await channel.attach();
      if (channel.state != ably.ChannelState.attached) {
        debugPrint(
          'Ably channel re-attach incomplete ($conversationId): '
          '${channel.state.name}',
        );
        return null;
      }

      final sub = channel.subscribe().listen(
            (msg) => _onMessage(msg, conversationId: conversationId),
            onError: (Object e) => debugPrint('Ably subscribe error: $e'),
          );
      final next = _ChannelBinding(
        channel: channel,
        subscription: sub,
        isActiveChat: wasActive,
        // Must re-enter after recreate — Failed wiped presence membership.
        hasEnteredPresence: false,
      );
      _bindings[conversationId] = next;
      debugPrint(
        'Ably recovered failed channel ${conversationChannelName(conversationId)}',
      );
      return next;
    } catch (e) {
      if (_isCapabilityDeniedError(e)) {
        _markConversationCapabilityDenied(conversationId);
        try {
          _realtime?.channels.release(channelName);
        } catch (_) {}
        _bindings.remove(conversationId);
        debugPrint(
          'Ably skip ${conversationChannelName(conversationId)} — '
          'token capability denied',
        );
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
      'ts': DateTime.now().millisecondsSinceEpoch,
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

  /// Broadcast WhatsApp-style composer activity to peers via Ably presence.
  Future<void> updateComposerActivity({
    required int conversationId,
    required ChatComposerActivity activity,
  }) async {
    if (_activeChatConversationId == conversationId) {
      _localComposerActivity = activity;
    }
    var binding = _bindings[conversationId];
    if (binding == null) return;
    final userId = _presenceUserId;
    if (userId == null) return;

    // Soft leave / resume races clear membership while the chat is still open.
    // Re-enter so recording/upload status reaches peers.
    if (!binding.hasEnteredPresence) {
      if (_activeChatConversationId != conversationId) return;
      try {
        final ready = await _ensureConversationChannelAttached(
          conversationId: conversationId,
          binding: binding,
        );
        if (ready == null) return;
        binding = ready;
        await _enterPresence(
          binding.channel,
          currentUserId: userId,
          displayName: _presenceDisplayName,
          imageUrl: _presenceImageUrl,
        );
        binding.hasEnteredPresence = true;
      } catch (e) {
        debugPrint('Ably presence re-enter for activity failed: $e');
        return;
      }
    }

    try {
      if (binding.channel.state != ably.ChannelState.attached) {
        final ready = await _ensureConversationChannelAttached(
          conversationId: conversationId,
          binding: binding,
        );
        if (ready == null) return;
        binding = ready;
      }
      await binding.channel.presence
          .update(_presencePayload(activity: activity));
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
      _touchPresenceSeen(userId, data: _presenceDataMap(msg));
      _lastOnlineByConversation
          .putIfAbsent(conversationId, () => <int>{})
          .add(userId);
    } else if (isOffline && userId != null) {
      // Conversation leave ≠ app offline. Do NOT clear global last-seen —
      // that made the stale sweeper treat them as epoch-stale and flash
      // Offline→Online for peers still on presence:app.
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

    // Composer activity (recording / uploading) rides on presence updates so
    // peers see it even when the typing REST API only supports is_typing.
    // Never echo our own updates as peer typing.
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
    // from the app user id (or be a non-user token id).
    final data = msg.data;
    Map<dynamic, dynamic>? map;
    if (data is Map) {
      map = data;
    } else if (data is String && data.isNotEmpty) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map) map = decoded;
      } catch (_) {}
    }
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
    if (binding.presenceSubscription == null) {
      binding.presenceSubscription =
          binding.channel.presence.subscribe().listen(
                (msg) => _emitPresence(conversationId, msg),
                onError: (Object e) => debugPrint('Ably presence error: $e'),
              );
    }
    await _emitCurrentPresenceMembers(
      conversationId: conversationId,
      binding: binding,
      currentUserId: currentUserId,
    );
  }

  /// Re-broadcast who is currently present (needed when opening a chat room
  /// on a channel that was already subscribed by the inbox).
  /// Also emits offline for peers who were online but are gone now.
  Future<void> _emitCurrentPresenceMembers({
    required int conversationId,
    required _ChannelBinding binding,
    int? currentUserId,
  }) async {
    final ready = await _ensureConversationChannelAttached(
      conversationId: conversationId,
      binding: binding,
    );
    if (ready == null) {
      if (!_capabilityDeniedConversationIds.contains(conversationId)) {
        debugPrint(
          'Ably presence get skipped ($conversationId): channel not attached',
        );
      }
      return;
    }
    try {
      final members = await ready.channel.presence.get(
        const ably.RealtimePresenceParams(waitForSync: true),
      );
      final currentlyOnline = <int>{};
      var selfStillPresent = false;
      for (final member in members) {
        final clientId = member.clientId;
        final userId = _userIdFromPresence(member);
        if (userId != null && clientId != null && clientId.isNotEmpty) {
          _presenceClientToUserId[clientId] = userId;
        }
        if (currentUserId != null) {
          if (clientId == '$currentUserId' || userId == currentUserId) {
            // Still listed on a chat we are not viewing — leave so the peer
            // stops getting blue ticks while we browse Chats.
            if (conversationId != _activeChatConversationId) {
              selfStillPresent = true;
            }
            continue;
          }
        }
        if (clientId == null && userId == null) continue;
        if (userId != null) {
          currentlyOnline.add(userId);
          _touchPresenceSeen(userId, data: _presenceDataMap(member));
        }
        _eventsController.add(
          ChatPresenceChangedEvent(
            conversationId: conversationId,
            clientId: clientId,
            userId: userId,
            isOnline: true,
          ),
        );
      }

      if (selfStillPresent) {
        unawaited(
          _leaveConversationPresence(
            ready,
            reason: 'stale self on $conversationId',
          ),
        );
      }

      final previous =
          _lastOnlineByConversation[conversationId] ?? const <int>{};
      final isActiveChat = conversationId == _activeChatConversationId;
      if (isActiveChat) {
        // Additive only in the open room. A presence.get() right after we
        // send (typing stop / presence.update) often omits peers who are
        // still present and used to flip the header offline.
        _lastOnlineByConversation[conversationId] = {
          ...previous,
          ...currentlyOnline,
        };
      } else {
        // Inbox listeners: drop peers no longer in the roster so a missed
        // leave cannot keep message.read → blue ticks forever.
        for (final leftId in previous.difference(currentlyOnline)) {
          _eventsController.add(
            ChatPresenceChangedEvent(
              conversationId: conversationId,
              clientId: null,
              userId: leftId,
              isOnline: false,
            ),
          );
        }
        _lastOnlineByConversation[conversationId] = currentlyOnline;
      }
    } catch (e) {
      debugPrint('Ably presence get failed: $e');
    }
  }

  /// Refresh presence for one conversation (active chat safety net).
  Future<void> refreshPresenceSnapshot(int conversationId) async {
    final binding = _bindings[conversationId];
    if (binding == null) return;
    await _emitCurrentPresenceMembers(
      conversationId: conversationId,
      binding: binding,
      currentUserId: _presenceUserId,
    );
  }

  void _startActivePresenceSync() {
    _activePresenceSyncTimer?.cancel();
    _activePresenceSyncTimer = Timer.periodic(const Duration(seconds: 12), (_) {
      final id = _activeChatConversationId;
      if (id == null) return;
      unawaited(refreshPresenceSnapshot(id));
    });
  }

  void _stopActivePresenceSync() {
    _activePresenceSyncTimer?.cancel();
    _activePresenceSyncTimer = null;
  }

  void _touchPresenceSeen(int userId, {Map<dynamic, dynamic>? data}) {
    _lastPresenceSeenAt[userId] = DateTime.now();
    // Only treat peers as heartbeat-capable when their payload includes `ts`.
    // Snapshot membership alone must NOT enroll heartbeat tracking.
    if (data != null && data['ts'] != null) {
      _heartbeatCapableUserIds.add(userId);
    }
  }

  void _clearPresenceSeen(int userId) {
    _lastPresenceSeenAt.remove(userId);
    _heartbeatCapableUserIds.remove(userId);
  }

  void _startAppHeartbeat() {
    _appHeartbeatTimer?.cancel();
    _appHeartbeatTimer = Timer.periodic(_appHeartbeatEvery, (_) {
      unawaited(_sendAppPresenceHeartbeat());
    });
    // Immediate bump so peers don't wait a full interval after we enter.
    unawaited(_sendAppPresenceHeartbeat());
  }

  void _stopAppHeartbeat() {
    _appHeartbeatTimer?.cancel();
    _appHeartbeatTimer = null;
  }

  Future<void> _sendAppPresenceHeartbeat() async {
    if (_presenceUserId == null) return;
    if (!_appInForeground || _isLeavingForBackground) return;
    // App-wide presence never carries chat composer activity.
    final appPayload = _presencePayload(activity: ChatComposerActivity.none);

    // Membership is the source of truth — don't gate on capability flags
    // (those can lag behind a successful enter when the API omits capability).
    if (_hasEnteredAppPresence) {
      final realtime = _realtime;
      if (realtime == null || !identical(_appPresenceRealtime, realtime)) {
        unawaited(_repairAppPresence('app-online channels from a closed client'));
      } else {
        for (final appChannel in [
          _appPresenceChannel,
          _secondaryAppPresenceChannel,
        ]) {
          if (appChannel == null) continue;
          try {
            // update() also re-enters if Ably dropped our membership.
            await appChannel.presence.update(appPayload);
          } catch (e) {
            if (identical(appChannel, _appPresenceChannel)) {
              unawaited(_repairAppPresence('heartbeat failed: $e'));
            }
          }
        }
      }
    }

    final activeId = _activeChatConversationId;
    if (activeId == null) return;
    final binding = _bindings[activeId];
    if (binding == null ||
        binding.channel.state != ably.ChannelState.attached) {
      return;
    }
    try {
      // Keep typing/recording/upload status across heartbeats; also re-enters
      // the open chat if something dropped us from it.
      await binding.channel.presence.update(
        _presencePayload(activity: _localComposerActivity),
      );
      if (_activeChatConversationId == activeId) {
        binding.hasEnteredPresence = true;
      }
    } catch (e) {
      debugPrint('Ably conversation presence heartbeat failed: $e');
    }
  }

  void _startPresenceWatchdog() {
    _presenceWatchdogTimer ??= Timer.periodic(
      _presenceWatchdogEvery,
      (_) => _checkOwnAppPresence(),
    );
  }

  void _stopPresenceWatchdog() {
    _presenceWatchdogTimer?.cancel();
    _presenceWatchdogTimer = null;
  }

  /// WhatsApp rule: Online for as long as the app is open. Re-establish our
  /// membership whenever the connection, a channel, or the open chat binding
  /// died while we stayed in the foreground.
  void _checkOwnAppPresence() {
    if (_presenceUserId == null ||
        !_appInForeground ||
        _isLeavingForBackground) {
      return;
    }
    final realtime = _realtime;
    final conn = realtime?.connection.state;
    if (conn == ably.ConnectionState.connecting) return;
    if (realtime == null || conn != ably.ConnectionState.connected) {
      unawaited(_repairAppPresence('connection ${conn?.name ?? 'missing'}'));
      return;
    }

    final primary = _appPresenceChannel;
    final primaryHealthy = _hasEnteredAppPresence &&
        primary != null &&
        identical(_appPresenceRealtime, realtime) &&
        primary.state == ably.ChannelState.attached;
    final activeId = _activeChatConversationId;
    final activeUnbound = activeId != null &&
        !_bindings.containsKey(activeId) &&
        !_capabilityDeniedConversationIds.contains(activeId);
    if (activeUnbound) _pendingResubscribeIds.add(activeId);
    if (!primaryHealthy || activeUnbound || _pendingResubscribeIds.isNotEmpty) {
      unawaited(
        _repairAppPresence(
          'app-online ${primary?.state.name ?? 'missing'}, '
          'open chat bound=${!activeUnbound}, '
          'pending=${_pendingResubscribeIds.length}',
        ),
      );
      return;
    }

    final secondary = _secondaryAppPresenceChannel;
    if (secondary != null &&
        (secondary.state == ably.ChannelState.failed ||
            secondary.state == ably.ChannelState.detached)) {
      unawaited(
        _repairAppPresence('secondary ${secondary.state.name}', light: true),
      );
    }
    if (_appHeartbeatTimer == null) _startAppHeartbeat();
    if (_appPresenceSyncTimer == null) _startAppPresenceSync();
  }

  /// [light] only re-runs the app-online attach; otherwise do the full resume
  /// path (reconnect, re-enter, re-attach queued conversation channels).
  Future<void> _repairAppPresence(String reason, {bool light = false}) async {
    final userId = _presenceUserId;
    if (userId == null || !_appInForeground || _isLeavingForBackground) {
      return;
    }
    if (_presenceRepairFuture != null || _resumeInFlight > 0) return;
    final now = DateTime.now();
    final last = _lastPresenceRepairAt;
    if (last != null && now.difference(last) < _presenceRepairBackoff) return;
    _lastPresenceRepairAt = now;
    debugPrint('Ably app-online repair: $reason');

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
      debugPrint('Ably app-online repair failed: $e');
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

  Timer? _appPresenceSyncTimer;

  void _startAppPresenceSync() {
    _appPresenceSyncTimer?.cancel();
    // Burst snapshots after attach so opening Chats picks up peers who were
    // already Online (get() can race sync on some devices).
    unawaited(() async {
      for (final delayMs in [300, 900, 2000]) {
        await Future<void>.delayed(Duration(milliseconds: delayMs));
        if (!_hasEnteredAppPresence) return;
        await refreshAppPresenceSnapshot();
      }
    }());
    _appPresenceSyncTimer = Timer.periodic(const Duration(seconds: 8), (_) {
      unawaited(refreshAppPresenceSnapshot());
    });
  }

  void _stopAppPresenceSync() {
    _appPresenceSyncTimer?.cancel();
    _appPresenceSyncTimer = null;
  }




  /// Brief inactive (control center / notification shade): do NOT stop app
  /// heartbeats or presence:app. Stopping them made Chats-tab users look
  /// Offline after ~5s even while still in the app. Real background still
  /// leaves via [onAppPaused].
  Future<void> onAppInactiveSoftLeave() async {
    if (_isLeavingForBackground || _softLeftPresence) return;
    _softLeftPresence = true;
    // Pause only the open-chat presence sync — keep app Online heartbeat.
    _stopActivePresenceSync();
  }

  /// App backgrounded / killed path — leave presence so peers go offline.
  /// Leaves run in parallel, then we close the connection so Ably drops
  /// presence immediately when the leave packet makes it out.
  ///
  /// Uses [_lifecycleEpoch] so a quick resume cannot be undone by a late
  /// `close()` from this pause (that left peers seeing Offline forever).
  Future<void> onAppPaused() async {
    if (_isLeavingForBackground) return;
    final epoch = ++_lifecycleEpoch;
    _isLeavingForBackground = true;
    _lifecycleLeaveTimer?.cancel();
    _lifecycleLeaveTimer = null;
    _softLeftPresence = false;
    try {
      _stopPresenceWatchdog();
      _cancelPendingAppOfflineChecks();
      _stopActivePresenceSync();
      _stopAppHeartbeat();
      _stopAppPresenceSync();

      final tasks = <Future<void>>[];

      final appChannel = _appPresenceChannel;
      final secondary = _secondaryAppPresenceChannel;
      if ((appChannel != null || secondary != null) &&
          _hasEnteredAppPresence) {
        _hasEnteredAppPresence = false;
        _enteredAppChannelNames.clear();
        for (final ch in [appChannel, secondary]) {
          if (ch == null) continue;
          tasks.add(() async {
            try {
              await ch.presence.leave();
            } catch (_) {}
          }());
        }
      }

      for (final binding in _bindings.values) {
        if (!binding.hasEnteredPresence) continue;
        binding.hasEnteredPresence = false;
        final channel = binding.channel;
        tasks.add(() async {
          try {
            await channel.presence.leave();
          } catch (e) {
            debugPrint('Ably presence leave (pause) failed: $e');
          }
        }());
      }

      if (tasks.isNotEmpty) {
        try {
          await Future.wait(tasks).timeout(const Duration(milliseconds: 450));
        } on TimeoutException {
          debugPrint('Ably presence leave (pause) timed out');
        }
      }

      // Aborted — user already came back; do not tear down the new session.
      if (epoch != _lifecycleEpoch) return;

      // Closing forces an immediate presence leave on Ably's side when possible.
      _pendingResubscribeIds.addAll(_bindings.keys);
      final activeId = _activeChatConversationId;
      if (activeId != null) _pendingResubscribeIds.add(activeId);

      for (final binding in _bindings.values) {
        try {
          await binding.presenceSubscription?.cancel();
        } catch (_) {}
        try {
          await binding.subscription.cancel();
        } catch (_) {}
      }
      _bindings.clear();
      try {
        await _appPresenceSubscription?.cancel();
      } catch (_) {}
      _appPresenceSubscription = null;
      try {
        await _appMessageSubscription?.cancel();
      } catch (_) {}
      _appMessageSubscription = null;
      try {
        await _secondaryAppPresenceSubscription?.cancel();
      } catch (_) {}
      _secondaryAppPresenceSubscription = null;
      _appPresenceSubscribedChannel = null;
      _secondaryAppPresenceSubscribedChannel = null;
      _appPresenceChannel = null;
      _secondaryAppPresenceChannel = null;
      _hasEnteredAppPresence = false;
      _enteredAppChannelNames.clear();

      if (epoch != _lifecycleEpoch) return;

      try {
        await _realtime?.close().timeout(const Duration(milliseconds: 400));
      } catch (e) {
        debugPrint('Ably close (pause) failed: $e');
      }

      if (epoch != _lifecycleEpoch) return;

      unawaited(_connectionStateSubscription?.cancel());
      _connectionStateSubscription = null;
      _realtime = null;
      _appPresenceRealtime = null;
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
        // Keep Online — notification shade / permission sheets fire inactive
        // without the user leaving the app (WhatsApp stays green here).
        _lifecycleLeaveTimer?.cancel();
        _lifecycleLeaveTimer = null;
        break;
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _appInForeground = false;
        _lifecycleLeaveTimer?.cancel();
        _lifecycleLeaveTimer = null;
        _scheduleBackgroundLeave();
        break;
      case AppLifecycleState.resumed:
        _appInForeground = true;
        _lifecycleLeaveTimer?.cancel();
        _lifecycleLeaveTimer = null;
        _cancelBackgroundLeave();
        // Invalidate any in-flight pause teardown immediately.
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
        break;
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

  /// App resumed — restore app-wide online + open-chat conversation presence.
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
    // Cancel in-flight pause so it cannot close the connection we rebuild.
    _cancelBackgroundLeave();
    _lifecycleEpoch++;
    _isLeavingForBackground = false;
    _softLeftPresence = false;

    _presenceUserId = currentUserId;
    if (displayName != null) _presenceDisplayName = displayName;
    if (imageUrl != null) _presenceImageUrl = imageUrl;
    _startPresenceWatchdog();

    // Let an in-flight pause abort before we reconnect (avoids close-after-enter).
    await Future<void>.delayed(const Duration(milliseconds: 80));
    if (!_appInForeground) return;

    // Allow one more presence:app attempt after background — a stale deny
    // must never keep the user invisible.
    _appPresenceCapabilityDenied = false;
    _deniedAppPresenceChannels.remove(primaryAppPresenceChannel);

    final conn = _realtime?.connection.state;
    final softOnly = _realtime != null &&
        _pendingResubscribeIds.isEmpty &&
        _hasEnteredAppPresence &&
        conn == ably.ConnectionState.connected;

    // Dead connection after background — drop it so _ensureConnected rebuilds.
    final current = _realtime;
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

    // Always force enter/update FIRST so peers flip Online within ~1s.
    var entered = false;
    try {
      await ensureAppPresence(
        currentUserId: currentUserId,
        displayName: displayName ?? _presenceDisplayName,
        imageUrl: imageUrl ?? _presenceImageUrl,
        forceReenter: true,
      );
      entered = _hasEnteredAppPresence;
    } catch (e) {
      debugPrint('Ably ensureAppPresence on resume failed: $e');
    }
    if (!entered) {
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

    // Soft inactive / connection survived — bump online and only re-sync the
    // open chat (skip O(n) channel re-attach storm).
    if (softOnly && _realtime != null && _hasEnteredAppPresence) {
      final activeId = _activeChatConversationId;
      if (activeId != null) {
        await subscribeToConversation(
          conversationId: activeId,
          currentUserId: currentUserId,
          displayName: displayName ?? _presenceDisplayName,
          imageUrl: imageUrl ?? _presenceImageUrl,
        );
      }
      _startAppHeartbeat();
      _startAppPresenceSync();
      return;
    }

    // Re-attach channels torn down when we closed the connection on pause.
    // Cap fan-out — reattaching dozens of channels after a notification tap
    // is a common Simulator jetsam path.
    final pending = _pendingResubscribeIds.toList(growable: false);
    _pendingResubscribeIds.clear();
    final activeId = _activeChatConversationId;
    final capped = <int>[];
    if (activeId != null && pending.contains(activeId)) {
      capped.add(activeId);
    }
    for (final id in pending) {
      if (capped.length >= 20) break;
      if (!capped.contains(id)) capped.add(id);
    }
    for (final conversationId in capped) {
      if (_bindings.containsKey(conversationId)) continue;
      final isActive = conversationId == activeId;
      if (isActive) {
        await subscribeToConversation(
          conversationId: conversationId,
          currentUserId: currentUserId,
          displayName: displayName ?? _presenceDisplayName,
          imageUrl: imageUrl ?? _presenceImageUrl,
        );
      } else {
        await _attachChannel(
          conversationId: conversationId,
          enterPresence: false,
          displayName: displayName ?? _presenceDisplayName,
          imageUrl: imageUrl ?? _presenceImageUrl,
          currentUserId: currentUserId,
          isActiveChat: false,
          refreshPresenceSnapshot: false,
        );
      }
    }

    for (final entry in _bindings.entries.toList()) {
      final conversationId = entry.key;
      var binding = entry.value;
      final healed = await _ensureConversationChannelAttached(
        conversationId: conversationId,
        binding: binding,
      );
      if (healed != null) binding = healed;

      final isActive = conversationId == _activeChatConversationId;
      if (!isActive) {
        // Always leave — Ably auto-re-entry can put us back after reconnect
        // even when hasEnteredPresence is already false.
        await _leaveConversationPresence(binding, reason: 'resume inbox');
        await _startPresenceListening(
          conversationId: conversationId,
          binding: binding,
          currentUserId: currentUserId,
        );
        continue;
      }
      if (binding.hasEnteredPresence) {
        await _startPresenceListening(
          conversationId: conversationId,
          binding: binding,
          currentUserId: currentUserId,
        );
        continue;
      }
      try {
        await _enterPresence(
          binding.channel,
          currentUserId: currentUserId,
          displayName: _presenceDisplayName,
          imageUrl: _presenceImageUrl,
        );
        binding.hasEnteredPresence = true;
      } catch (e) {
        debugPrint('Ably presence enter (resume) failed: $e');
      }
      await _startPresenceListening(
        conversationId: conversationId,
        binding: binding,
        currentUserId: currentUserId,
      );
    }

    if (_activeChatConversationId != null) {
      _startActivePresenceSync();
    }
    _startAppHeartbeat();
    _startAppPresenceSync();
  }

  Future<void> _attachChannel({
    required int conversationId,
    required bool enterPresence,
    String? displayName,
    String? imageUrl,
    int? currentUserId,
    bool isActiveChat = false,
    bool refreshPresenceSnapshot = true,
  }) async {
    if (!_tokenAllowsConversation(conversationId)) {
      return;
    }

    final existing = _bindings[conversationId];
    if (existing != null) {
      // Heal Failed/Detached channels before presence enter/get.
      final binding = await _ensureConversationChannelAttached(
            conversationId: conversationId,
            binding: existing,
          ) ??
          _bindings[conversationId];
      if (binding == null) return;

      // Already subscribed — upgrade when opening a chat room; inbox stays
      // listen-only (no presence enter) so read receipts stay correct.
      if (!isActiveChat) {
        // Never drop the open chat's presence from an inbox sync — inbox syncs
        // run on every incoming message, and the peer would see us leave the
        // room (Offline, no blue ticks) each time.
        final isOpenChat = conversationId == _activeChatConversationId;
        if (!enterPresence && !isOpenChat && binding.hasEnteredPresence) {
          // Leave even if the flag says we already left — SDK may have
          // re-entered presence after a reconnect (false blue ticks on Chats).
          await _leaveConversationPresence(binding, reason: 'inbox listen-only');
        } else if (enterPresence &&
            currentUserId != null &&
            !binding.hasEnteredPresence) {
          try {
            await _enterPresence(
              binding.channel,
              currentUserId: currentUserId,
              displayName: displayName,
              imageUrl: imageUrl,
            );
            binding.hasEnteredPresence = true;
          } catch (e) {
            if (_isCapabilityDeniedError(e)) {
              _markConversationCapabilityDenied(conversationId);
              await _detachChannel(conversationId);
              return;
            }
            debugPrint('Ably presence enter (inbox) failed: $e');
          }
        }
        // Skip re-snapshot on routine inbox sync — presence.get() per thread
        // on every refresh is a major Simulator memory spike.
        if (refreshPresenceSnapshot) {
          await _startPresenceListening(
            conversationId: conversationId,
            binding: binding,
            currentUserId: currentUserId,
          );
        } else if (binding.presenceSubscription == null) {
          await _startPresenceListening(
            conversationId: conversationId,
            binding: binding,
            currentUserId: currentUserId,
          );
        }
        return;
      }
      // Upgrade inbox listener → active chat (enter presence if needed).
      if (isActiveChat) {
        _activeChatConversationId = conversationId;
        binding.isActiveChat = true;
        if (enterPresence &&
            currentUserId != null &&
            !binding.hasEnteredPresence) {
          try {
            await _enterPresence(
              binding.channel,
              currentUserId: currentUserId,
              displayName: displayName,
              imageUrl: imageUrl,
            );
            binding.hasEnteredPresence = true;
          } catch (e) {
            if (_isCapabilityDeniedError(e)) {
              _markConversationCapabilityDenied(conversationId);
              await _detachChannel(conversationId);
              return;
            }
            debugPrint('Ably presence enter (upgrade) failed: $e');
          }
        }
        // Always (re)listen + snapshot members so chat room gets current
        // online state even if inbox already subscribed earlier.
        await _startPresenceListening(
          conversationId: conversationId,
          binding: binding,
          currentUserId: currentUserId,
        );
      }
      return;
    }

    final channelName = conversationChannelName(conversationId);
    final channel = _realtime!.channels.get(channelName);

    var hasPresence = false;
    try {
      await channel.attach();
      if (enterPresence && currentUserId != null) {
        await _enterPresence(
          channel,
          currentUserId: currentUserId,
          displayName: displayName,
          imageUrl: imageUrl,
        );
        hasPresence = true;
      }
    } catch (e) {
      if (_isCapabilityDeniedError(e)) {
        _markConversationCapabilityDenied(conversationId);
        try {
          _realtime!.channels.release(channelName);
        } catch (_) {}
        debugPrint(
          'Ably skip $channelName — token capability denied',
        );
        return;
      }
      debugPrint('Ably channel attach failed ($conversationId): $e');
      // Don't keep a Failed channel binding — it only feeds recover spam.
      if (channel.state == ably.ChannelState.failed) {
        try {
          _realtime!.channels.release(channelName);
        } catch (_) {}
        return;
      }
    }

    final sub = channel.subscribe().listen(
          (msg) => _onMessage(msg, conversationId: conversationId),
          onError: (Object e) => debugPrint('Ably subscribe error: $e'),
        );
    final binding = _ChannelBinding(
      channel: channel,
      subscription: sub,
      isActiveChat: isActiveChat,
      hasEnteredPresence: hasPresence,
    );
    _bindings[conversationId] = binding;
    if (isActiveChat) {
      _activeChatConversationId = conversationId;
    }
    // Inbox + chat room both need presence so online/offline stays live.
    await _startPresenceListening(
      conversationId: conversationId,
      binding: binding,
      currentUserId: currentUserId,
    );
  }

  /// Active chat room — enter presence so others see you online in-thread.
  Future<void> subscribeToConversation({
    required int conversationId,
    required int currentUserId,
    String? displayName,
    String? imageUrl,
  }) async {
    _presenceUserId = currentUserId;
    if (displayName != null) _presenceDisplayName = displayName;
    if (imageUrl != null) _presenceImageUrl = imageUrl;

    // Keep app-wide online even if Home's ensureAppPresence raced/failed.
    // Await so subscribe attaches after we are on presence:app (viewers get
    // enter/update + can refresh the member snapshot).
    await ensureAppPresence(
      currentUserId: currentUserId,
      displayName: displayName,
      imageUrl: imageUrl,
    );

    await _ensureConnected(clientId: '$currentUserId');
    // Force a fresh token only when the chat isn't attached and the current
    // token doesn't grant it (created/joined after the token was issued).
    // This runs after every send / message load.
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
    // Clear a stale deny if the new token now grants this conversation.
    if (_lastCapability != null &&
        _capabilityAllowsChannel(
          _lastCapability,
          conversationChannelName(conversationId),
        )) {
      _capabilityDeniedConversationIds.remove(conversationId);
    }

    // Downgrade previous active chat (keep inbox listener).
    if (_activeChatConversationId != null &&
        _activeChatConversationId != conversationId) {
      await _downgradeActiveChat(_activeChatConversationId!);
    }

    await _attachChannel(
      conversationId: conversationId,
      enterPresence: true,
      displayName: displayName,
      imageUrl: imageUrl,
      currentUserId: currentUserId,
      isActiveChat: true,
    );
    _startActivePresenceSync();
  }

  /// Inbox listens to many conversations without entering presence on each.
  /// Returns the set of conversation IDs currently subscribed (inbox + active).
  Set<int> get subscribedConversationIds => _bindings.keys.toSet();

  Future<void> subscribeInboxConversations({
    required List<int> conversationIds,
    required int currentUserId,
    String? displayName,
    String? imageUrl,
  }) async {
    if (conversationIds.isEmpty) return;
    _presenceUserId = currentUserId;
    if (displayName != null) _presenceDisplayName = displayName;
    if (imageUrl != null) _presenceImageUrl = imageUrl;

    await _ensureConnected(clientId: '$currentUserId');
    await _authorizeIfNeeded();

    final wanted = conversationIds.toSet();
    final toRemove = _bindings.keys
        .where((id) => !wanted.contains(id) && id != _activeChatConversationId)
        .toList();
    for (final id in toRemove) {
      await _detachChannel(id);
    }

    for (final id in wanted) {
      // The open chat is owned by subscribeToConversation; the heartbeat
      // keeps its presence alive.
      if (id == _activeChatConversationId && _bindings.containsKey(id)) {
        continue;
      }
      // Listen only on inbox — do NOT enter presence. Presence means "in this
      // chat" and the backend treats it as read; entering here falsely shows
      // blue ticks while the peer is still on the Chats list.
      await _attachChannel(
        conversationId: id,
        enterPresence: false,
        isActiveChat: false,
        currentUserId: currentUserId,
        displayName: displayName,
        imageUrl: imageUrl,
        refreshPresenceSnapshot: false,
      );
    }
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
          debugPrint(
            'Ably message.read conversation=$conversationId '
            'user=${data['user_id']} last=${data['last_read_message_id']}',
          );
          _eventsController.add(
            ChatMessageReadEvent(
              conversationId: conversationId,
              userId: _asInt(data['user_id']),
              lastReadMessageId: _asInt(data['last_read_message_id']),
            ),
          );
        case 'message.delivered':
          debugPrint(
            'Ably message.delivered conversation=$conversationId '
            'user=${data['user_id'] ?? data['userId']}',
          );
          _eventsController.add(
            ChatMessageDeliveredEvent(
              conversationId: conversationId,
              userId: _asInt(
                data['user_id'] ?? data['userId'] ?? data['reader_id'],
              ),
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

  Future<void> _downgradeActiveChat(int conversationId) async {
    final binding = _bindings[conversationId];
    if (binding == null) {
      if (_activeChatConversationId == conversationId) {
        _activeChatConversationId = null;
      }
      _stopActivePresenceSync();
      return;
    }
    // Leaving the chat room must leave presence so new messages stay
    // delivered (not seen) until the peer opens the thread again.
    binding.isActiveChat = false;
    if (_activeChatConversationId == conversationId) {
      _activeChatConversationId = null;
    }
    _stopActivePresenceSync();
    await _leaveConversationPresence(binding, reason: 'downgrade');
    if (binding.presenceSubscription == null) {
      await _startPresenceListening(
        conversationId: conversationId,
        binding: binding,
      );
    } else {
      await _emitCurrentPresenceMembers(
        conversationId: conversationId,
        binding: binding,
      );
    }
  }

  Future<void> _detachChannel(int conversationId) async {
    final binding = _bindings.remove(conversationId);
    if (binding == null) return;
    await binding.presenceSubscription?.cancel();
    await binding.subscription.cancel();
    try {
      await _leaveConversationPresence(binding, reason: 'detach');
      await binding.channel.detach();
    } catch (_) {}
    if (_activeChatConversationId == conversationId) {
      _activeChatConversationId = null;
    }
  }

  /// Leave active chat presence but keep the channel subscribed for inbox.
  /// Safe to call after [clearActiveChat] if [conversationId] is passed.
  Future<void> unsubscribe({int? conversationId}) async {
    final active = conversationId ?? _activeChatConversationId;
    if (active == null) return;
    await _downgradeActiveChat(active);
    final binding = _bindings[active];
    if (binding != null) {
      // Re-broadcast who is still present so the inbox online dot doesn't
      // go stale after popping the chat room.
      await _emitCurrentPresenceMembers(
        conversationId: active,
        binding: binding,
      );
    }
  }

  Future<void> disconnect() async {
    // Signed out — nothing may re-enter presence for this account.
    _presenceUserId = null;
    _stopPresenceWatchdog();
    _cancelPendingAppOfflineChecks();
    _cancelBackgroundLeave();
    _stopActivePresenceSync();
    _stopAppHeartbeat();
    _stopAppPresenceSync();
    await _leaveAppPresence();
    await _connectionStateSubscription?.cancel();
    _connectionStateSubscription = null;
    await _appPresenceSubscription?.cancel();
    _appPresenceSubscription = null;
    await _appMessageSubscription?.cancel();
    _appMessageSubscription = null;
    await _secondaryAppPresenceSubscription?.cancel();
    _secondaryAppPresenceSubscription = null;
    _appPresenceSubscribedChannel = null;
    _secondaryAppPresenceSubscribedChannel = null;
    _appPresenceChannel = null;
    _secondaryAppPresenceChannel = null;
    _appPresenceRealtime = null;
    _enteredAppChannelNames.clear();
    _appPresenceCapabilityDenied = false;
    _deniedAppPresenceChannels.clear();
    _appPresenceChannelName = primaryAppPresenceChannel;
    _ensureAppPresenceFuture = null;
    _presenceRepairBackoff = _minPresenceRepairBackoff;
    _lastPresenceRepairAt = null;
    _pendingResubscribeIds.clear();
    _appOnlineUserIds.clear();
    _appOnlineMembersByUser.clear();
    _appPresenceClientToUserId.clear();
    _lastPresenceSeenAt.clear();
    _heartbeatCapableUserIds.clear();
    final ids = _bindings.keys.toList();
    for (final id in ids) {
      await _detachChannel(id);
    }
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
    _lifecycleLeaveTimer?.cancel();
    _stopAppHeartbeat();
    _stopAppPresenceSync();
    await disconnect();
    await _eventsController.close();
  }
}
