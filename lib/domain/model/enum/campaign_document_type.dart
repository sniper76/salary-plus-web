import 'package:json_annotation/json_annotation.dart';

enum CampaignDocumentType {
  @JsonValue('POOL')
  pool,
  @JsonValue('DIGITALDOCUMENT')
  digitalDocument,
  @JsonValue('UNKNOWN')
  unknown,
}

extension CampaignDocumentTypeExtension on CampaignDocumentType {
  String get value {
    switch (this) {
      case CampaignDocumentType.pool:
        return 'POOL';
      case CampaignDocumentType.digitalDocument:
        return 'DIGITALDOCUMENT';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case CampaignDocumentType.pool:
        return '설문';
      case CampaignDocumentType.digitalDocument:
        return '10초서명';
      default:
        return '';
    }
  }
}
