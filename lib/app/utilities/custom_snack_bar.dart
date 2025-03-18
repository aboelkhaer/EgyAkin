import '../../exports.dart';

DateTime? _lastSnackBarTime; // Track the last time a SnackBar was shown

void customSnackBar({required BuildContext context, required String message}) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  if (!scaffoldMessenger.mounted) {
    return; // Return if the ScaffoldMessenger is not mounted
  }

  // Prevent repeated SnackBars within a short time frame
  final now = DateTime.now();
  if (_lastSnackBarTime != null &&
      now.difference(_lastSnackBarTime!) <
          const Duration(seconds: AppStrings.snackBarDelay)) {
    return; // Skip showing the SnackBar if it was shown recently
  }

  _lastSnackBarTime = now; // Update the last shown time

  scaffoldMessenger.hideCurrentSnackBar();

  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: AppStrings.snackBarDelay),
    action: SnackBarAction(
      label: AppStrings.ok,
      onPressed: () {},
    ),
  );

  scaffoldMessenger.showSnackBar(snackBar);
}
