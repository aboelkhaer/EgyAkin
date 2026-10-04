import 'dart:async';
import 'dart:convert';

import 'package:egy_akin/app/routes/app_routes.dart';
import 'package:egy_akin/app/shared/functions/app_routes_args.dart';
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat/data/services/chat_realtime_service.dart';
import 'package:egy_akin/features/home/presentation/cubit/home_cubit.dart';
import 'package:egy_akin/features/inbox/data/models/inbox_thread.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_cubit.dart';
import 'package:egy_akin/injection_container.dart' as di;
import 'package:egy_akin/main.dart' show navigatorKey;
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Opens the correct chat when the user taps a chat push.
///
/// Backend contract: route by `chat_type` + `context_id`.
/// `conversation_id` is for Ably / "already viewing" — not the nav address.
class ChatPushNavigation {
  ChatPushNavigation._();

  static const _chatMessageType = 'chat_message';
  static const _pendingPrefsKey = 'chat_push_pending_open_v1';
  static const _lastConsumedPrefsKey = 'chat_push_last_consumed_v1';
  /// Ignore stale disk pending left over from a previous session.
  static const _pendingMaxAge = Duration(minutes: 2);
  /// Held until home / session is ready (cold start from killed state).
  static Map<String, dynamic>? _pending;

  /// Opens a queued non-chat payload once the home shell is ready.
  /// Registered by [NotificationServices] (consultation / post / group / …).
  static void Function(Map<String, dynamic> data)? nonChatOpener;

  /// Avoid stacking duplicate navigations from FCM + local notification.
  static String? _navigatingKey;
  static DateTime? _navigatingAt;

  /// Short lock while scheduling a push — must NOT span the whole chat visit
  /// (`await pushNamed` completes only when the route is popped).
  static bool _opening = false;

  /// Set by [HomeScreen] once doctor + home shell are loaded.
  /// Default empty `homeDataModel.data` is always non-null, so we must not
  /// treat "doctor loaded from prefs" alone as ready (that races splash→home).
  static bool _homeShellReady = false;

  /// Foreground push: refresh inbox only — do not navigate.
  static void onForegroundChatPush(Map<String, dynamic> data) {
    final normalized = normalizeData(data);
    if (!_looksLikeChat(normalized)) return;
    _refreshInboxQuietly();
  }

  /// Call when home has finished its first successful load (or on resume while
  /// already loaded). Triggers a pending cold-start open if one is queued.
  static void markHomeShellReady({bool flush = true}) {
    _homeShellReady = true;
    if (flush) flushPending();
  }

  /// Call on sign-out so a later account cannot inherit a ready flag.
  static void markHomeShellNotReady() {
    _homeShellReady = false;
    unawaited(clearPendingOpen());
  }

  /// Drop any queued / persisted cold-start open (sign-out or after consume).
  static Future<void> clearPendingOpen() async {
    _pending = null;
    await _clearPendingDisk();
  }

  /// Queue-only path for killed→tap capture before splash/home exist.
  /// Queues **chat and non-chat** payloads. Never navigates; [flushPending]
  /// opens later (chat via [openFromData], non-chat via [nonChatOpener]).
  static bool queueColdStartData(Map<String, dynamic> data) {
    final normalized = normalizeData(data);
    if (_looksLikeChat(normalized)) {
      final chatType = _resolveChatType(normalized);
      final contextId = _resolveContextId(normalized, chatType);
      if (chatType == null || contextId == null || contextId <= 0) {
        debugPrint(
          'ChatPushNavigation: cold-start queue missing chat_type/context_id '
          'keys=${normalized.keys.toList()}',
        );
        return false;
      }

      final pendingMap = _pendingPayload(
        chatType: chatType,
        contextId: contextId,
        conversationId: _asInt(
          normalized['conversation_id'] ?? normalized['conversationId'],
        ),
        title: _titleOf(normalized),
        senderId: _asInt(normalized['sender_id'] ?? normalized['senderId']),
        focusMessageId: _messageIdOf(normalized),
        peerImageUrl: _imageOf(normalized),
      );
      _pending = pendingMap;
      unawaited(_persistPendingToDisk(pendingMap));
      debugPrint(
        'ChatPushNavigation: cold-start queued '
        'chat_type=$chatType context_id=$contextId',
      );
      if (_homeShellReady) {
        flushPending();
      }
      return true;
    }

    // Non-chat (consultation / post / group / comment / …).
    final type = _resolveNonChatType(normalized);
    if (type.isEmpty) {
      debugPrint(
        'ChatPushNavigation: cold-start non-chat missing type '
        'keys=${normalized.keys.toList()}',
      );
      return false;
    }

    final pendingMap = Map<String, dynamic>.from(normalized);
    pendingMap['_non_chat'] = true;
    pendingMap['_queued_at'] = DateTime.now().millisecondsSinceEpoch;
    _pending = pendingMap;
    unawaited(_persistPendingToDisk(pendingMap));
    debugPrint(
      'ChatPushNavigation: cold-start queued non-chat type=$type',
    );
    if (_homeShellReady) {
      flushPending();
    }
    return true;
  }

  /// Prefer `notification_type` (canonical) over temporary `type` aliases.
  static String _resolveNonChatType(Map<String, dynamic> data) {
    final notificationType =
        (data['notification_type'] ?? '').toString().trim();
    if (notificationType.isNotEmpty) return notificationType;
    return (data['type'] ?? '').toString().trim();
  }

  /// Tap from FCM tray (background / terminated) or local notification.
  /// Returns `true` when this payload was treated as a chat open attempt.
  static bool openFromData(Map<String, dynamic> data) {
    final normalized = normalizeData(data);
    if (!_looksLikeChat(normalized)) return false;

    final chatType = _resolveChatType(normalized);
    final contextId = _resolveContextId(normalized, chatType);
    if (chatType == null || contextId == null || contextId <= 0) {
      debugPrint(
        'ChatPushNavigation: missing chat_type/context_id '
        'keys=${normalized.keys.toList()} values=$normalized',
      );
      // Not handled — let non-chat routing try, or keep pending if we had one.
      return false;
    }

    final pendingMap = _pendingPayload(
      chatType: chatType,
      contextId: contextId,
      conversationId: _asInt(
        normalized['conversation_id'] ?? normalized['conversationId'],
      ),
      title: _titleOf(normalized),
      senderId: _asInt(normalized['sender_id'] ?? normalized['senderId']),
      focusMessageId: _messageIdOf(normalized),
      peerImageUrl: _imageOf(normalized),
    );
    // Stash in memory immediately so resume / home flush can retry.
    _pending = pendingMap;
    unawaited(_persistPendingToDisk(pendingMap));

    if (!_sessionReady() || _isOnSplashRoute()) {
      debugPrint(
        'ChatPushNavigation: queued until home ready '
        'chat_type=$chatType context_id=$contextId '
        'sessionReady=${_sessionReady()} onSplash=${_isOnSplashRoute()}',
      );
      return true;
    }

    unawaited(
      _navigate(
        chatType: chatType,
        contextId: contextId,
        conversationId: _asInt(
          normalized['conversation_id'] ?? normalized['conversationId'],
        ),
        title: _titleOf(normalized),
        senderId: _asInt(normalized['sender_id'] ?? normalized['senderId']),
        focusMessageId: _messageIdOf(normalized),
        peerImageUrl: _imageOf(normalized),
      ),
    );
    return true;
  }

  static void openFromPayloadString(String? payload) {
    if (payload == null || payload.trim().isEmpty) return;
    try {
      final decoded = jsonDecode(payload);
      if (decoded is Map) {
        openFromData(Map<String, dynamic>.from(decoded));
      }
    } catch (e) {
      debugPrint('ChatPushNavigation: bad local payload: $e');
    }
  }

  /// Call from home when doctor/home models are loaded, and on app resume.
  static void flushPending() {
    unawaited(_flushPendingAsync());
  }

  /// Home cold-start: retry a few times while navigator / shell settle.
  static void flushPendingWithRetries() {
    unawaited(_flushPendingWithRetriesAsync());
  }

  static Future<void> _flushPendingWithRetriesAsync() async {
    const delays = <Duration>[
      Duration.zero,
      Duration(milliseconds: 400),
      Duration(milliseconds: 1200),
      Duration(milliseconds: 2500),
      Duration(milliseconds: 4500),
      Duration(seconds: 8),
    ];
    for (final delay in delays) {
      if (delay > Duration.zero) {
        await Future<void>.delayed(delay);
      }
      await _flushPendingAsync();
      if (_pending == null) return;
      if (!_sessionReady() || _isOnSplashRoute()) continue;
      // Still pending after a ready attempt — _navigate may have re-queued.
    }
  }

  static Future<void> _flushPendingAsync() async {
    await _restorePendingFromDisk();
    final pending = _pending;
    if (pending == null) return;

    final isNonChat = pending['_non_chat'] == true || !_looksLikeChat(pending);

    // Non-chat must wait for home — do not clear the queue yet.
    if (isNonChat && (!_sessionReady() || _isOnSplashRoute())) {
      debugPrint(
        'ChatPushNavigation: keep non-chat pending until home ready '
        'sessionReady=${_sessionReady()} onSplash=${_isOnSplashRoute()}',
      );
      return;
    }

    // Claim immediately so a later cold start / flush retry cannot re-open
    // the same notification after we already started handling it.
    _pending = null;
    await _clearPendingDisk();

    if (isNonChat) {
      final opener = nonChatOpener;
      if (opener == null) {
        debugPrint(
          'ChatPushNavigation: non-chat pending but opener not registered',
        );
        return;
      }
      opener(pending);
      return;
    }

    openFromData(pending);
  }

  /// FCM / APNs sometimes nest routing fields; flatten common shapes.
  static Map<String, dynamic> normalizeData(Map<String, dynamic> data) {
    final out = <String, dynamic>{};
    void merge(Map raw) {
      raw.forEach((key, value) {
        final k = key.toString();
        if (value is Map) {
          out[k] = value;
        } else {
          out[k] = value;
        }
      });
    }

    merge(data);

    // Nested `data` map (some gateways wrap the payload).
    final nested = data['data'];
    if (nested is Map) {
      merge(Map<String, dynamic>.from(nested));
    } else if (nested is String && nested.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(nested);
        if (decoded is Map) merge(Map<String, dynamic>.from(decoded));
      } catch (_) {}
    }

    return out;
  }

  static bool _looksLikeChat(Map<String, dynamic> data) {
    final type = (data['type'] ?? '').toString().trim().toLowerCase();
    if (type == _chatMessageType ||
        type == 'chat' ||
        type == 'message' ||
        type == 'new_message') {
      return true;
    }
    // Backend sometimes omits `type` but still sends chat routing fields.
    final chatType = _resolveChatType(data);
    return chatType != null && _resolveContextId(data, chatType) != null;
  }

  static String? _resolveChatType(Map<String, dynamic> data) {
    final raw = (data['chat_type'] ??
            data['chatType'] ??
            data['conversation_type'] ??
            data['conversationType'] ??
            '')
        .toString()
        .trim()
        .toLowerCase();
    final known = ChatApiType.fromApi(raw);
    if (known != null) return known;

    final hasSender = _asInt(
          data['sender_id'] ?? data['senderId'] ?? data['from_user_id'],
        ) !=
        null;
    final type = (data['type'] ?? '').toString().trim().toLowerCase();
    final looksLikeChat = type == _chatMessageType ||
        type == 'chat' ||
        type == 'message' ||
        type == 'new_message';
    if (looksLikeChat && hasSender) return ChatApiType.private;
    return null;
  }

  static int? _resolveContextId(Map<String, dynamic> data, String? chatType) {
    var contextId = _asInt(data['context_id'] ?? data['contextId']);
    if (contextId != null && contextId > 0) return contextId;

    if (chatType == ChatApiType.private) {
      contextId = _asInt(
        data['sender_id'] ??
            data['senderId'] ??
            data['from_user_id'] ??
            data['counterpart_id'] ??
            data['peer_id'],
      );
    } else if (chatType == ChatApiType.group ||
        chatType == ChatApiType.socialGroup ||
        chatType == ChatApiType.caseGroup) {
      contextId = _asInt(
        data['conversation_id'] ??
            data['conversationId'] ??
            data['group_id'] ??
            data['groupId'],
      );
    }
    contextId ??= _asInt(
      data['conversation_id'] ?? data['conversationId'],
    );
    if (contextId != null && contextId > 0) return contextId;
    return null;
  }

  static String _titleOf(Map<String, dynamic> data) {
    final conversationName =
        (data['conversation_name'] ?? data['conversationName'] ?? '')
            .toString()
            .trim();
    if (conversationName.isNotEmpty) return conversationName;
    return (data['sender_name'] ?? data['senderName'] ?? '')
        .toString()
        .trim();
  }

  static String? _messageIdOf(Map<String, dynamic> data) {
    final id = _asInt(
      data['message_id'] ?? data['messageId'] ?? data['focus_message_id'],
    );
    if (id == null || id <= 0) return null;
    return '$id';
  }

  static String? _imageOf(Map<String, dynamic> data) {
    for (final key in const [
      'sender_image',
      'senderImage',
      'peer_image',
      'peerImage',
      'conversation_image',
      'conversationImage',
      'image',
      'avatar',
      'image_url',
      'imageUrl',
    ]) {
      final raw = data[key];
      if (raw == null) continue;
      final s = raw.toString().trim();
      if (s.isNotEmpty) return s;
    }
    return null;
  }

  static InboxThread? _inboxThread({
    required String chatType,
    required int contextId,
    int? conversationId,
  }) {
    try {
      if (!di.sl.isRegistered<InboxCubit>()) return null;
      return di.sl<InboxCubit>().findThread(
            chatType: chatType,
            contextId: contextId,
            conversationId: conversationId,
          );
    } catch (_) {
      return null;
    }
  }

  static String? _peerImageFromInbox({
    required String chatType,
    required int contextId,
    int? conversationId,
  }) {
    final thread = _inboxThread(
      chatType: chatType,
      contextId: contextId,
      conversationId: conversationId,
    );
    final url = thread?.imageUrl?.trim();
    if (url == null || url.isEmpty) return null;
    return url;
  }

  static bool? _peerVerifiedFromInbox({
    required String chatType,
    required int contextId,
    int? conversationId,
  }) {
    final thread = _inboxThread(
      chatType: chatType,
      contextId: contextId,
      conversationId: conversationId,
    );
    if (thread == null) return null;
    return thread.isVerified;
  }

  static bool _sessionReady() {
    try {
      if (!_homeShellReady) return false;
      if (!di.sl.isRegistered<HomeCubit>()) return false;
      final home = di.sl<HomeCubit>();
      final doctorId = home.currentDoctorModel.id;
      if (doctorId == null || doctorId == 0) return false;
      // `homeDataModel.data` defaults to an empty model — do not use it alone.
      final loaded = home.state.maybeWhen(
        loaded: (
          _,
          __,
          ___,
          ____,
          _____,
          ______,
          _______,
          ________,
          _________,
          __________,
        ) =>
            true,
        orElse: () => false,
      );
      return loaded;
    } catch (_) {
      return false;
    }
  }

  /// True while splash is still the top route — pushing chat here is wiped by
  /// splash→home `pushReplacementNamed`.
  static bool _isOnSplashRoute() {
    final nav = navigatorKey.currentState;
    if (nav == null || !nav.mounted) return true;
    Route<dynamic>? top;
    nav.popUntil((route) {
      top = route;
      return true;
    });
    final name = top?.settings.name;
    // Only block on the explicit splash route. Null names (dialogs, etc.)
    // must not prevent background/foreground tap opens.
    return name == AppRoutes.splash || name == '/';
  }

  static Map<String, dynamic> _pendingPayload({
    required String chatType,
    required int contextId,
    int? conversationId,
    required String title,
    int? senderId,
    String? focusMessageId,
    String? peerImageUrl,
  }) {
    return {
      'type': _chatMessageType,
      'chat_type': chatType,
      'context_id': contextId.toString(),
      if (conversationId != null) 'conversation_id': conversationId.toString(),
      'conversation_name': title,
      'sender_name': title,
      if (senderId != null) 'sender_id': senderId.toString(),
      if (focusMessageId != null) 'message_id': focusMessageId,
      if (peerImageUrl != null && peerImageUrl.isNotEmpty)
        'sender_image': peerImageUrl,
      '_queued_at': DateTime.now().millisecondsSinceEpoch,
    };
  }

  static Future<void> _navigate({
    required String chatType,
    required int contextId,
    int? conversationId,
    required String title,
    int? senderId,
    String? focusMessageId,
    String? peerImageUrl,
    bool? peerVerified,
  }) async {
    final dedupeKey = '$chatType:$contextId';
    final now = DateTime.now();
    final pendingMap = _pendingPayload(
      chatType: chatType,
      contextId: contextId,
      conversationId: conversationId,
      title: title,
      senderId: senderId,
      focusMessageId: focusMessageId,
      peerImageUrl: peerImageUrl,
    );

    if (_opening) {
      // Another open is mid-schedule — keep pending for flush/retry.
      await _queuePending(pendingMap);
      return;
    }
    if (_navigatingKey == dedupeKey &&
        _navigatingAt != null &&
        now.difference(_navigatingAt!) < const Duration(seconds: 2)) {
      // Duplicate FCM + local tap for the same chat — ignore.
      return;
    }

    _opening = true;
    _navigatingKey = dedupeKey;
    _navigatingAt = now;

    try {
      // Crash reports: SIGABRT in Impeller/Metal while recreating the surface
      // on notification resume. Wait until resumed + a few frames before
      // pushing the heavy chat route.
      await _waitUntilUiReadyAfterResume();

      if (!_sessionReady() || _isOnSplashRoute()) {
        debugPrint(
          'ChatPushNavigation: not ready after resume wait — keep pending '
          'sessionReady=${_sessionReady()} onSplash=${_isOnSplashRoute()}',
        );
        await _queuePending(pendingMap);
        return;
      }

      final home = di.sl<HomeCubit>();
      final doctor = home.currentDoctorModel;
      final homeData = home.homeDataModel;

      if (conversationId != null &&
          di.sl.isRegistered<ChatRealtimeService>() &&
          di.sl<ChatRealtimeService>().isViewingConversation(conversationId)) {
        debugPrint(
          'ChatPushNavigation: already viewing conversation=$conversationId',
        );
        await _markConsumedAndClear(
          chatType: chatType,
          contextId: contextId,
          queuedAtMs: _asInt(pendingMap['_queued_at']),
        );
        return;
      }

      final displayName = title.isNotEmpty ? title : 'Chat';
      final resolvedImage = peerImageUrl ??
          _peerImageFromInbox(
            chatType: chatType,
            contextId: contextId,
            conversationId: conversationId,
          );
      final resolvedVerified = peerVerified ??
          _peerVerifiedFromInbox(
            chatType: chatType,
            contextId: contextId,
            conversationId: conversationId,
          );
      final nav = await _waitForNavigator();
      if (nav == null || _isOnSplashRoute()) {
        debugPrint('ChatPushNavigation: navigator/splash — keep pending');
        await _queuePending(pendingMap);
        return;
      }

      debugPrint(
        'ChatPushNavigation: open chat_type=$chatType context_id=$contextId '
        'conversation_id=$conversationId focus=$focusMessageId',
      );

      // Do NOT await the route lifetime — pushNamed completes on pop, and
      // holding `_opening` that long drops every later notification tap.
      try {
        final pushed = nav.pushNamed(
          AppRoutes.chatRoom,
          arguments: AppRoutesArgs.chatRoomRouteArgs(
            currentDoctorModel: doctor,
            homeDataModel: homeData,
            peerDisplayName: displayName,
            peerInitials: _initials(displayName),
            peerVerified: resolvedVerified,
            peerImageUrl: resolvedImage,
            chatType: chatType,
            contextId: contextId,
            conversationId: conversationId,
            focusMessageId: focusMessageId,
          ),
        );
        // Always clear memory+disk after the navigator accepts the push so a
        // normal cold start cannot reopen the last notification target.
        await _markConsumedAndClear(
          chatType: chatType,
          contextId: contextId,
          queuedAtMs: _asInt(pendingMap['_queued_at']),
        );
        unawaited(
          pushed.catchError((Object e, StackTrace st) {
            debugPrint('ChatPushNavigation pushNamed failed: $e\n$st');
            unawaited(_queuePending(pendingMap));
            return null;
          }),
        );
      } catch (e, st) {
        debugPrint('ChatPushNavigation pushNamed threw: $e\n$st');
        await _queuePending(pendingMap);
        return;
      }

      // Refresh after the chat route has settled — not during resume GPU work.
      Future<void>.delayed(const Duration(seconds: 1), _refreshInboxQuietly);
    } catch (e, st) {
      debugPrint('ChatPushNavigation failed: $e\n$st');
      await _queuePending(pendingMap);
    } finally {
      _opening = false;
      // If a different chat was queued while we were opening, flush it.
      final leftover = _pending;
      if (leftover != null) {
        final leftType = _resolveChatType(leftover);
        final leftCtx = _resolveContextId(leftover, leftType);
        if (leftType != chatType || leftCtx != contextId) {
          Future<void>.delayed(const Duration(milliseconds: 400), flushPending);
        }
      }
    }
  }

  /// Wait briefly for the navigator after resume / cold start.
  static Future<NavigatorState?> _waitForNavigator() async {
    for (var i = 0; i < 12; i++) {
      final nav = navigatorKey.currentState;
      if (nav != null && nav.mounted) return nav;
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
    final nav = navigatorKey.currentState;
    if (nav != null && nav.mounted) return nav;
    return null;
  }

  static Future<void> _queuePending(Map<String, dynamic> data) async {
    _pending = Map<String, dynamic>.from(data);
    await _persistPendingToDisk(_pending!);
  }

  static Future<void> _persistPendingToDisk(Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final withTs = Map<String, dynamic>.from(data);
      withTs.putIfAbsent(
        '_queued_at',
        () => DateTime.now().millisecondsSinceEpoch,
      );
      await prefs.setString(_pendingPrefsKey, jsonEncode(withTs));
    } catch (e) {
      debugPrint('ChatPushNavigation: persist pending failed: $e');
    }
  }

  static Future<void> _restorePendingFromDisk() async {
    if (_pending != null) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_pendingPrefsKey);
      if (raw == null || raw.isEmpty) return;
      final decoded = jsonDecode(raw);
      if (decoded is! Map) {
        await _clearPendingDisk();
        return;
      }
      final map = Map<String, dynamic>.from(decoded);
      final queuedAtMs = _asInt(map['_queued_at']);
      if (queuedAtMs == null) {
        // Legacy pending from before timestamps — safe to drop so a normal
        // cold start cannot reopen an already-handled notification.
        debugPrint('ChatPushNavigation: dropping legacy pending without ts');
        await _clearPendingDisk();
        return;
      }
      final age = DateTime.now().difference(
        DateTime.fromMillisecondsSinceEpoch(queuedAtMs),
      );
      if (age < Duration.zero || age > _pendingMaxAge) {
        debugPrint(
          'ChatPushNavigation: dropping stale pending age=${age.inSeconds}s',
        );
        await _clearPendingDisk();
        return;
      }

      final chatType = _resolveChatType(map);
      final contextId = _resolveContextId(map, chatType);
      if (chatType != null && contextId != null) {
        final consumed = prefs.getString(_lastConsumedPrefsKey);
        final fingerprint = '$chatType:$contextId';
        if (consumed != null && consumed.startsWith('$fingerprint|')) {
          final consumedAt =
              int.tryParse(consumed.substring(fingerprint.length + 1)) ?? 0;
          // Same pending (or older) was already opened — do not reopen on a
          // normal cold start. A newer tap has a newer `_queued_at`.
          if (queuedAtMs <= consumedAt) {
            debugPrint(
              'ChatPushNavigation: dropping already-consumed pending '
              '$fingerprint',
            );
            await _clearPendingDisk();
            return;
          }
        }
      }

      _pending = map;
    } catch (e) {
      debugPrint('ChatPushNavigation: restore pending failed: $e');
    }
  }

  static Future<void> _markConsumedAndClear({
    required String chatType,
    required int contextId,
    int? queuedAtMs,
  }) async {
    _pending = null;
    try {
      final prefs = await SharedPreferences.getInstance();
      final stamp = queuedAtMs ?? DateTime.now().millisecondsSinceEpoch;
      await prefs.setString(
        _lastConsumedPrefsKey,
        '$chatType:$contextId|$stamp',
      );
      await prefs.remove(_pendingPrefsKey);
    } catch (_) {
      await _clearPendingDisk();
    }
  }

  static Future<void> _clearPendingDisk() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_pendingPrefsKey);
    } catch (_) {}
  }

  /// Avoid pushing routes while Flutter is recreating the Metal surface.
  static Future<void> _waitUntilUiReadyAfterResume() async {
    final binding = WidgetsBinding.instance;

    if (binding.lifecycleState != AppLifecycleState.resumed) {
      final done = Completer<void>();
      late final ProviderLifecycleObserver observer;
      observer = ProviderLifecycleObserver((state) {
        if (state == AppLifecycleState.resumed && !done.isCompleted) {
          binding.removeObserver(observer);
          done.complete();
        }
      });
      binding.addObserver(observer);
      try {
        await done.future.timeout(const Duration(seconds: 4));
      } catch (_) {
        binding.removeObserver(observer);
      }
    }

    // Give SimMetal / surface recreate room before a heavy chat push.
    await Future<void>.delayed(const Duration(milliseconds: 350));
    try {
      await binding.endOfFrame;
      await binding.endOfFrame;
    } catch (_) {}
  }

  static void _refreshInboxQuietly() {
    try {
      if (!di.sl.isRegistered<InboxCubit>()) return;
      di.sl<InboxCubit>().refreshSoon();
    } catch (_) {}
  }

  static String _initials(String name) {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '';
    if (parts.length == 1) {
      final p = parts.first;
      return p.isNotEmpty ? p[0].toUpperCase() : '';
    }
    final a = parts.first[0];
    final b = parts.last[0];
    return '$a$b'.toUpperCase();
  }

  static int? _asInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString().trim());
  }
}

class ProviderLifecycleObserver with WidgetsBindingObserver {
  ProviderLifecycleObserver(this.onState);

  final void Function(AppLifecycleState state) onState;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) => onState(state);
}
