import 'package:json_annotation/json_annotation.dart';

enum StopWordStatus {
  @JsonValue('ACTIVE')
  active('활성화', 'ACTIVE'),
  @JsonValue('INACTIVE')
  inactive('비활성화', 'INACTIVE'),
  @JsonValue('INACTIVE_BY_ADMIN')
  inactiveByAdmin('비활성화', 'INACTIVE_BY_ADMIN');

  const StopWordStatus(this.label, this.value);

  final String label;
  final String value;
}
