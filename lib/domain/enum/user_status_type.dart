import 'package:json_annotation/json_annotation.dart';

enum UserStatusType {
  @JsonValue('ACTIVE')
  active,
  @JsonValue('PROCESSING')
  processing,
  @JsonValue('INACTIVE_BY_USER')
  inactiveByUser,
  @JsonValue('INACTIVE_BY_ADMIN')
  inactiveByAdmin,
  @JsonValue('DELETED_BY_ADMIN')
  deletedByAdmin,
  @JsonValue('UNKNOWN')
  unknown,
}
