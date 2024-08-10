import 'package:json_annotation/json_annotation.dart';

enum BoardTargetSearchType {
  @JsonValue('STOCK_NAME')
  stockname,
  @JsonValue('GROUP_NAME')
  groupname,
  @JsonValue('UNKNOWN')
  unknown,
}

extension BoardTargetSearchTypeExtension on BoardTargetSearchType {
  String get value {
    switch (this) {
      case BoardTargetSearchType.stockname:
        return 'STOCK_NAME';
      case BoardTargetSearchType.groupname:
        return 'GROUP_NAME';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case BoardTargetSearchType.stockname:
        return '종목';
      case BoardTargetSearchType.groupname:
        return '그룹';
      default:
        return '';
    }
  }
}
