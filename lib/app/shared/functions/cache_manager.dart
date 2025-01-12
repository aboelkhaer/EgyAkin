import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheManagerHelper {
  /// Clears all cached images
  static Future<void> clearCache() async {
    try {
      await DefaultCacheManager().emptyCache(); // Clears the default cache
      final cacheDir = await _getCacheDirectory();
      if (cacheDir.existsSync()) {
        cacheDir.deleteSync(recursive: true);
      }
      print("Cache cleared successfully.");
    } catch (error) {
      print("Failed to clear cache: $error");
    }
  }

  /// Gets the current cache size in bytes
  static Future<int> _getCacheSize() async {
    try {
      final cacheDir = await _getCacheDirectory();
      int totalSize = 0;

      if (cacheDir.existsSync()) {
        for (var file in cacheDir.listSync(recursive: true)) {
          if (file is File) {
            totalSize += file.lengthSync();
          }
        }
      }

      return totalSize;
    } catch (error) {
      print("Failed to get cache size: $error");
      return 0;
    }
  }

  Future<void> displayCacheSize() async {
    final cacheSize = await CacheManagerHelper._getCacheSize();
    print('Cache size: ${cacheSize / (1024 * 1024)} MB');
  }

  /// Helper method to get the cache directory
  static Future<Directory> _getCacheDirectory() async {
    final tempDir = await getTemporaryDirectory();
    return Directory('${tempDir.path}/libCachedImageData');
  }
}
