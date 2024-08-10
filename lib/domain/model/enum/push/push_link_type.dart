import 'package:json_annotation/json_annotation.dart';

enum PushLinkType {
  @JsonValue('MAIN_HOME')
  main_home,
  @JsonValue('NEWS_HOME')
  news_home,
  @JsonValue('NOTIFICATION')
  notification,
  @JsonValue('LINK')
  link,
  @JsonValue('DIGITAL_DOCUMENT_HOME')
  digitalDocumentHome,
  @JsonValue('NONE')
  none,
}

extension PushLinkTypeExtension on PushLinkType {
  String get value {
    switch (this) {
      case PushLinkType.main_home:
        return 'MAIN_HOME';
      case PushLinkType.news_home:
        return 'NEWS_HOME';
      case PushLinkType.notification:
        return 'NOTIFICATION';
      case PushLinkType.link:
        return 'LINK';
      case PushLinkType.digitalDocumentHome:
        return 'DIGITAL_DOCUMENT_HOME';
      default:
        return 'NONE';
    }
  }

  String get title {
    switch (this) {
      case PushLinkType.main_home:
        return '메인홈';
      case PushLinkType.news_home:
        return '뉴스홈';
      case PushLinkType.notification:
        return 'NOTIFICATION';
      case PushLinkType.link:
        return '특정페이지';
      case PushLinkType.digitalDocumentHome:
        return '의결권위임';
      default:
        return '없음';
    }
  }
}
