import 'package:intl/intl.dart';

extension DateTimeExtention on DateTime {
  String toFormatString({String pattern = 'yyyy-MM-dd'}) {
    return DateFormat(pattern).format(toLocal());
  }

  int getDurationDays({DateTime? date}) {
    final toDate = date ?? DateTime.now();
    final diff = difference(toDate);
    return diff.inDays;
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
