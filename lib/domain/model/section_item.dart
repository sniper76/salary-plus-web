import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'section_item.g.dart';

@JsonSerializable()
class SectionItem {
  final String title;
  final String link;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int viewCount;
  final int likeCount;
  final int commentCount;
  final bool deleted;
  final bool reported;
  @JsonKey(name: 'boardCategory')
  final BoardGroupCategory? boardGroupCategory;

  const SectionItem({
    required this.title,
    required this.link,
    required this.createdAt,
    required this.updatedAt,
    this.viewCount = 0,
    this.likeCount = 0,
    this.commentCount = 0,
    this.deleted = false,
    this.reported = false,
    this.boardGroupCategory,
  });

  factory SectionItem.fromJson(Map<String, dynamic> json) => _$SectionItemFromJson(json);

  Map<String, dynamic> toJson() => _$SectionItemToJson(this);
}

extension SectionItemExtension on SectionItem {
  bool get isActive => !deleted && !reported;

  bool get isDeleted => deleted;

  bool get isReported => reported;
}
