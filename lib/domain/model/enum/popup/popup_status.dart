import 'package:json_annotation/json_annotation.dart';

enum PopupStatus {
  @JsonValue('READY')
  ready,
  @JsonValue('PROCESSING')
  processing,
  @JsonValue('COMPLETE')
  complete,
  @JsonValue('UNKNOWN')
  unknown,
}

extension PopupTypeExtension on PopupStatus {
  String get value {
    switch (this) {
      case PopupStatus.ready:
        return 'READY';
      case PopupStatus.processing:
        return 'PROCESSING';
      case PopupStatus.complete:
        return 'COMPLETE';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case PopupStatus.ready:
        return '예약중';
      case PopupStatus.processing:
        return '게시중';
      case PopupStatus.complete:
        return '종료';
      default:
        return '';
    }
  }
}
