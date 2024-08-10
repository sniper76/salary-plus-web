import 'package:act_cms/domain/model/enum/action_post_type.dart';
import 'package:json_annotation/json_annotation.dart';

enum ActionDocumentType {
  @JsonValue('POLL')
  poll,
  @JsonValue('DIGITALDOCUMENT')
  digitalDocument,
  @JsonValue('ALLSIGN')
  allsign,
  @JsonValue('UNKNOWN')
  unknown;

  static Iterable<ActionDocumentType> getDocsTypeList(ActionPostType type) {
    return type == ActionPostType.action
        ? ActionDocumentType.values.where((element) => element != ActionDocumentType.unknown)
        : [ActionDocumentType.poll, ActionDocumentType.digitalDocument];
  }
}

extension ActionDocumentTypeExtension on ActionDocumentType {
  String get value {
    switch (this) {
      case ActionDocumentType.poll:
        return 'POLL';
      case ActionDocumentType.digitalDocument:
        return 'DIGITALDOCUMENT';
      case ActionDocumentType.allsign:
        return 'ALLSIGN';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case ActionDocumentType.poll:
        return '설문';
      case ActionDocumentType.digitalDocument:
        return '전자문서';
      case ActionDocumentType.allsign:
        return '모두싸인';
      default:
        return '';
    }
  }
}
