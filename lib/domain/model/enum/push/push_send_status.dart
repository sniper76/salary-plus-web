import 'package:json_annotation/json_annotation.dart';

enum PushSendStatus {
  @JsonValue('READY')
  ready,
  @JsonValue('PROCESSING')
  processing,
  @JsonValue('COMPLETE')
  complete,
  @JsonValue('FAIL')
  fail,
  @JsonValue('UNKNOWN')
  unknown,
}
