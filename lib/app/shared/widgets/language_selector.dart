import 'package:egy_akin/exports.dart';

class LanguageSelector extends StatelessWidget {
  final MoreCubit? moreCubit;

  const LanguageSelector({super.key, this.moreCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final titleColor =
            isDark ? AppColors.darkTitle : const Color(0xFF111827);
        final muted =
            isDark ? AppColors.darkDescription : const Color(0xFF6B7280);

        return BlocBuilder<LocalizationBloc, LocalizationState>(
          builder: (context, state) {
            String currentLanguage = 'en';
            if (state is LocalizationLoaded) {
              currentLanguage = state.locale.languageCode;
            }

            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _showLanguageDialog(
                    context,
                    currentLanguage,
                    isDark,
                    moreCubit,
                  );
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                  child: Row(
                    children: [
                      Container(
                        width: 32.r,
                        height: 32.r,
                        decoration: BoxDecoration(
                          color: const Color(0xFF06B6D4)
                              .withOpacity(isDark ? 0.18 : 0.12),
                          borderRadius: BorderRadius.circular(9.r),
                        ),
                        child: Icon(
                          Icons.language_rounded,
                          size: 15.sp,
                          color: const Color(0xFF06B6D4),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.tr('language'),
                              style: TextStyle(
                                fontSize: 11.5.sp,
                                fontWeight: FontWeight.w700,
                                color: titleColor,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              context.tr(AppStrings.appLanguage),
                              style: TextStyle(
                                fontSize: 9.5.sp,
                                fontWeight: FontWeight.w500,
                                color: muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        currentLanguage == 'en'
                            ? context.tr('english')
                            : context.tr('arabic'),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: muted,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 16.sp,
                        color: muted,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showLanguageDialog(
    BuildContext context,
    String currentLanguage,
    bool isDarkMode,
    MoreCubit? moreCubit,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDarkMode ? AppColors.darkCardBG : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
          ),
          title: Text(
            context.tr('language'),
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? AppColors.darkTitle : Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption(
                context,
                'en',
                context.tr('english'),
                currentLanguage == 'en',
                isDarkMode,
                moreCubit,
              ),
              SizedBox(height: 10.h),
              _buildLanguageOption(
                context,
                'ar',
                context.tr('arabic'),
                currentLanguage == 'ar',
                isDarkMode,
                moreCubit,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String languageCode,
    String languageName,
    bool isSelected,
    bool isDarkMode,
    MoreCubit? moreCubit,
  ) {
    final primary = isDarkMode ? AppColors.darkPrimary : AppColors.primary;

    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        context.read<LocalizationBloc>().add(ChangeLanguage(languageCode));
        if (moreCubit != null) {
          moreCubit.changeLanguage(languageCode);
        }
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
        decoration: BoxDecoration(
          color: isSelected
              ? primary.withOpacity(isDarkMode ? 0.14 : 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? primary
                : (isDarkMode ? AppColors.darkBorder : Colors.grey.shade300),
          ),
        ),
        child: Row(
          children: [
            Text(
              languageName,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? primary
                    : (isDarkMode ? AppColors.darkTitle : Colors.black87),
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(Icons.check_rounded, color: primary, size: 18.sp),
          ],
        ),
      ),
    );
  }
}
