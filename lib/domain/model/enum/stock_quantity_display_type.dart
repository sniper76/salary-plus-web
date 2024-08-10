import 'package:json_annotation/json_annotation.dart';

enum StockQuantityDisplayType {
  @JsonValue('NO')
  no,
  @JsonValue('YES')
  yes,
}

extension StockQuantityDisplayTypeExtension on StockQuantityDisplayType {
  String get value {
    switch (this) {
      case StockQuantityDisplayType.no:
        return 'NO';
      case StockQuantityDisplayType.yes:
        return 'YES';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case StockQuantityDisplayType.no:
        return '미표시';
      case StockQuantityDisplayType.yes:
        return '표시';
      default:
        return '';
    }
  }
}
