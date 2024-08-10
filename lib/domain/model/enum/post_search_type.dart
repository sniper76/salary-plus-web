import 'package:json_annotation/json_annotation.dart';

enum BoardSearchType {
  @JsonValue('STOCK_CODE')
  stockcode,
  @JsonValue('TITLE')
  title,
  @JsonValue('CONTENT')
  content,
  @JsonValue('TITLE_AND_CONTENT')
  titleAndContent,
  @JsonValue('UNKNOWN')
  unknown,
}

extension BoardSearchTypeExtension on BoardSearchType {
  String get value {
    switch (this) {
      case BoardSearchType.stockcode:
        return 'STOCK_CODE';
      case BoardSearchType.title:
        return 'TITLE';
      case BoardSearchType.content:
        return 'CONTENT';
      case BoardSearchType.titleAndContent:
        return 'TITLE_AND_CONTENT';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case BoardSearchType.stockcode:
        return '종목코드';
      case BoardSearchType.title:
        return '제목';
      case BoardSearchType.content:
        return '내용';
      case BoardSearchType.titleAndContent:
        return '제목+내용';
      default:
        return '';
    }
  }
}
