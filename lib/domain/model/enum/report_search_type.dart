import 'package:json_annotation/json_annotation.dart';

enum ReportSearchType {
  @JsonValue('STOCK_NAME')
  stockname,
  @JsonValue('PUSH_CONTENT')
  pushcontents,
  @JsonValue('UNKNOWN')
  unknown,
}

extension ReportSearchTypeExtension on ReportSearchType {
  String get value {
    switch (this) {
      case ReportSearchType.stockname:
        return 'STOCK_NAME';
      case ReportSearchType.pushcontents:
        return 'PUSH_CONTENT';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case ReportSearchType.stockname:
        return '종목명';
      case ReportSearchType.pushcontents:
        return '내용';
      default:
        return '';
    }
  }
}
