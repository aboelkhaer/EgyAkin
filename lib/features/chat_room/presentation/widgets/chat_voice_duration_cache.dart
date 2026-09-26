import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

/// Remembers resolved voice durations so reply previews can show `0:04`
/// without re-probing the audio file (WhatsApp-style).
class ChatVoiceDurationCache {
  ChatVoiceDurationCache._();

  static final Map<String, int> _msByKey = {};
  static final ValueNotifier<int> revision = ValueNotifier<int>(0);
  static bool _bumpScheduled = false;

  static String keyFor(ChatAttachmentItem attachment) {
    if (attachment.id != null) return 'id_${attachment.id}';
    final local = attachment.localFile?.path;
    if (local != null && local.isNotEmpty) return 'local_$local';
    final url = attachment.url?.trim() ?? '';
    if (url.isNotEmpty) return 'url_$url';
    return 'unknown';
  }

  /// Never notify listeners mid-build (voice bubbles call [put] from initState).
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

  static void put(ChatAttachmentItem attachment, int durationMs) {
    if (durationMs <= 0) return;
    final key = keyFor(attachment);
    if (_msByKey[key] == durationMs) return;
    _msByKey[key] = durationMs;
    _bumpRevision();
  }

  static int? get(ChatAttachmentItem attachment) {
    final known = attachment.durationMs;
    if (known != null && known > 0) return known;
    return _msByKey[keyFor(attachment)];
  }

  static String format(int durationMs) {
    final totalSec = (durationMs / 1000).round().clamp(0, 24 * 3600);
    final m = totalSec ~/ 60;
    final s = totalSec % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }
}
