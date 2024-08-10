import 'package:json_annotation/json_annotation.dart';

enum PopupLinkType {
  @JsonValue('MAIN_HOME')
  main_home,
  @JsonValue('NEWS_HOME')
  news_home,
  @JsonValue('STOCK_HOME')
  stock_home,
  @JsonValue('NOTIFICATION')
  notification,
  @JsonValue('LINK')
  link,
  @JsonValue('DIGITAL_DOCUMENT_HOME')
  digitalDocumentHome,
  @JsonValue('NONE')
  none,
}

extension PopupLinkTypeExtension on PopupLinkType {
  String get value {
    switch (this) {
      case PopupLinkType.main_home:
        return 'MAIN_HOME';
      case PopupLinkType.news_home:
        return 'NEWS_HOME';
      case PopupLinkType.stock_home:
        return 'STOCK_HOME';
      case PopupLinkType.notification:
        return 'NOTIFICATION';
      case PopupLinkType.link:
        return 'LINK';
      case PopupLinkType.digitalDocumentHome:
        return 'DIGITAL_DOCUMENT_HOME';
      default:
        return 'NONE';
    }
  }

  String get title {
    switch (this) {
      case PopupLinkType.main_home:
        return '메인홈';
      case PopupLinkType.news_home:
        return '뉴스홈';
      case PopupLinkType.stock_home:
        return '종목홈';
      case PopupLinkType.notification:
        return 'NOTIFICATION';
      case PopupLinkType.link:
        return '특정페이지';
      case PopupLinkType.digitalDocumentHome:
        return '의결권위임';
      default:
        return '없음';
    }
  }
}
