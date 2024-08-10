import 'package:act_cms/domain/model/enum/board_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'board_group_category.g.dart';

@JsonSerializable()
class BoardGroupCategory {
  final String name;
  final String displayName;

  const BoardGroupCategory({
    required this.name,
    required this.displayName,
  });

  factory BoardGroupCategory.defaultCategory() =>
      BoardGroupCategory(displayName: BoardCategoryType.all.title, name: BoardCategoryType.all.value);

  factory BoardGroupCategory.delegate() => BoardGroupCategory(
      displayName: BoardCategoryType.digitalDelegation.title, name: BoardCategoryType.digitalDelegation.value);

  factory BoardGroupCategory.surveys() =>
      BoardGroupCategory(displayName: BoardCategoryType.surveys.title, name: BoardCategoryType.surveys.value);

  factory BoardGroupCategory.coArrangement() => BoardGroupCategory(
      displayName: BoardCategoryType.coHoldingArrangements.title, name: BoardCategoryType.coHoldingArrangements.value);

  factory BoardGroupCategory.event() =>
      BoardGroupCategory(displayName: BoardCategoryType.event.title, name: BoardCategoryType.event.value);

  factory BoardGroupCategory.campaign() =>
      BoardGroupCategory(displayName: BoardCategoryType.campaign.title, name: BoardCategoryType.campaign.value);

  factory BoardGroupCategory.etc() =>
      BoardGroupCategory(displayName: BoardCategoryType.etc.title, name: BoardCategoryType.etc.value);

  factory BoardGroupCategory.notice() =>
      BoardGroupCategory(displayName: BoardCategoryType.notice.title, name: BoardCategoryType.notice.value);

  factory BoardGroupCategory.fromJson(Map<String, dynamic> json) => _$BoardGroupCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$BoardGroupCategoryToJson(this);
}
