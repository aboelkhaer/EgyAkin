import 'dart:async';

import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_voice_duration_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Tracks which voice notes the current user has already listened to
/// (WhatsApp-style “played” / seen for incoming audio).
/// Persisted so listened state survives app restarts.
class ChatVoicePlayedCache {
  ChatVoicePlayedCache._();

  static const _prefsKey = 'chat_voice_played_keys_v1';

  static final Set<String> _played = {};
  static final ValueNotifier<int> revision = ValueNotifier<int>(0);
  static Future<void>? _loadFuture;
  static bool _loaded = false;
  static bool _bumpScheduled = false;

  static String keyFor(ChatAttachmentItem attachment) =>
      ChatVoiceDurationCache.keyFor(attachment);

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
      _played
        ..clear()
        ..addAll(stored);
      _loaded = true;
      _bumpRevision();
    } catch (e) {
      debugPrint('ChatVoicePlayedCache load failed: $e');
      _loaded = true;
    }
  }

  static bool isPlayed(ChatAttachmentItem attachment) =>
      _played.contains(keyFor(attachment));

  static void markPlayed(ChatAttachmentItem attachment) {
    final key = keyFor(attachment);
    if (key == 'unknown') return;
    unawaited(ensureLoaded().then((_) {
      if (!_played.add(key)) return;
      _bumpRevision();
      unawaited(_persist());
    }));
  }

  static Future<void> clearAll() async {
    await ensureLoaded();
    _played.clear();
    _bumpRevision();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_prefsKey);
    } catch (e) {
      debugPrint('ChatVoicePlayedCache clearAll failed: $e');
    }
  }

  static Future<void> _persist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_prefsKey, _played.toList(growable: false));
    } catch (e) {
      debugPrint('ChatVoicePlayedCache persist failed: $e');
    }
  }
}
