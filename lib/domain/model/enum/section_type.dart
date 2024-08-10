import 'package:json_annotation/json_annotation.dart';

enum SectionType {
  @JsonValue('carousel')
  carousel,
  @JsonValue('list')
  list,
  @JsonValue('UNKNOWN')
  unknown,
}
