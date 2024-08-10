import 'package:json_annotation/json_annotation.dart';

enum PopupStockTargetType {
  @JsonValue('ALL')
  all,
  @JsonValue('STOCK')
  stock,
  @JsonValue('STOCK_GROUP')
  stock_group,
  @JsonValue('UNKNOWN')
  unknown,
}

extension PopupStockTargetTypeExtension on PopupStockTargetType {
  String get value {
    switch (this) {
      case PopupStockTargetType.all:
        return 'ALL';
      case PopupStockTargetType.stock:
        return 'STOCK';
      case PopupStockTargetType.stock_group:
        return 'STOCK_GROUP';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case PopupStockTargetType.all:
        return '전체';
      case PopupStockTargetType.stock:
        return '종목명';
      case PopupStockTargetType.stock_group:
        return '그룹명';
      default:
        return '';
    }
  }
}
