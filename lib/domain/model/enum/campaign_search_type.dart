import 'package:json_annotation/json_annotation.dart';

enum CampaignSearchType {
  @JsonValue('STOCK_GROUP_NAME')
  stockGroupName,
  @JsonValue('TITLE')
  title,
  @JsonValue('UNKNOWN')
  unknown,
}

extension CampaignSearchTypeExtension on CampaignSearchType {
  String get value {
    switch (this) {
      case CampaignSearchType.stockGroupName:
        return 'STOCK_GROUP_NAME';
      case CampaignSearchType.title:
        return 'TITLE';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case CampaignSearchType.stockGroupName:
        return '그룹명';
      case CampaignSearchType.title:
        return '제목';
      default:
        return '';
    }
  }
}
