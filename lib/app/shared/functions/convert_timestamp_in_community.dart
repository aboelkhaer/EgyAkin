import 'package:intl/intl.dart';

String formatDateTimeForCommunity(String dateTime) {
  if (dateTime.isEmpty || dateTime == 'null') {
    return ''; // Return an empty string or a default message if the input is null or empty
  }

  try {
    // Parse the input date-time string
    DateTime parsedDate = DateTime.parse(dateTime);

    // Format to the desired output
    String formattedDate = DateFormat("MMMM d • h:mm a").format(parsedDate);

    return formattedDate;
  } catch (e) {
    return ''; // Return an empty string or a default message if the input is not a valid date
  }
}
