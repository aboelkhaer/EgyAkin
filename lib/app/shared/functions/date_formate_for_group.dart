import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../utilities/translation_extension.dart';

String formatDateForGroup(String isoDate, BuildContext context) {
  try {
    // Parse the ISO 8601 string into a DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Get current locale to determine language
    final locale = context.currentLocale;
    final isArabic = locale?.languageCode == 'ar';

    if (isArabic) {
      // Use Arabic locale for date formatting
      return DateFormat('dd MMM yyyy', 'ar').format(dateTime);
    } else {
      // Use English locale for date formatting
      return DateFormat('dd MMM yyyy', 'en').format(dateTime);
    }
  } catch (e) {
    // Handle invalid date strings gracefully
    print("Error formatting date: $e");
    return "Invalid Date";
  }
}
