import 'package:act_cms/core/extension/number_extension.dart';

class ConvertColumn {
  static String formatNumber(int? number) {
    if (number == null) return '0';
    return number.toNumberFormat;
  }
}
