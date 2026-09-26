import 'package:just_audio/just_audio.dart';

/// Ensures only one chat voice note plays at a time (WhatsApp-style).
class ChatVoicePlaybackCoordinator {
  ChatVoicePlaybackCoordinator._();

  static final ChatVoicePlaybackCoordinator instance =
      ChatVoicePlaybackCoordinator._();

  Object? _activeOwner;
  AudioPlayer? _activePlayer;

  /// Call right before [player.play]. Pauses any other active voice note.
  Future<void> claim(Object owner, AudioPlayer player) async {
    if (_activeOwner != null &&
        !identical(_activeOwner, owner) &&
        _activePlayer != null) {
      try {
        await _activePlayer!.pause();
      } catch (_) {}
    }
    _activeOwner = owner;
    _activePlayer = player;
  }

  /// Stop any in-progress voice playback so the mic can open cleanly.
  Future<void> stopActive() async {
    final player = _activePlayer;
    _activeOwner = null;
    _activePlayer = null;
    if (player == null) return;
    try {
      await player.stop();
    } catch (_) {}
  }

  /// Call when this bubble pauses, completes, or is disposed.
  void release(Object owner) {
    if (identical(_activeOwner, owner)) {
      _activeOwner = null;
      _activePlayer = null;
    }
  }
}
