import 'package:json_annotation/json_annotation.dart';

enum IdCardWatermarkType {
  @JsonValue('ACT_LOGO')
  actLogo,
  @JsonValue('ACT_LOGO_WITH_DATE')
  actLogoWithDate,
  @JsonValue('NONE')
  none,
}

extension IdCardWatermarkTypeExtension on IdCardWatermarkType {
  String get value {
    switch (this) {
      case IdCardWatermarkType.actLogo:
        return 'ACT_LOGO';
      case IdCardWatermarkType.actLogoWithDate:
        return 'ACT_LOGO_WITH_DATE';
      case IdCardWatermarkType.none:
        return 'NONE';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case IdCardWatermarkType.actLogo:
        return '로고';
      case IdCardWatermarkType.actLogoWithDate:
        return '로고+일시';
      case IdCardWatermarkType.none:
        return '없음';
      default:
        return '';
    }
  }
}
