import 'package:json_annotation/json_annotation.dart';

enum PopupSearchType {
  @JsonValue('TITLE')
  popup_title,
}

extension PopupSearchTypeExtension on PopupSearchType {
  String get value {
    switch (this) {
      case PopupSearchType.popup_title:
        return 'TITLE';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case PopupSearchType.popup_title:
        return '제목';
      default:
        return '';
    }
  }
}
