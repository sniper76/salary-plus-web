import 'package:json_annotation/json_annotation.dart';

enum NoticeLevel {
  @JsonValue('INFO')
  info('INFO'),
  @JsonValue('WARNING')
  warning('WARNING'),
  @JsonValue('CRITICAL')
  critical('CRITICAL');

  const NoticeLevel(this.queryValue);

  final String queryValue;
}
