import 'package:json_annotation/json_annotation.dart';

enum PeriodType {
  @JsonValue('DAILY')
  daily('DAILY'),
  @JsonValue('MONTHLY')
  monthly('MONTHLY');

  const PeriodType(this.value);

  final String value;
}
