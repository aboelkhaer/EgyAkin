import '../../../exports.dart';

/// Controls the in-app "What's New" dialog shown on Home.
///
/// Bump [currentVersion] whenever [AppStrings.updateDialogContent] changes
/// so users who dismissed an older message see the new one.
class AppUpdateMessageUtils {
  AppUpdateMessageUtils._();

  static const int currentVersion = 9;

  static Future<bool> shouldShow(AppPreferences prefs) async {
    final dismissedVersion =
        (await prefs.getInt(AppLocalStrings.dismissedUpdateMessageVersion)) ??
            0;
    return dismissedVersion < currentVersion;
  }

  static Future<void> markDismissed(AppPreferences prefs) async {
    await prefs.setInt(
      AppLocalStrings.dismissedUpdateMessageVersion,
      currentVersion,
    );
  }

  static Future<void> clearDismissedFlag(AppPreferences prefs) async {
    await prefs.removeData(AppLocalStrings.dismissedUpdateMessageVersion);
  }
}
