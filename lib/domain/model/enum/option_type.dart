import 'package:json_annotation/json_annotation.dart';

enum OptionType {
  @JsonValue('REQUIRED')
  required,
  @JsonValue('OPTIONAL')
  optional,
  @JsonValue('NONE')
  none,
}

extension OptionTypeExtension on OptionType {
  String get value {
    switch (this) {
      case OptionType.required:
        return 'REQUIRED';
      case OptionType.optional:
        return 'OPTIONAL';
      case OptionType.none:
        return 'NONE';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case OptionType.required:
        return '필수';
      case OptionType.optional:
        return '선택';
      case OptionType.none:
        return '제외';
      default:
        return '';
    }
  }
}
