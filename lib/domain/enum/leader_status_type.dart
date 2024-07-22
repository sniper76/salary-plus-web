import 'package:json_annotation/json_annotation.dart';

enum SolidarityLeaderStatusType {
  @JsonValue('Elected')
  elected,
  @JsonValue('Election in progress')
  progress,
  @JsonValue('UNKNOWN')
  unknown,
}
