import '../../exports.dart';

DateTime? _lastSnackBarTime; // Track the last time a SnackBar was shown

void customSnackBar({required BuildContext context, required String message}) {
  // Prefer the nearest ScaffoldMessenger (e.g. the one wrapping a modal
  // bottom sheet) so the bar paints on top of the sheet at its bottom —
  // not on the root scaffold under the modal barrier.
  final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
  if (scaffoldMessenger == null || !scaffoldMessenger.mounted) {
    return;
  }

  // Prevent repeated SnackBars within a short time frame
  final now = DateTime.now();
  if (_lastSnackBarTime != null &&
      now.difference(_lastSnackBarTime!) <
          const Duration(seconds: AppStrings.snackBarDelay)) {
    return;
  }

  _lastSnackBarTime = now;

  scaffoldMessenger.hideCurrentSnackBar();

  final themeBloc = context.read<ThemeBloc>();
  final themeState = themeBloc.state;
  final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(
        color: isDarkMode ? AppColors.darkTitle : Colors.white,
      ),
    ),
    backgroundColor: isDarkMode ? AppColors.darkCardBG : AppColors.darkCardBG,
    duration: const Duration(seconds: AppStrings.snackBarDelay),
    // Fixed pins flush to the scaffold bottom (above the sheet content).
    behavior: SnackBarBehavior.fixed,
    action: SnackBarAction(
      label: context.tr(AppStrings.ok),
      textColor: isDarkMode ? AppColors.darkPrimary : Colors.white,
      onPressed: () {},
    ),
  );

  scaffoldMessenger.showSnackBar(snackBar);
}
