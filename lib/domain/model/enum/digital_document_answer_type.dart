import 'package:json_annotation/json_annotation.dart';

enum DigitalDocumentAnswerType {
  @JsonValue('APPROVAL')
  approval('APPROVAL', '찬성'),
  @JsonValue('REJECTION')
  rejection('REJECTION', '반대'),
  @JsonValue('ABSTENTION')
  abstention('ABSTENTION', '기권'),
  @JsonValue('UNKNOWN')
  unknown(null, '선택안함');

  const DigitalDocumentAnswerType(this.value, this.title);

  final String? value;
  final String title;
}
