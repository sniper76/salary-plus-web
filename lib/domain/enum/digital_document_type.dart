import 'package:json_annotation/json_annotation.dart';

enum DigitalDocumentType {
  @JsonValue('DIGITAL_PROXY')
  digitalProxy,
  @JsonValue('JOINT_OWNERSHIP_DOCUMENT')
  jointOwnership,
  @JsonValue('ETC_DOCUMENT')
  etc,
  @JsonValue('UNKNOWN')
  unknown,
}

extension DigitalDocumentTypeExtension on DigitalDocumentType {
  String get value {
    switch (this) {
      case DigitalDocumentType.digitalProxy:
        return 'DIGITAL_PROXY';
      case DigitalDocumentType.jointOwnership:
        return 'JOINT_OWNERSHIP_DOCUMENT';
      case DigitalDocumentType.etc:
        return 'ETC_DOCUMENT';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case DigitalDocumentType.digitalProxy:
        return '의결권위임';
      case DigitalDocumentType.jointOwnership:
        return '공동보유';
      case DigitalDocumentType.etc:
        return '10초 서명';
      default:
        return '';
    }
  }
}
