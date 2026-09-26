import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

import 'force_update_dialog.dart';

/// Looks up the live App Store / Play Store version for this app.
class StoreVersionLookup {
  StoreVersionLookup._();

  static Future<StoreVersionInfo?> fetch({required bool isAndroid}) async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      if (isAndroid) {
        return _fetchAndroid(packageInfo.packageName);
      }
      return _fetchIos(packageInfo.packageName);
    } catch (e) {
      return null;
    }
  }

  static Future<StoreVersionInfo?> _fetchIos(String bundleId) async {
    final response = await http
        .get(
          Uri.parse('https://itunes.apple.com/lookup?bundleId=$bundleId'),
        )
        .timeout(const Duration(seconds: 8));

    if (response.statusCode != 200) return null;

    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    final resultCount = (jsonData['resultCount'] as num?)?.toInt() ?? 0;
    if (resultCount < 1) return null;

    final results = jsonData['results'] as List<dynamic>?;
    if (results == null || results.isEmpty) return null;

    final result = results.first as Map<String, dynamic>;
    final version = (result['version'] as String?)?.trim();
    if (version == null || version.isEmpty) return null;

    return StoreVersionInfo(
      version: version,
      storeUrl: (result['trackViewUrl'] as String?)?.trim().isNotEmpty == true
          ? result['trackViewUrl'] as String
          : kIosAppStoreUrl,
    );
  }

  static Future<StoreVersionInfo?> _fetchAndroid(String packageId) async {
    final uri = Uri.parse(
      'https://play.google.com/store/apps/details?id=$packageId&hl=en&gl=US',
    );
    final response = await http
        .get(
          uri,
          headers: const {
            'User-Agent':
                'Mozilla/5.0 (Linux; Android 13) AppleWebKit/537.36 '
                    '(KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
            'Accept-Language': 'en-US,en;q=0.9',
          },
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) return null;

    final version = _parsePlayStoreVersion(response.body);
    if (version == null || version.isEmpty) return null;

    return StoreVersionInfo(
      version: version,
      storeUrl: kAndroidPlayStoreUrl,
    );
  }

  static String? _parsePlayStoreVersion(String html) {
    final patterns = <RegExp>[
      RegExp(r'\[\[\["([\d]+(?:\.[\d]+){1,3})"\]\]'),
      RegExp(
        r'Current Version</div><span[^>]*>\s*<span[^>]*>\s*([\d]+(?:\.[\d]+){1,3})\s*<',
        caseSensitive: false,
      ),
      RegExp(
        r'"softwareVersion"\s*:\s*"([\d]+(?:\.[\d]+){1,3})"',
        caseSensitive: false,
      ),
      RegExp(
        r'itemprop="softwareVersion">\s*([\d]+(?:\.[\d]+){1,3})\s*<',
        caseSensitive: false,
      ),
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(html);
      final value = match?.group(1)?.trim();
      if (value != null && value.isNotEmpty) return value;
    }
    return null;
  }
}

class StoreVersionInfo {
  final String version;
  final String storeUrl;

  const StoreVersionInfo({
    required this.version,
    required this.storeUrl,
  });
}
