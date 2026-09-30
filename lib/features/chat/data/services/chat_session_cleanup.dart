import 'package:egy_akin/features/chat/data/services/chat_archive_prefs.dart';
import 'package:egy_akin/features/chat/data/services/chat_block_service.dart';
import 'package:egy_akin/features/chat/data/services/chat_mute_prefs.dart';
import 'package:egy_akin/features/chat/data/services/chat_push_navigation.dart';
import 'package:egy_akin/features/chat/data/services/chat_realtime_service.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_pending_send_store.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_voice_played_cache.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_cubit.dart';
import 'package:egy_akin/injection_container.dart';
import 'package:flutter/foundation.dart';

/// Clears all chat/inbox state that could leak across accounts on sign-out.
Future<void> clearChatSessionOnSignOut() async {
  try {
    ChatPushNavigation.markHomeShellNotReady();
  } catch (_) {}

  try {
    if (sl.isRegistered<InboxCubit>()) {
      final inbox = sl<InboxCubit>();
      if (!inbox.isClosed) {
        inbox.clearForSignOut(disconnectRealtime: false);
      }
    }
  } catch (e) {
    debugPrint('clearChatSessionOnSignOut inbox failed: $e');
  }

  try {
    if (sl.isRegistered<ChatRealtimeService>()) {
      await sl<ChatRealtimeService>().disconnect();
    }
  } catch (e) {
    debugPrint('clearChatSessionOnSignOut realtime failed: $e');
  }

  try {
    if (sl.isRegistered<ChatBlockService>()) {
      sl<ChatBlockService>().clear();
    }
  } catch (e) {
    debugPrint('clearChatSessionOnSignOut block list failed: $e');
  }

  await Future.wait([
    ChatArchivePrefs.clearAll(),
    ChatMutePrefs.clearAll(),
    ChatPendingSendStore.instance.clearAll(),
    ChatVoicePlayedCache.clearAll(),
  ]);
}
