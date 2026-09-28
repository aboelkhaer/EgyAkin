import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local mute flags keyed by conversation / chat identity until a mute API exists.
class ChatMutePrefs {
  ChatMutePrefs._();

  static const _prefsKey = 'chat_muted_keys_v1';

  static final Set<String> _muted = {};
  static Future<void>? _loadFuture;
  static bool _loaded = false;
  static final ValueNotifier<int> revision = ValueNotifier<int>(0);
  static bool _bumpScheduled = false;

  static String keyFor({
    int? conversationId,
    String? chatType,
    int? contextId,
  }) {
    if (conversationId != null && conversationId > 0) {
      return 'c:$conversationId';
    }
    if (chatType != null && contextId != null) {
      return '${ChatApiType.fromApi(chatType) ?? chatType}:$contextId';
    }
    return '';
  }

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
      final stored = prefs.getStringList(_prefsKey) ?? const <String>[];
      _muted
        ..clear()
        ..addAll(stored);
      _loaded = true;
      _bumpRevision();
    } catch (e) {
      debugPrint('ChatMutePrefs load failed: $e');
      _loaded = true;
    }
  }

  static bool isMuted(String key) {
    if (key.isEmpty) return false;
    return _muted.contains(key);
  }

  static Future<void> setMuted(String key, bool muted) async {
    if (key.isEmpty) return;
    await ensureLoaded();
    if (muted) {
      _muted.add(key);
    } else {
      _muted.remove(key);
    }
    _bumpRevision();
    await _persist();
  }

  /// Wipe mute flags on sign-out.
  static Future<void> clearAll() async {
    await ensureLoaded();
    _muted.clear();
    _bumpRevision();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_prefsKey);
    } catch (e) {
      debugPrint('ChatMutePrefs clearAll failed: $e');
    }
  }

  static Future<void> _persist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_prefsKey, _muted.toList(growable: false));
    } catch (e) {
      debugPrint('ChatMutePrefs persist failed: $e');
    }
  }
}
