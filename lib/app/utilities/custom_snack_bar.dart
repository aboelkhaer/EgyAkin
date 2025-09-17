import '../../exports.dart';
import '../services/theme_bloc.dart';

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

  // Get theme state from context
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
    action: SnackBarAction(
      label: context.tr(AppStrings.ok),
      textColor: isDarkMode ? AppColors.darkPrimary : Colors.white,
      onPressed: () {},
    ),
  );

  scaffoldMessenger.showSnackBar(snackBar);
}
