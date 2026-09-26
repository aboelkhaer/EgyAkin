import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';

/// Chat audio focus helpers.
///
/// Never take exclusive focus just because a chat (or voice bubble) opened —
/// that pauses the user's music. Exclusive / recording categories are only
/// for intentional play or record.
class ChatAudioSession {
  ChatAudioSession._();

  /// Mix with other apps (music keeps playing). Used for metadata prefetch
  /// and short UI tones.
  static Future<void> configureAmbient() async {
    try {
      final session = await AudioSession.instance;
      await session.configure(
        const AudioSessionConfiguration(
          avAudioSessionCategory: AVAudioSessionCategory.ambient,
          avAudioSessionCategoryOptions:
              AVAudioSessionCategoryOptions.mixWithOthers,
          avAudioSessionMode: AVAudioSessionMode.defaultMode,
          androidAudioAttributes: AndroidAudioAttributes(
            contentType: AndroidAudioContentType.sonification,
            usage: AndroidAudioUsage.assistanceSonification,
          ),
          androidAudioFocusGainType:
              AndroidAudioFocusGainType.gainTransientMayDuck,
          androidWillPauseWhenDucked: false,
        ),
      );
    } catch (e) {
      debugPrint('ChatAudioSession ambient failed: $e');
    }
  }

  /// Voice-note playback — duck other audio briefly instead of pausing it.
  static Future<void> prepareVoicePlayback() async {
    try {
      final session = await AudioSession.instance;
      await session.configure(
        AudioSessionConfiguration(
          avAudioSessionCategory: AVAudioSessionCategory.playback,
          avAudioSessionCategoryOptions:
              AVAudioSessionCategoryOptions.duckOthers |
                  AVAudioSessionCategoryOptions.mixWithOthers,
          avAudioSessionMode: AVAudioSessionMode.spokenAudio,
          androidAudioAttributes: const AndroidAudioAttributes(
            contentType: AndroidAudioContentType.speech,
            usage: AndroidAudioUsage.media,
          ),
          androidAudioFocusGainType:
              AndroidAudioFocusGainType.gainTransientMayDuck,
          androidWillPauseWhenDucked: false,
        ),
      );
      await session.setActive(true);
    } catch (e) {
      debugPrint('ChatAudioSession playback failed: $e');
    }
  }

  /// Mic recording — may interrupt other audio (expected while recording).
  static Future<void> prepareRecording() async {
    try {
      final session = await AudioSession.instance;
      await session.configure(
        AudioSessionConfiguration(
          avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
          avAudioSessionCategoryOptions:
              AVAudioSessionCategoryOptions.defaultToSpeaker |
                  AVAudioSessionCategoryOptions.allowBluetooth |
                  AVAudioSessionCategoryOptions.mixWithOthers,
          avAudioSessionMode: AVAudioSessionMode.spokenAudio,
          androidAudioAttributes: const AndroidAudioAttributes(
            contentType: AndroidAudioContentType.speech,
            usage: AndroidAudioUsage.voiceCommunication,
          ),
          androidAudioFocusGainType: AndroidAudioFocusGainType.gainTransient,
          androidWillPauseWhenDucked: true,
        ),
      );
      await session.setActive(true);
    } catch (e) {
      debugPrint('ChatAudioSession recording failed: $e');
    }
  }

  /// Release focus so background music can resume after voice/record.
  static Future<void> release() async {
    try {
      final session = await AudioSession.instance;
      await configureAmbient();
      await session.setActive(
        false,
        avAudioSessionSetActiveOptions:
            AVAudioSessionSetActiveOptions.notifyOthersOnDeactivation,
      );
    } catch (e) {
      debugPrint('ChatAudioSession release failed: $e');
    }
  }
}
