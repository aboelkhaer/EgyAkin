import 'dart:io';

import 'package:egy_akin/app/constants/api_end_point.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Shares the login token with the iOS NotificationService extension (App
/// Group), which marks chat messages delivered even when the app is closed.
class NativeSharedAuth {
  NativeSharedAuth._();

  static const _channel = MethodChannel('com.incode.EgyAkin/shared_auth');

  /// Empty / null [token] clears the shared copy (logout).
  static Future<void> save(String? token) async {
    if (kIsWeb || !Platform.isIOS) return;
    final value = token?.trim() ?? '';
    try {
      if (value.isEmpty) {
        await _channel.invokeMethod<void>('clearSharedAuth');
      } else {
        await _channel.invokeMethod<void>('setSharedAuth', {
          'token': value,
          'chatConversationsUrl': ApiEndPoint.chatConversations,
        });
      }
    } catch (e) {
      debugPrint('NativeSharedAuth failed: $e');
    }
  }
}
