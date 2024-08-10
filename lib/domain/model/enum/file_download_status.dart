import 'package:json_annotation/json_annotation.dart';

enum FileDownloadStatusType {
  @JsonValue('REQUEST')
  request,
  @JsonValue('IN_PROGRESS')
  processing,
  @JsonValue('COMPLETE')
  complete,
  @JsonValue('UNKNOWN')
  unknown,
}

extension FileDownloadStatusTypeExtension on FileDownloadStatusType {
  String get value {
    switch (this) {
      case FileDownloadStatusType.request:
        return 'REQUEST';
      case FileDownloadStatusType.processing:
        return 'IN_PROGRESS';
      case FileDownloadStatusType.complete:
        return 'COMPLETE';

      default:
        return 'UNKNOWN';
    }
  }

  String get title {
    switch (this) {
      case FileDownloadStatusType.request:
        return '요청';
      case FileDownloadStatusType.processing:
        return '생성중';
      case FileDownloadStatusType.complete:
        return '완료';
      default:
        return 'UNKNOWN';
    }
  }
}
