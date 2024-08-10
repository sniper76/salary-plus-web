import 'package:json_annotation/json_annotation.dart';

enum LeaderStatusType {
  @JsonValue('Elected')
  elected,
  @JsonValue('Election in progress')
  progress,
  @JsonValue('UNKNOWN')
  unknown,
}
