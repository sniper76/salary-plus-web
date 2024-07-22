import 'package:json_annotation/json_annotation.dart';

enum DigitalDocumentAnswerStatusType {
  @JsonValue('SAVE')
  save,
  @JsonValue('COMPLETE')
  complete,
  @JsonValue('UNKNOWN')
  unknown,
}

extension DigitalDocumentAnswerStatusTypeExtension on DigitalDocumentAnswerStatusType {
  bool get isCompleted => this == DigitalDocumentAnswerStatusType.complete;
}
