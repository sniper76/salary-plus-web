import 'package:json_annotation/json_annotation.dart';

enum PopupDisplayTargetType {
  @JsonValue('MAIN_HOME')
  main_home,
  @JsonValue('NEWS_HOME')
  news_home,
  @JsonValue('STOCK_HOME')
  stock_home,
  @JsonValue('UNKNOWN')
  unknown,
}

extension PopupDisplayTargetTypeExtension on PopupDisplayTargetType {
  String get value {
    switch (this) {
      case PopupDisplayTargetType.main_home:
        return 'main_home';
      case PopupDisplayTargetType.news_home:
        return 'news_home';
      case PopupDisplayTargetType.stock_home:
        return 'stock_home';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case PopupDisplayTargetType.main_home:
        return '메인홈';
      case PopupDisplayTargetType.news_home:
        return '뉴스홈';
      case PopupDisplayTargetType.stock_home:
        return '종목홈';
      default:
        return '';
    }
  }
}
