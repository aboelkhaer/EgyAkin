import '../../exports.dart';

class Themes {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.scaffoldBG,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.subBG,
          surface: AppColors.white,
          onPrimary: AppColors.white,
          onSecondary: AppColors.title,
          onSurface: AppColors.title,
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: AppColors.white,
          ),
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColors.primary,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primary,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary.withOpacity(0.8),
        ),
        cardTheme: CardTheme(
          color: AppColors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        listTileTheme: const ListTileThemeData(
          textColor: AppColors.title,
          iconColor: AppColors.description,
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.description,
          thickness: 0.5,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: AppColors.description.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: AppColors.description.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkScaffoldBG,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.darkPrimary,
          secondary: AppColors.darkSubBG,
          surface: AppColors.darkCardBG,
          onPrimary: AppColors.white,
          onSecondary: AppColors.darkTitle,
          onSurface: AppColors.darkTitle,
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: AppColors.white,
          ),
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColors.darkCardBG,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.darkPrimary,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.darkPrimary.withOpacity(0.8),
        ),
        cardTheme: CardTheme(
          color: AppColors.darkCardBG,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        listTileTheme: const ListTileThemeData(
          textColor: AppColors.darkTitle,
          iconColor: AppColors.darkDescription,
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.darkBorder,
          thickness: 0.5,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkCardBG,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.darkBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.darkBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.darkPrimary),
          ),
        ),
      );
}
