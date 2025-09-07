import 'package:egy_akin/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/localization_bloc.dart';
import '../../utilities/translation_extension.dart';
import '../../constants/app_color.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios,
                size: 15.r,
              ),
            ],
          ),
          onTap: () {
            _showLanguageDialog(context, currentLanguage);
          },
        );
      },
    );
  }

  void _showLanguageDialog(BuildContext context, String currentLanguage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            context.tr('language'),
            style: TextStyle(fontSize: 18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption(
                context,
                'en',
                context.tr('english'),
                currentLanguage == 'en',
              ),
              SizedBox(height: 12),
              _buildLanguageOption(
                context,
                'ar',
                context.tr('arabic'),
                currentLanguage == 'ar',
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
  ) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        context.read<LocalizationBloc>().add(ChangeLanguage(languageCode));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
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
                color: isSelected ? AppColors.primary : Colors.black87,
              ),
            ),
            Spacer(),
            if (isSelected)
              Icon(
                Icons.check,
                color: AppColors.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
} 