import 'package:intl/intl.dart';

String formatDateForGroup(String isoDate) {
  try {
    // Parse the ISO 8601 string into a DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Format the DateTime object into the desired format (dd MMM yyyy)
    return DateFormat('dd MMM yyyy').format(dateTime);
  } catch (e) {
    // Handle invalid date strings gracefully
    print("Error formatting date: $e");
    return "Invalid Date";
  }
}
