import 'package:json_annotation/json_annotation.dart';

enum ReportStatusType {
  @JsonValue('All')
  all,
  @JsonValue('READY')
  ready,
  @JsonValue('PROCESSING')
  processing,
  @JsonValue('COMPLETE')
  complete,
  @JsonValue('REJECT')
  reject,
  @JsonValue('UNKNOWN')
  unknown,
}

extension ReportStatusTypeExtension on ReportStatusType {
  String get value {
    switch (this) {
      case ReportStatusType.all:
        return 'ALL';
      case ReportStatusType.ready:
        return 'READY';
      case ReportStatusType.processing:
        return 'PROCESSING';
      case ReportStatusType.complete:
        return 'COMPLETE';
      case ReportStatusType.reject:
        return 'REJECT';
      default:
        return 'UNKNOWN';
    }
  }

  String get title {
    switch (this) {
      case ReportStatusType.all:
        return '전체';
      case ReportStatusType.ready:
        return '미처리';
      case ReportStatusType.processing:
        return '처리중';
      case ReportStatusType.complete:
        return '승인(삭제)';
      case ReportStatusType.reject:
        return '반려';
      default:
        return 'UNKNOWN';
    }
  }
}
