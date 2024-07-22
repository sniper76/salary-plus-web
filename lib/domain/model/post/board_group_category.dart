import 'package:act_web/config/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_group_category.freezed.dart';
part 'board_group_category.g.dart';

@freezed
class BoardGroupCategory with _$BoardGroupCategory {
  const BoardGroupCategory._();

  const factory BoardGroupCategory({
    required String name,
    required String displayName,
    @Default(false) bool isGroup,
    @Default(false) bool? isExclusiveToHolders,
    String? badgeColor,
    List<BoardGroupCategory>? subCategories,
  }) = _BoardGroupCategory;

  factory BoardGroupCategory.defaultCategory() =>
      const BoardGroupCategory(name: 'ALL', displayName: '전체', isExclusiveToHolders: false);

  factory BoardGroupCategory.fromJson(Map<String, dynamic> json) => _$BoardGroupCategoryFromJson(json);
}

extension BoardGroupCategoryExtension on BoardGroupCategory {
  bool isSameCategory(BoardGroupCategory category) {
    return name.split(',').join().contains(category.name);
  }

  bool get isHolderListReadAndCopyCategory => name == AppConfig.holderListReadAndCopyName;
}
