import 'package:json_annotation/json_annotation.dart';

enum PushTargetType {
  @JsonValue('ALL')
  all,
  @JsonValue('STOCK')
  stock,
  @JsonValue('STOCK_GROUP')
  stock_group,
  @JsonValue('UNKNOWN')
  unknown,
}

extension PushTargetTypeExtension on PushTargetType {
  String get value {
    switch (this) {
      case PushTargetType.all:
        return 'ALL';
      case PushTargetType.stock:
        return 'STOCK';
      case PushTargetType.stock_group:
        return 'STOCK_GROUP';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case PushTargetType.all:
        return '전체';
      case PushTargetType.stock:
        return '종목명';
      case PushTargetType.stock_group:
        return '그룹명';
      default:
        return '';
    }
  }
}
