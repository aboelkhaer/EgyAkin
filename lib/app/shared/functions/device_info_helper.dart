import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:uuid/uuid.dart';

class DeviceIdService {
  static Future<String> getPersistentDeviceId() async {
    try {
      // For Android
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        // Use ANDROID_ID (persistent across installs but can change on factory reset)
        return androidInfo.id;
      }
      // For iOS
      else if (Platform.isIOS) {
        final iosInfo = await DeviceInfoPlugin().iosInfo;
        // Use identifierForVendor (persistent for vendor apps)
        return iosInfo.identifierForVendor ?? await _generateFallbackId();
      }
      return await _generateFallbackId();
    } catch (e) {
      return await _generateFallbackId();
    }
  }

  static Future<String> _generateFallbackId() async {
    // Try to get device ID using platform_device_id package
    try {
      final deviceId = await PlatformDeviceId.getDeviceId;
      if (deviceId != null && deviceId.isNotEmpty) {
        return deviceId;
      }
    } catch (e) {
      print('Failed to get platform device ID: $e');
    }

    // Final fallback - store in secure storage
    const storageKey = 'persistent_device_id';
    const storage = FlutterSecureStorage();
    String? storedId = await storage.read(key: storageKey);

    if (storedId == null) {
      storedId = const Uuid().v4();
      await storage.write(key: storageKey, value: storedId);
    }

    return storedId;
  }
}
