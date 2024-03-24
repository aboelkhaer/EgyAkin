import 'package:intl/intl.dart';

String formatDateTime(String? dateTimeString) {
  if (dateTimeString == null) return '...';
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedDate = DateFormat('d/M/yyyy').format(dateTime);
  return formattedDate;
}
