import 'package:json_annotation/json_annotation.dart';

enum UserStatusType {
  @JsonValue('ACTIVE')
  active,
  @JsonValue('PROCESSING')
  processing,
  @JsonValue('INACTIVE_BY_USER')
  inactive_by_user,
  @JsonValue('INACTIVE_BY_ADMIN')
  inactive_by_admin,
  @JsonValue('DELETED_BY_ADMIN')
  deleted_by_admin,
  @JsonValue('UNKNOWN')
  unknown,
}
