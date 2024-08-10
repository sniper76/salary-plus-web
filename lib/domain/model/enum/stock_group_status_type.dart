import 'package:json_annotation/json_annotation.dart';

enum StockGroupStatusType {
  @JsonValue('ACTIVE')
  active,
  @JsonValue('PROCESSING')
  processing,
  @JsonValue('INACTIVE_BY_USER')
  inactive_by_user,
  @JsonValue('INACTIVE_BY_ADMIN')
  inactive_by_admin,
  @JsonValue('WITHDRAWAL_REQUESTED')
  withdawal_by_request,
  @JsonValue('DELETED_BY_USER')
  deleted_by_user,
  @JsonValue('DELETED_BY_ADMIN')
  deleted_by_admin,
  @JsonValue('UNKNOWN')
  unknown,
}
