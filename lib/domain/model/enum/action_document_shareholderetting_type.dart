import 'package:json_annotation/json_annotation.dart';

// REGULAR_GENERAL_MEETING_STOCKHOLDERS,
// EXTRAORDINARY_GENERAL_MEETING_STOCKHOLDERS

enum ShareholderMeetingType {
  @JsonValue('REGULAR_GENERAL_MEETING_STOCKHOLDERS')
  regular,
  @JsonValue('EXTRAORDINARY_GENERAL_MEETING_STOCKHOLDERS')
  extraordinary,
}

extension ShareholderMeetingTypeExtension on ShareholderMeetingType {
  String get value {
    switch (this) {
      case ShareholderMeetingType.regular:
        return 'REGULAR_GENERAL_MEETING_STOCKHOLDERS';
      case ShareholderMeetingType.extraordinary:
        return 'EXTRAORDINARY_GENERAL_MEETING_STOCKHOLDERS';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case ShareholderMeetingType.regular:
        return '정기주총';
      case ShareholderMeetingType.extraordinary:
        return '임시주총';
      default:
        return '';
    }
  }
}
