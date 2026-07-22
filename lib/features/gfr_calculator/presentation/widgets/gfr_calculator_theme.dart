import 'package:egy_akin/exports.dart';

/// Light/dark palette tuned for the GFR calculator screen.
class GfrCalculatorTheme {
  final bool isDarkMode;

  const GfrCalculatorTheme(this.isDarkMode);

  static GfrCalculatorTheme of(BuildContext context) {
    final state = context.read<ThemeBloc>().state;
    final isDark = state is ThemeLoaded && state.isDarkMode;
    return GfrCalculatorTheme(isDark);
  }

  Color get scaffoldBg =>
      isDarkMode ? AppColors.darkScaffoldBG : const Color(0xFFF0F2F8);

  Color get cardBg => isDarkMode ? AppColors.darkCardBG : Colors.white;

  Color get surfaceBg =>
      isDarkMode ? AppColors.darkSurface : const Color(0xFFF5F6FA);

  Color get inputFill =>
      isDarkMode ? AppColors.darkSurface : Colors.white;

  Color get border =>
      isDarkMode ? AppColors.darkBorder : const Color(0xFFE2E6EF);

  Color get borderStrong =>
      isDarkMode ? AppColors.darkBorder : const Color(0xFFD0D7E4);

  Color get title =>
      isDarkMode ? AppColors.darkTitle : AppColors.title;

  Color get subtitle =>
      isDarkMode ? AppColors.darkDescription : const Color(0xFF64748B);

  Color get selectedFill =>
      isDarkMode ? AppColors.primary.withOpacity(0.18) : AppColors.primary.withOpacity(0.1);

  List<Color> get heroGradient => isDarkMode
      ? [
          AppColors.primary.withOpacity(0.35),
          AppColors.darkCardBG,
        ]
      : [
          Colors.white,
          AppColors.primary.withOpacity(0.07),
        ];

  List<BoxShadow>? get cardShadow => isDarkMode
      ? null
      : [
          BoxShadow(
            color: const Color(0xFF6B47E6).withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ];
}
