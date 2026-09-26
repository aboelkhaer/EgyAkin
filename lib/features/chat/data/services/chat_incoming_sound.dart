import 'dart:async';

import 'package:egy_akin/features/chat/data/services/chat_audio_session.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../exports.dart';

/// Short in-app tone + soft haptic when a message is received (not sent by us).
class ChatIncomingSound {
  ChatIncomingSound._();

  static final AudioPlayer _player = AudioPlayer();
  static Future<void>? _load;

  static Future<void> _ensureLoaded() {
    return _load ??= () async {
      await ChatAudioSession.configureAmbient();
      await _player.setAsset('assets/sounds/message_received.wav');
      await _player.setVolume(0.75);
    }();
  }

  static Future<void> play() async {
    // Soft WhatsApp-style tap — fire with the tone, don't wait for audio.
    unawaited(_softHaptic());
    try {
      await _ensureLoaded();
      await _player.seek(Duration.zero);
      await _player.play();
    } catch (e) {
      debugPrint('Chat incoming sound failed: $e');
      _load = null;
    }
  }

  static Future<void> _softHaptic() async {
    try {
      await HapticFeedback.lightImpact();
      // Tiny second pulse so it feels like a notification bump, not a hard tap.
      await Future<void>.delayed(const Duration(milliseconds: 55));
      await HapticFeedback.selectionClick();
    } catch (_) {}
  }
}
