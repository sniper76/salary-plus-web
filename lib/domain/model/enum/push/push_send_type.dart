import 'package:json_annotation/json_annotation.dart';

enum PushSendType {
  @JsonValue('SCHEDULE')
  schedule,
  @JsonValue('IMMEDIATELY')
  immediately,
  @JsonValue('UNKNOWN')
  unknown,
}

extension PushSendTypeExtension on PushSendType {
  String get value {
    switch (this) {
      case PushSendType.schedule:
        return 'SCHEDULE';
      case PushSendType.immediately:
        return 'IMMEDIATELY';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case PushSendType.schedule:
        return '예약';
      case PushSendType.immediately:
        return '즉시';
      default:
        return '';
    }
  }
}
