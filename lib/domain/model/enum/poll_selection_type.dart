import 'package:json_annotation/json_annotation.dart';

enum PollSelectionType {
  @JsonValue('SINGLE_ITEM')
  single,
  @JsonValue('MULTIPLE_ITEMS')
  multiple,
  @JsonValue('UNKNOWN')
  unknown,
}

extension PollSelectionTypeExtension on PollSelectionType {
  String get value {
    switch (this) {
      case PollSelectionType.single:
        return 'SINGLE_ITEM';
      case PollSelectionType.multiple:
        return 'MULTIPLE_ITEMS';
      default:
        return '';
    }
  }
}
