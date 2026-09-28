import 'dart:convert';

import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/inbox/data/models/inbox_thread.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local cache of archived inbox threads (until / after the API list is available).
class ChatArchivePrefs {
  ChatArchivePrefs._();

  static const _prefsKey = 'chat_archived_threads_v1';

  static final List<InboxThread> _threads = [];
  static Future<void>? _loadFuture;
  static bool _loaded = false;
  static final ValueNotifier<int> revision = ValueNotifier<int>(0);
  static bool _bumpScheduled = false;

  static int get count => _threads.length;

  /// Sum of unread messages across archived chats (one count per conversation).
  static int get unreadTotal {
    final byConversation = <int, int>{};
    var withoutConversationId = 0;
    for (final t in _threads) {
      final convId = t.conversationId;
      if (convId == null) {
        withoutConversationId += t.unreadCount;
        continue;
      }
      final current = byConversation[convId] ?? 0;
      if (t.unreadCount > current) {
        byConversation[convId] = t.unreadCount;
      }
    }
    return byConversation.values.fold<int>(0, (sum, n) => sum + n) +
        withoutConversationId;
  }

  static List<InboxThread> get threads => List.unmodifiable(_threads);

  static Future<void> ensureLoaded() {
    if (_loaded) return Future.value();
    return _loadFuture ??= _load();
  }

  static void _bumpRevision() {
    final phase = SchedulerBinding.instance.schedulerPhase;
    if (phase == SchedulerPhase.idle) {
      revision.value++;
      return;
    }
    if (_bumpScheduled) return;
    _bumpScheduled = true;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _bumpScheduled = false;
      revision.value++;
    });
  }

  static Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getStringList(_prefsKey) ?? const <String>[];
      _threads
        ..clear()
        ..addAll(raw.map(_decode).whereType<InboxThread>());
      _loaded = true;
      _bumpRevision();
    } catch (e) {
      debugPrint('ChatArchivePrefs load failed: $e');
      _loaded = true;
    }
  }

  static Future<void> add(InboxThread thread) async {
    await ensureLoaded();
    _threads.removeWhere((t) => t.id == thread.id);
    _threads.insert(0, thread);
    _bumpRevision();
    await _persist();
  }

  static Future<void> remove(String threadId) async {
    await ensureLoaded();
    final before = _threads.length;
    _threads.removeWhere((t) => t.id == threadId);
    if (_threads.length == before) return;
    _bumpRevision();
    await _persist();
  }

  static Future<void> replaceAll(List<InboxThread> threads) async {
    await ensureLoaded();
    final seen = <String>{};
    final seenConv = <int>{};
    final deduped = <InboxThread>[];
    for (final t in threads) {
      final convId = t.conversationId;
      if (seen.contains(t.id)) continue;
      if (convId != null && seenConv.contains(convId)) continue;
      seen.add(t.id);
      if (convId != null) seenConv.add(convId);
      deduped.add(t);
    }
    _threads
      ..clear()
      ..addAll(deduped);
    _bumpRevision();
    await _persist();
  }

  /// Updates an archived thread when a new message arrives while it's archived.
  /// Always sets absolute [unreadCount] when provided (never double-increments).
  static Future<bool> applyIncomingMessage({
    required int conversationId,
    required String preview,
    required String timeLabel,
    required bool becomesUnread,
    int? absoluteUnreadCount,
    InboxPreviewKind? previewKind,
    int? previewCount,
    ChatMessageStatus? lastMessageStatus,
    bool clearLastMessageStatus = false,
  }) async {
    await ensureLoaded();
    final idx =
        _threads.indexWhere((t) => t.conversationId == conversationId);
    if (idx < 0) return false;
    final previous = _threads[idx];
    final nextUnread = absoluteUnreadCount ??
        (becomesUnread ? previous.unreadCount + 1 : previous.unreadCount);
    _threads[idx] = previous.copyWith(
      preview: preview.isEmpty ? previous.preview : preview,
      timeLabel: timeLabel,
      unreadCount: nextUnread,
      isPriority: nextUnread > 0,
      previewKind: previewKind,
      previewCount: previewCount,
      lastMessageStatus: lastMessageStatus,
      clearLastMessageStatus: clearLastMessageStatus,
    );
    // Keep a single row per conversation id.
    _dedupeInPlace();
    _bumpRevision();
    await _persist();
    return true;
  }

  /// Replace one archived row with the live cubit copy (absolute unread/preview).
  static Future<void> syncThread(InboxThread thread) async {
    await ensureLoaded();
    _threads.removeWhere(
      (t) =>
          t.id == thread.id ||
          (thread.conversationId != null &&
              t.conversationId == thread.conversationId),
    );
    _threads.insert(0, thread);
    _bumpRevision();
    await _persist();
  }

  static void _dedupeInPlace() {
    final seen = <String>{};
    final seenConv = <int>{};
    final next = <InboxThread>[];
    for (final t in _threads) {
      final convId = t.conversationId;
      if (seen.contains(t.id)) continue;
      if (convId != null && seenConv.contains(convId)) continue;
      seen.add(t.id);
      if (convId != null) seenConv.add(convId);
      next.add(t);
    }
    if (next.length != _threads.length) {
      _threads
        ..clear()
        ..addAll(next);
    }
  }

  static Future<void> clearUnreadForConversation(int conversationId) async {
    await ensureLoaded();
    final idx =
        _threads.indexWhere((t) => t.conversationId == conversationId);
    if (idx < 0) return;
    if (_threads[idx].unreadCount == 0) return;
    _threads[idx] = _threads[idx].copyWith(unreadCount: 0, isPriority: false);
    _bumpRevision();
    await _persist();
  }

  /// Wipe archived cache on sign-out so the next account never sees it.
  static Future<void> clearAll() async {
    await ensureLoaded();
    _threads.clear();
    _bumpRevision();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_prefsKey);
    } catch (e) {
      debugPrint('ChatArchivePrefs clearAll failed: $e');
    }
  }

  static Future<void> updateThread(
    String threadId, {
    int? unreadCount,
    bool? isPinned,
    bool? isMuted,
  }) async {
    await ensureLoaded();
    final idx = _threads.indexWhere((t) => t.id == threadId);
    if (idx < 0) return;
    var next = _threads[idx].copyWith(
      unreadCount: unreadCount,
      isPinned: isPinned,
      isMuted: isMuted,
    );
    if (unreadCount != null) {
      next = next.copyWith(isPriority: unreadCount > 0);
    }
    _threads[idx] = next;
    _bumpRevision();
    await _persist();
  }

  static Future<void> _persist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        _prefsKey,
        _threads.map(_encode).toList(growable: false),
      );
    } catch (e) {
      debugPrint('ChatArchivePrefs persist failed: $e');
    }
  }

  static String _encode(InboxThread t) => jsonEncode({
        'id': t.id,
        'title': t.title,
        'subtitle': t.subtitle,
        'preview': t.preview,
        'timeLabel': t.timeLabel,
        'initials': t.initials,
        'kind': t.kind.name,
        'unreadCount': t.unreadCount,
        'isUrgent': t.isUrgent,
        'isVerified': t.isVerified,
        'isPriority': t.isPriority,
        'isAdminBadge': t.isAdminBadge,
        'previewKind': t.previewKind.name,
        'previewCount': t.previewCount,
        'filter': t.filter.name,
        'source': t.source,
        'chatType': t.chatType,
        'contextId': t.contextId,
        'conversationId': t.conversationId,
        'imageUrl': t.imageUrl,
        'counterpartUserId': t.counterpartUserId,
        'isPinned': t.isPinned,
        'isMuted': t.isMuted,
        'lastMessageId': t.lastMessageId,
      });

  static InboxThread? _decode(String raw) {
    try {
      final j = jsonDecode(raw) as Map<String, dynamic>;
      return InboxThread(
        id: j['id'] as String? ?? '',
        title: j['title'] as String? ?? '',
        subtitle: j['subtitle'] as String? ?? '',
        preview: j['preview'] as String? ?? '',
        timeLabel: j['timeLabel'] as String? ?? '',
        initials: j['initials'] as String? ?? '?',
        kind: InboxThreadKind.values.firstWhere(
          (e) => e.name == j['kind'],
          orElse: () => InboxThreadKind.doctor,
        ),
        unreadCount: (j['unreadCount'] as num?)?.toInt() ?? 0,
        isUrgent: j['isUrgent'] as bool? ?? false,
        isVerified: j['isVerified'] as bool? ?? false,
        isPriority: j['isPriority'] as bool? ?? false,
        isAdminBadge: j['isAdminBadge'] as bool? ?? false,
        previewKind: InboxPreviewKind.values.firstWhere(
          (e) => e.name == j['previewKind'],
          orElse: () => InboxPreviewKind.text,
        ),
        previewCount: (j['previewCount'] as num?)?.toInt() ?? 1,
        filter: InboxFilter.values.firstWhere(
          (e) => e.name == j['filter'],
          orElse: () => InboxFilter.all,
        ),
        source: j['source'] as String?,
        chatType: j['chatType'] as String?,
        contextId: (j['contextId'] as num?)?.toInt(),
        conversationId: (j['conversationId'] as num?)?.toInt(),
        imageUrl: j['imageUrl'] as String?,
        counterpartUserId: (j['counterpartUserId'] as num?)?.toInt(),
        isPinned: j['isPinned'] as bool? ?? false,
        isMuted: j['isMuted'] as bool? ?? false,
        lastMessageId: (j['lastMessageId'] as num?)?.toInt(),
      );
    } catch (_) {
      return null;
    }
  }
}
