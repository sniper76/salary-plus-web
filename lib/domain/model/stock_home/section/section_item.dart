import 'package:act_web/domain/model/post/board_group_category.dart';
import 'package:act_web/domain/model/user/user_profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'section_item.freezed.dart';
part 'section_item.g.dart';

@freezed
class SectionItem with _$SectionItem {
  const factory SectionItem({
    required String title,
    required String link,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int viewCount,
    @Default(0) int likeCount,
    @Default(0) int commentCount,
    @Default(false) bool deleted,
    @Default(false) bool reported,
    @Default(false) bool isNew,
    @Default(false) bool isExclusiveToHolders,
    String? thumbnailImageUrl,
    UserProfile? userProfile,
    @JsonKey(name: 'boardCategory') BoardGroupCategory? boardGroupCategory,
  }) = _SectionItem;

  factory SectionItem.fromJson(Map<String, dynamic> json) => _$SectionItemFromJson(json);
}
