import 'package:egy_akin/exports.dart';
import '../../services/theme_bloc.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return BlocBuilder<LocalizationBloc, LocalizationState>(
          builder: (context, state) {
            String currentLanguage = 'en';
            if (state is LocalizationLoaded) {
              currentLanguage = state.locale.languageCode;
            }

            return ListTile(
              title: Text(
                context.tr('language'),
                style: TextStyle(fontSize: 13.5.sp),
              ),
              leading: Icon(
                Icons.language,
                color: Colors.grey.shade600,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    currentLanguage == 'en'
                        ? context.tr('english')
                        : context.tr('arabic'),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15.r,
                  ),
                ],
              ),
              onTap: () {
                _showLanguageDialog(context, currentLanguage, isDarkMode);
              },
            );
          },
        );
      },
    );
  }

  void _showLanguageDialog(
      BuildContext context, String currentLanguage, bool isDarkMode) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDarkMode ? AppColors.darkCardBG : Colors.white,
          title: Text(
            context.tr('language'),
            style: TextStyle(
              fontSize: 18,
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
              ),
              const SizedBox(height: 12),
              _buildLanguageOption(
                context,
                'ar',
                context.tr('arabic'),
                currentLanguage == 'ar',
                isDarkMode,
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
  ) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        context.read<LocalizationBloc>().add(ChangeLanguage(languageCode));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDarkMode
                  ? AppColors.darkPrimary.withOpacity(0.1)
                  : AppColors.primary.withOpacity(0.1))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? (isDarkMode ? AppColors.darkPrimary : AppColors.primary)
                : (isDarkMode ? AppColors.darkBorder : Colors.grey.shade300),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              languageName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? (isDarkMode ? AppColors.darkPrimary : AppColors.primary)
                    : (isDarkMode ? AppColors.darkTitle : Colors.black87),
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check,
                color: isDarkMode ? AppColors.darkPrimary : AppColors.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
