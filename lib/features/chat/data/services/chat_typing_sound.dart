import 'dart:math' as math;

import 'package:egy_akin/features/chat/data/services/chat_audio_session.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../exports.dart';

/// Real mechanical keyboard clicks (NK Cream samples) while the peer typing
/// indicator is visible — e.g. "Mohamed is typing".
///
/// Samples from the open Mechvibes NK Cream pack.
class ChatTypingSound {
  ChatTypingSound._();

  static const _assets = <String>[
    'assets/sounds/typing_a.wav',
    'assets/sounds/typing_s.wav',
    'assets/sounds/typing_d.wav',
    'assets/sounds/typing_f.wav',
    'assets/sounds/typing_j.wav',
    'assets/sounds/typing_k.wav',
    'assets/sounds/typing_l.wav',
    'assets/sounds/typing_e.wav',
    'assets/sounds/typing_r.wav',
    'assets/sounds/typing_space.wav',
  ];

  static final AudioPlayer _player = AudioPlayer();
  static String? _loadedAsset;
  static Timer? _loop;
  static final math.Random _rng = math.Random();
  static bool _ambientReady = false;

  static Future<void> _ensureAmbient() async {
    if (_ambientReady) return;
    await ChatAudioSession.configureAmbient();
    _ambientReady = true;
  }

  static Future<void> _playVariant() async {
    try {
      await _ensureAmbient();
      final asset = _assets[_rng.nextInt(_assets.length)];
      if (_loadedAsset != asset) {
        await _player.setAsset(asset);
        await _player.setVolume(0.62);
        _loadedAsset = asset;
      }
      await _player.seek(Duration.zero);
      unawaited(_player.play());
    } catch (e) {
      debugPrint('Mech typing click failed: $e');
      _loadedAsset = null;
    }
  }

  /// Start mechanical key-clicks for the duration of peer typing.
  static void startPeerTypingClicks() {
    if (_loop != null) return;
    unawaited(_playVariant());
    _scheduleNext();
  }

  static void _scheduleNext() {
    _loop?.cancel();
    // Natural irregular typing rhythm.
    final delayMs = 85 + _rng.nextInt(140);
    _loop = Timer(Duration(milliseconds: delayMs), () {
      unawaited(_playVariant());
      if (_loop != null) _scheduleNext();
    });
  }

  static void stopPeerTypingClicks() {
    _loop?.cancel();
    _loop = null;
    try {
      unawaited(_player.stop());
    } catch (_) {}
  }
}
