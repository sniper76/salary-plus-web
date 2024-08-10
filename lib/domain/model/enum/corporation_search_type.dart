import 'package:json_annotation/json_annotation.dart';

enum CorporationSearchType {
  @JsonValue('CORPORATE_NAME')
  corporationName,
  @JsonValue('UNKNOWN')
  unknown,
}

extension CorporationSearchTypeExtension on CorporationSearchType {
  String get value {
    switch (this) {
      case CorporationSearchType.corporationName:
        return 'CORPORATE_NAME';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case CorporationSearchType.corporationName:
        return '법인명';
      default:
        return '';
    }
  }
}
