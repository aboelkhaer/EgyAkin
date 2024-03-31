import '../../exports.dart';

class Themes {
  final lightTheme = ThemeData().copyWith(
    scaffoldBackgroundColor: AppColors.scaffoldBG,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: AppColors.primary,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: AppColors.primary),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary.withOpacity(0.8),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.primary,
    ),
  );
}
