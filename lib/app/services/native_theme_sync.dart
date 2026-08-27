import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Syncs Flutter theme mode to the native platform so system UI
/// (e.g. Google account picker) matches the app's dark/light mode.
class NativeThemeSync {
  static const _channel = MethodChannel('com.incode.EgyAkin/theme');

  static Future<void> sync(ThemeMode mode) async {
    if (kIsWeb) return;
    if (!(Platform.isAndroid || Platform.isIOS)) return;

    final brightness = switch (mode) {
      ThemeMode.dark => 'dark',
      ThemeMode.light => 'light',
      ThemeMode.system => 'system',
    };

    try {
      await _channel.invokeMethod<void>('setBrightness', brightness);
    } catch (_) {
      // Best-effort; native picker theme is optional.
    }
  }
}
