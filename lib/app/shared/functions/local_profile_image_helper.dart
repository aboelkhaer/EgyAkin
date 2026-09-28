import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:egy_akin/app/constants/local_storage_key.dart';

/// Persists the current doctor's profile photo on disk so avatars open
/// instantly without a network placeholder on every refresh.
///
/// Cache is bound to both [remoteUrl] and [userId] so a previous account's
/// photo is never shown after sign-out / account switch.
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

  static Future<int?> _savedUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.get(AppLocalStrings.localProfileImageUserId);
    if (raw is int) return raw;
    if (raw is String) return int.tryParse(raw);
    return null;
  }

  static Future<void> _setSavedUserId(int? userId) async {
    final prefs = await SharedPreferences.getInstance();
    if (userId == null || userId <= 0) {
      await prefs.remove(AppLocalStrings.localProfileImageUserId);
      return;
    }
    await prefs.setInt(AppLocalStrings.localProfileImageUserId, userId);
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

  static Future<File?> getLocalFile({int? userId}) async {
    final savedUserId = await _savedUserId();
    if (userId != null &&
        userId > 0 &&
        savedUserId != null &&
        savedUserId != userId) {
      return null;
    }

    final savedPath = await _savedPath();
    if (savedPath != null) {
      final file = File(savedPath);
      if (await file.exists() && await file.length() > 0) return file;
    }

    // Legacy fallback for the old fixed filename (no user binding).
    if (userId == null || savedUserId == null) {
      final dir = await _docsDir();
      final legacy = File('${dir.path}/current_doctor_profile.jpg');
      if (await legacy.exists() && await legacy.length() > 0) return legacy;
    }
    return null;
  }

  /// Copies [source] into the app documents folder immediately.
  /// Uses a unique path each time so Flutter's image cache cannot keep
  /// showing a previous photo that shared the same filename.
  static Future<File> saveFromFile(
    File source, {
    String? remoteUrl,
    int? userId,
  }) async {
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
    if (userId != null && userId > 0) {
      await _setSavedUserId(userId);
    }
    await _deletePreviousLocalFiles(keepPath: target.path);
    await _evictFileImage(target);
    revision.value++;
    return target;
  }

  /// Returns a local file for [remoteUrl], downloading once when needed.
  ///
  /// Never returns another account's cached file: local is reused only when
  /// [userId] (if given) and [remoteUrl] both match what was saved.
  static Future<File?> resolve(String? remoteUrl, {int? userId}) async {
    final trimmedRemote = remoteUrl?.trim() ?? '';
    final local = await getLocalFile(userId: userId);
    final savedUrl = await _savedRemoteUrl();
    final savedUserId = await _savedUserId();

    final userMatches = userId == null ||
        userId <= 0 ||
        savedUserId == null ||
        savedUserId == userId;

    // Reuse disk cache only when it belongs to this user AND this URL.
    if (local != null && userMatches) {
      if (trimmedRemote.isEmpty) return local;
      if (savedUrl.isNotEmpty && savedUrl == trimmedRemote) return local;
    }

    if (trimmedRemote.isEmpty) return null;

    try {
      final response = await http.get(Uri.parse(trimmedRemote));
      if (response.statusCode != 200 || response.bodyBytes.isEmpty) {
        // Network failed: only fall back to local when it is still this user.
        return (local != null && userMatches) ? local : null;
      }
      final dir = await _docsDir();
      final target = File(
        '${dir.path}/$_filePrefix${DateTime.now().microsecondsSinceEpoch}.jpg',
      );
      await target.writeAsBytes(response.bodyBytes, flush: true);
      await _setSavedPath(target.path);
      await _setSavedRemoteUrl(trimmedRemote);
      if (userId != null && userId > 0) {
        await _setSavedUserId(userId);
      }
      await _deletePreviousLocalFiles(keepPath: target.path);
      await _evictFileImage(target);
      revision.value++;
      return target;
    } catch (_) {
      return (local != null && userMatches) ? local : null;
    }
  }

  /// Downloads and stores the image if a local copy is missing / outdated.
  static Future<void> ensureCached(String? remoteUrl, {int? userId}) async {
    await resolve(remoteUrl, userId: userId);
  }

  static Future<void> bindRemoteUrl(String remoteUrl, {int? userId}) async {
    if (remoteUrl.isEmpty) return;
    await _setSavedRemoteUrl(remoteUrl);
    if (userId != null && userId > 0) {
      await _setSavedUserId(userId);
    }
  }

  static Future<void> clear() async {
    await _deletePreviousLocalFiles();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppLocalStrings.localProfileImageUrl);
    await prefs.remove(AppLocalStrings.localProfileImagePath);
    await prefs.remove(AppLocalStrings.localProfileImageUserId);
    revision.value++;
  }
}
