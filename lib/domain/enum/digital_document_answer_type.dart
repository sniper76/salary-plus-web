import 'package:json_annotation/json_annotation.dart';

enum DigitalDocumentAnswerType {
  @JsonValue('APPROVAL')
  approval,
  @JsonValue('REJECTION')
  rejection,
  @JsonValue('ABSTENTION')
  abstention,
  @JsonValue('UNKNOWN')
  unknown,
}

extension DigitalDocumentAnswerTypeExtension on DigitalDocumentAnswerType {
  String get title {
    switch (this) {
      case DigitalDocumentAnswerType.approval:
        return '찬성';
      case DigitalDocumentAnswerType.rejection:
        return '반대';
      case DigitalDocumentAnswerType.abstention:
        return '기권';
      default:
        return '';
    }
  }
}
