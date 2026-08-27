import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:egy_akin/app/constants/local_storage_key.dart';

/// Persists the current doctor's profile photo on disk so avatars open
/// instantly without a network placeholder on every refresh.
class LocalProfileImageHelper {
  LocalProfileImageHelper._();

  static const _filePrefix = 'current_doctor_profile_';

  /// Bumped whenever the local avatar file is rewritten so UI can refresh.
  static final ValueNotifier<int> revision = ValueNotifier<int>(0);

  static Future<Directory> _docsDir() async {
    return getApplicationDocumentsDirectory();
  }

  static Future<String?> _savedPath() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString(AppLocalStrings.localProfileImagePath);
    if (path == null || path.isEmpty) return null;
    return path;
  }

  static Future<void> _setSavedPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppLocalStrings.localProfileImagePath, path);
  }

  static Future<String> _savedRemoteUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppLocalStrings.localProfileImageUrl) ?? '';
  }

  static Future<void> _setSavedRemoteUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppLocalStrings.localProfileImageUrl, url);
  }

  static Future<void> _evictFileImage(File file) async {
    try {
      PaintingBinding.instance.imageCache.evict(FileImage(file));
    } catch (_) {}
  }

  static Future<void> _deletePreviousLocalFiles({String? keepPath}) async {
    try {
      final dir = await _docsDir();
      await for (final entity in dir.list()) {
        if (entity is! File) continue;
        final name = entity.uri.pathSegments.isNotEmpty
            ? entity.uri.pathSegments.last
            : entity.path.split(Platform.pathSeparator).last;
        if (!name.startsWith(_filePrefix)) continue;
        if (keepPath != null && entity.path == keepPath) continue;
        await _evictFileImage(entity);
        try {
          await entity.delete();
        } catch (_) {}
      }
    } catch (_) {}
  }

  static Future<File?> getLocalFile() async {
    final savedPath = await _savedPath();
    if (savedPath != null) {
      final file = File(savedPath);
      if (await file.exists() && await file.length() > 0) return file;
    }

    // Legacy fallback for the old fixed filename.
    final dir = await _docsDir();
    final legacy = File('${dir.path}/current_doctor_profile.jpg');
    if (await legacy.exists() && await legacy.length() > 0) return legacy;
    return null;
  }

  /// Copies [source] into the app documents folder immediately.
  /// Uses a unique path each time so Flutter's image cache cannot keep
  /// showing a previous photo that shared the same filename.
  static Future<File> saveFromFile(File source, {String? remoteUrl}) async {
    final dir = await _docsDir();
    final target = File(
      '${dir.path}/$_filePrefix${DateTime.now().microsecondsSinceEpoch}.jpg',
    );
    final bytes = await source.readAsBytes();
    await target.writeAsBytes(bytes, flush: true);
    await _setSavedPath(target.path);
    if (remoteUrl != null && remoteUrl.isNotEmpty) {
      await _setSavedRemoteUrl(remoteUrl);
    }
    await _deletePreviousLocalFiles(keepPath: target.path);
    await _evictFileImage(target);
    revision.value++;
    return target;
  }

  /// Returns a local file for [remoteUrl], downloading once when needed.
  static Future<File?> resolve(String? remoteUrl) async {
    final local = await getLocalFile();
    final savedUrl = await _savedRemoteUrl();

    if (local != null) {
      if (remoteUrl == null ||
          remoteUrl.isEmpty ||
          savedUrl.isEmpty ||
          savedUrl == remoteUrl) {
        return local;
      }
    }

    if (remoteUrl == null || remoteUrl.isEmpty) return local;

    try {
      final response = await http.get(Uri.parse(remoteUrl));
      if (response.statusCode != 200 || response.bodyBytes.isEmpty) {
        return local;
      }
      final dir = await _docsDir();
      final target = File(
        '${dir.path}/$_filePrefix${DateTime.now().microsecondsSinceEpoch}.jpg',
      );
      await target.writeAsBytes(response.bodyBytes, flush: true);
      await _setSavedPath(target.path);
      await _setSavedRemoteUrl(remoteUrl);
      await _deletePreviousLocalFiles(keepPath: target.path);
      await _evictFileImage(target);
      revision.value++;
      return target;
    } catch (_) {
      return local;
    }
  }

  /// Downloads and stores the image if a local copy is missing / outdated.
  static Future<void> ensureCached(String? remoteUrl) async {
    await resolve(remoteUrl);
  }

  static Future<void> bindRemoteUrl(String remoteUrl) async {
    if (remoteUrl.isEmpty) return;
    await _setSavedRemoteUrl(remoteUrl);
  }

  static Future<void> clear() async {
    await _deletePreviousLocalFiles();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppLocalStrings.localProfileImageUrl);
    await prefs.remove(AppLocalStrings.localProfileImagePath);
    revision.value++;
  }
}
