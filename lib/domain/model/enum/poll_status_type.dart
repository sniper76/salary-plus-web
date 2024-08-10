import 'package:json_annotation/json_annotation.dart';

enum PollStatusType {
  @JsonValue('READY')
  ready,
  @JsonValue('IN_PROGRESS')
  in_progress,
  @JsonValue('FINISHED')
  finished,
}
