import 'dart:async';

import 'package:flutter/services.dart';

import '../../../../exports.dart';

/// Lightweight click + haptic for voice record start / send.
///
/// Start feedback must finish *before* the mic opens, otherwise Mac / simulator
/// speaker→mic loopback bakes the click into the voice note.
class ChatVoiceFeedback {
  ChatVoiceFeedback._();

  static Future<void> recordStart() async {
    try {
      await HapticFeedback.lightImpact();
    } catch (_) {}
    await _click();
    // Let the system click finish before the recorder can hear it.
    await Future<void>.delayed(const Duration(milliseconds: 160));
  }

  static Future<void> send() async {
    unawaited(_click());
    try {
      await HapticFeedback.mediumImpact();
    } catch (_) {}
  }

  static Future<void> _click() async {
    try {
      await SystemSound.play(SystemSoundType.click);
    } catch (e) {
      debugPrint('Chat voice feedback sound failed: $e');
    }
  }
}
