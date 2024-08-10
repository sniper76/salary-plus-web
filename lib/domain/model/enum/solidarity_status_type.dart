import 'package:json_annotation/json_annotation.dart';

enum SolidarityStatusType {
  @JsonValue('ACTIVE')
  active,
  @JsonValue('INACTIVE_BY_ADMIN')
  inactive_by_admin,
  @JsonValue('UNKNOWN')
  unknown,
}

extension SolidarityStatusTypeExtension on SolidarityStatusType {
  bool get isActive => this == SolidarityStatusType.active;
}
