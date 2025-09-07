import 'package:flutter/material.dart';
import '../utilities/translation_extension.dart';

class TimeAgoService {
  static final TimeAgoService _instance = TimeAgoService._internal();
  factory TimeAgoService() => _instance;
  TimeAgoService._internal();

  static TimeAgoService get instance => _instance;

  String formatTimeAgo(DateTime dateTime, BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    // Get current locale to determine language
    final locale = context.currentLocale;
    final isArabic = locale?.languageCode == 'ar';

    if (difference.inDays > 0) {
      if (difference.inDays >= 365) {
        final years = (difference.inDays / 365).floor();
        final template = _getTranslation(context, 'time_ago_x_years', isArabic, years);
        return _formatWithPlaceholder(template, years.toString());
      } else if (difference.inDays >= 30) {
        final months = (difference.inDays / 30).floor();
        final template = _getTranslation(context, 'time_ago_x_months', isArabic, months);
        return _formatWithPlaceholder(template, months.toString());
      } else {
        final template = _getTranslation(context, 'time_ago_x_days', isArabic, difference.inDays);
        return _formatWithPlaceholder(template, difference.inDays.toString());
      }
    } else if (difference.inHours > 0) {
      final template = _getTranslation(context, 'time_ago_x_hours', isArabic, difference.inHours);
      return _formatWithPlaceholder(template, difference.inHours.toString());
    } else if (difference.inMinutes > 0) {
      final template = _getTranslation(context, 'time_ago_x_minutes', isArabic, difference.inMinutes);
      return _formatWithPlaceholder(template, difference.inMinutes.toString());
    } else {
      return _getTranslation(context, 'time_ago_just_now', isArabic, 0);
    }
  }

  String _getTranslation(BuildContext context, String key, bool isArabic, int number) {
    // For Arabic pluralization, try to use the plural key first if number > 1
    if (isArabic && number > 1) {
      final pluralKey = '${key}_plural';
      final pluralTranslation = context.tr(pluralKey);
      if (pluralTranslation != pluralKey) {
        return pluralTranslation;
      }
    }
    
    final translation = context.tr(key);
    
    // If translation returns the key itself, use fallback text
    if (translation == key) {
      return _getFallbackText(key, isArabic, number);
    }
    
    return translation;
  }

  String _getFallbackText(String key, bool isArabic, int number) {
    switch (key) {
      case 'time_ago_just_now':
        return isArabic ? 'الآن' : 'just now';
      case 'time_ago_x_minutes':
        return isArabic ? '%d دقيقة' : '%d minutes';
      case 'time_ago_x_hours':
        return isArabic ? '%d ساعة' : '%d hours';
      case 'time_ago_x_days':
        return isArabic ? (number > 1 ? '%d أيام' : '%d يوم') : '%d days';
      case 'time_ago_x_months':
        return isArabic ? (number > 1 ? '%d أشهر' : '%d شهر') : '%d months';
      case 'time_ago_x_years':
        return isArabic ? (number > 1 ? '%d سنوات' : '%d سنة') : '%d years';
      default:
        return isArabic ? '%d' : '%d';
    }
  }

  String _formatWithPlaceholder(String template, String value) {
    return template.replaceAll('%d', value);
  }

  String formatTimeAgoFromString(String dateString, BuildContext context) {
    try {
      final dateTime = DateTime.parse(dateString);
      return formatTimeAgo(dateTime, context);
    } catch (e) {
      // Fallback to original string if parsing fails
      return dateString;
    }
  }
} 