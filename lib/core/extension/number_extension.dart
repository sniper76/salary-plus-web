import 'package:intl/intl.dart';

extension IntExtension on int {
  String get toNumberFormat => NumberFormat('###,###,###,###').format(this);
}

extension DoubleExtension on double {
  String get toNumberFormat => NumberFormat('###,###,###,###').format(this);
}
