import 'package:intl/intl.dart';

class DatesUtils {
  static DateTime getStartOfToday() {
    return getStartOf(DateTime.now());
  }

  static DateTime getStartOf(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  static DateTime getEndOfToday() {
    return getEndOf(DateTime.now());
  }

  static DateTime getEndOf(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59, 999);
  }

  static DateFormat defaultDateFormat = DateFormat('yyyy-MM-dd');

  static String formatDateString(String dateTimeString, DateFormat? dateFormat) {
    dateFormat ??= defaultDateFormat;

    if (dateTimeString.isEmpty) {
      return "";
    }

    return dateFormat.format(parseDateString(dateTimeString));
  }

  static DateTime parseDateString(String dateTimeString) {
    if (dateTimeString.isEmpty) {
      return DateTime.now();
    }

    var parsedDateTime = DateTime.parse(dateTimeString);
    if (parsedDateTime.isUtc) {
      return parsedDateTime.toLocal();
    }

    return parsedDateTime;
  }
}
