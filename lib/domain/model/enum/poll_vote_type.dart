import 'package:json_annotation/json_annotation.dart';

enum PollVoteType {
  @JsonValue('PERSON_BASED')
  person,
  @JsonValue('SHAREHOLDER_BASED')
  shareholder,
  @JsonValue('UNKNOWN')
  unknown,
}

extension PollVoteTypeExtension on PollVoteType {
  String get value {
    switch (this) {
      case PollVoteType.person:
        return 'PERSON_BASED';
      case PollVoteType.shareholder:
        return 'SHAREHOLDER_BASED';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case PollVoteType.person:
        return '인원수';
      case PollVoteType.shareholder:
        return '주식수';
      default:
        return '';
    }
  }
}
