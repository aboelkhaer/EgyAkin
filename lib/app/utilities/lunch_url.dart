import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../exports.dart';

String? _cachedAndroidAppPackageId;

Future<String> _androidAppPackageIdOrEmpty() async {
  if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return '';
  final cached = _cachedAndroidAppPackageId;
  if (cached != null) return cached;
  final id = (await PackageInfo.fromPlatform()).packageName;
  _cachedAndroidAppPackageId = id;
  return id;
}

Future<bool> _androidDefaultViewHandlerIsOurApp(
  String urlString,
  String ourPackageId,
) async {
  if (ourPackageId.isEmpty) return false;
  try {
    final resolved = await AndroidIntent(
      action: 'android.intent.action.VIEW',
      category: 'android.intent.category.BROWSABLE',
      data: urlString,
      flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
    ).getResolvedActivity();
    return resolved != null && resolved.packageName == ourPackageId;
  } catch (_) {
    return false;
  }
}

Future<bool> _tryAndroidImplicitBrowsableView(String urlString) async {
  if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
    return false;
  }
  try {
    final intent = AndroidIntent(
      action: 'android.intent.action.VIEW',
      category: 'android.intent.category.BROWSABLE',
      data: urlString,
      flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    if (await intent.canResolveActivity() != true) return false;
    await intent.launch();
    return true;
  } catch (_) {
    return false;
  }
}

/// When the app is a verified handler for the whole host, [launchUrl] can
/// "succeed" by routing back to this app. Targeting a browser package avoids that.
Future<bool> _tryAndroidExplicitBrowserView(String urlString) async {
  if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
    return false;
  }
  const packages = [
    'com.android.chrome',
    'com.google.android.apps.chrome',
    'com.sec.android.app.sbrowser',
    'org.mozilla.firefox',
    'com.microsoft.emmx',
  ];
  for (final pkg in packages) {
    try {
      final intent = AndroidIntent(
        action: 'android.intent.action.VIEW',
        category: 'android.intent.category.BROWSABLE',
        data: urlString,
        package: pkg,
        flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
      );
      final can = await intent.canResolveActivity();
      if (can != true) continue;
      await intent.launch();
      return true;
    } catch (_) {
      continue;
    }
  }
  return false;
}

/// When only this app matches VIEW (e.g. old install / App Links), [launchUrl] can
/// open invisibly. A chooser still lists real browsers if any resolve the URL.
Future<bool> _tryAndroidViewChooser(String urlString) async {
  if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
    return false;
  }
  try {
    await AndroidIntent(
      action: 'android.intent.action.VIEW',
      category: 'android.intent.category.BROWSABLE',
      data: urlString,
      flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
    ).launchChooser(AppStrings.openWith);
    return true;
  } catch (_) {
    return false;
  }
}

Future<bool> _tryLaunchUrl(
  Uri uri,
  LaunchMode mode, {
  WebViewConfiguration? webViewConfiguration,
}) async {
  try {
    if (webViewConfiguration != null) {
      return await launchUrl(
        uri,
        mode: mode,
        webViewConfiguration: webViewConfiguration,
      );
    }
    return await launchUrl(uri, mode: mode);
  } catch (_) {
    return false;
  }
}

/// Direct `.pdf` URLs in [LaunchMode.inAppWebView] often show a **black screen**
/// (WebView does not render PDFs). Avoid raw PDF in WebView.
bool _isLikelyPdfUrl(Uri uri) {
  final p = uri.path.toLowerCase();
  return p.endsWith('.pdf') || p.contains('/storage/pdfs/');
}

Uri _googleDocsViewerUri(Uri pdfSource) {
  return Uri.parse(
    'https://docs.google.com/viewer?url='
    '${Uri.encodeComponent(pdfSource.toString())}&embedded=true',
  );
}

/// Opens [url] in a browser / viewer.
///
/// On **Android**, raw PDF in System WebView is blank/black — use Custom Tabs /
/// external app first; WebView only with a Google Docs viewer wrapper for PDFs.
///
/// Set [externalBrowserOnly] to **true** for plain links (e.g. report PDFs) that
/// must open in the **device browser**, not Custom Tabs / in-app WebView / deep link flow.
Future<void> launchURL({
  required String url,
  required Function(String) onError,
  bool externalBrowserOnly = false,
}) async {
  final trimmed = url.trim();
  if (trimmed.isEmpty) {
    onError('Empty url');
    return;
  }
  final uri = Uri.parse(trimmed);
  if (!uri.hasScheme) {
    onError('Invalid url: $trimmed');
    return;
  }

  final isAndroid = !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  final isWebUrl = uri.scheme == 'http' || uri.scheme == 'https';

  try {
    if (externalBrowserOnly && isWebUrl) {
      if (isAndroid) {
        final ourId = await _androidAppPackageIdOrEmpty();

        Future<bool> tryOpenExternal(String urlStr) async {
          final u = Uri.parse(urlStr);
          if (await _tryAndroidExplicitBrowserView(urlStr)) return true;
          if (await _tryAndroidViewChooser(urlStr)) return true;
          if (!await _androidDefaultViewHandlerIsOurApp(urlStr, ourId)) {
            if (await _tryAndroidImplicitBrowsableView(urlStr)) return true;
            if (await _tryLaunchUrl(u, LaunchMode.externalApplication)) {
              return true;
            }
            if (await _tryLaunchUrl(u, LaunchMode.platformDefault)) return true;
          }
          return false;
        }

        if (await tryOpenExternal(trimmed)) return;

        // Same host PDF often resolves to this app as App Link; open via Google viewer on google.com.
        if (_isLikelyPdfUrl(uri)) {
          final viewer = _googleDocsViewerUri(uri).toString();
          if (await tryOpenExternal(viewer)) return;
        }

        onError(
          'Could not open in a browser. On the emulator, install Chrome (Google APIs image) '
          'or pick a browser from "Open with". URL:\n$trimmed',
        );
        return;
      } else {
        if (await _tryLaunchUrl(uri, LaunchMode.externalApplication)) return;
        if (await _tryLaunchUrl(uri, LaunchMode.platformDefault)) return;
      }
      onError('Could not launch $trimmed');
      return;
    }

    if (isAndroid && isWebUrl) {
      final pdf = _isLikelyPdfUrl(uri);

      // 0) Explicit browser — avoids resolving VIEW to MainActivity when App Links
      //    still match, and works when Custom Tabs are unavailable.
      if (await _tryAndroidExplicitBrowserView(trimmed)) {
        return;
      }
      if (await _tryAndroidViewChooser(trimmed)) {
        return;
      }
      // 1–2) Prefer handing off outside the app, then Custom Tabs (PDF-friendly).
      if (await _tryLaunchUrl(uri, LaunchMode.externalApplication)) {
        return;
      }
      if (await _tryLaunchUrl(uri, LaunchMode.inAppBrowserView)) {
        return;
      }
      if (await _tryLaunchUrl(uri, LaunchMode.platformDefault)) {
        return;
      }
      // 3) Last resort: HTML viewer page (not raw PDF in WebView).
      if (pdf) {
        final viewer = _googleDocsViewerUri(uri);
        if (await _tryLaunchUrl(
              viewer,
              LaunchMode.inAppWebView,
              webViewConfiguration: const WebViewConfiguration(
                enableJavaScript: true,
                enableDomStorage: true,
              ),
            )) {
          return;
        }
      } else {
        if (await _tryLaunchUrl(
              uri,
              LaunchMode.inAppWebView,
              webViewConfiguration: const WebViewConfiguration(
                enableJavaScript: true,
                enableDomStorage: true,
              ),
            )) {
          return;
        }
      }
      onError('Could not launch $trimmed');
      return;
    }

    var ok = await _tryLaunchUrl(uri, LaunchMode.externalApplication);
    if (!ok) {
      ok = await _tryLaunchUrl(uri, LaunchMode.platformDefault);
    }
    if (!ok) {
      onError('Could not launch $trimmed');
    }
  } catch (e) {
    onError(e.toString());
  }
}

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
