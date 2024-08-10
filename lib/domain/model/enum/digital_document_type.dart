import 'package:act_cms/domain/model/enum/action_post_type.dart';
import 'package:act_cms/domain/model/enum/digital_document_version.dart';
import 'package:json_annotation/json_annotation.dart';

enum DigitalDocumentType {
  @JsonValue('DIGITAL_PROXY')
  digitalProxy,
  @JsonValue('DIGITAL_PROXY_2')
  newDigitalProxy,
  @JsonValue('JOINT_OWNERSHIP_DOCUMENT')
  jointOwnership,
  @JsonValue('ETC_DOCUMENT')
  etc,
  @JsonValue('UNKNOWN')
  unknown;

  static Iterable<DigitalDocumentType> getDigitalDocumentType(ActionPostType type) {
    return type == ActionPostType.action
        ? DigitalDocumentType.values.where((element) => element != DigitalDocumentType.unknown)
        : [DigitalDocumentType.etc];
  }
}

extension DigitalDocumentTypeExtension on DigitalDocumentType {
  String get value {
    switch (this) {
      case DigitalDocumentType.digitalProxy:
        return 'DIGITAL_PROXY';
      case DigitalDocumentType.newDigitalProxy:
        return 'DIGITAL_PROXY_2';
      case DigitalDocumentType.jointOwnership:
        return 'JOINT_OWNERSHIP_DOCUMENT';
      case DigitalDocumentType.etc:
        return 'ETC_DOCUMENT';
      default:
        return 'UNKNOWN';
    }
  }

  String get title {
    switch (this) {
      case DigitalDocumentType.digitalProxy:
        return '의결권위임_V1';
      case DigitalDocumentType.newDigitalProxy:
        return '의결권위임_V2';
      case DigitalDocumentType.jointOwnership:
        return '공동보유';
      case DigitalDocumentType.etc:
        return '10초 서명';
      default:
        return '';
    }
  }

  String get version {
    switch (this) {
      case DigitalDocumentType.newDigitalProxy:
        return DigitalDocumentVersion.v2.value;
      default:
        return DigitalDocumentVersion.v1.value;
    }
  }
}
