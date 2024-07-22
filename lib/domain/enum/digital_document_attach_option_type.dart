import 'package:json_annotation/json_annotation.dart';

enum DigitalDocumentAttachOptionType {
  @JsonValue('REQUIRED')
  required,
  @JsonValue('OPTIONAL')
  optional,
  @JsonValue('NONE')
  none
}
