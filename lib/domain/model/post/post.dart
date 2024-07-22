import 'package:act_web/config/constants.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/model/document/document.dart';
import 'package:act_web/domain/model/document/holder_list_read_and_copy_digital_document.dart';
import 'package:act_web/domain/model/post/board_group_category.dart';
import 'package:act_web/domain/model/post/post_image.dart';
import 'package:act_web/domain/model/stock/stock.dart';
import 'package:act_web/domain/model/user/user_profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const Post._();

  const factory Post({
    required int id,
    required String title,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? content,
    UserProfile? userProfile,
    @JsonKey(name: 'boardCategory') BoardGroupCategory? boardGroupCategory,
    @JsonKey(name: 'boardGroup', unknownEnumValue: BoardGroupType.unknown) BoardGroupType? boardGroupType,
    Stock? stock,
    int? boardId,
    int? userId,
    @Default(0) int viewCount,
    @Default(0) int commentCount,
    @Default(0) int likeCount,
    @Default(false) bool liked,
    @Default(false) bool deleted,
    @Default(false) bool reported,
    @Default(false) bool isAuthorAdmin,
    @Default(false) bool isExclusiveToHolders,
    @Default(false) bool isNew,
    String? thumbnailImageUrl,
    @JsonKey(name: 'postImageList') List<PostImage>? postImages,
    @Default([]) List<Poll>? polls,
    DigitalProxy? digitalProxy,
    DigitalDocument? digitalDocument,
    HolderListReadAndCopyDigitalDocument? holderListReadAndCopyDigitalDocument,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

extension PostExtension on Post {
  String getDetailRoutePath({
    required String stockCode,
    required BoardGroupType boardGroupType,
    String? popUntilRoute,
  }) {
    return '/stock/$stockCode/board/${boardGroupType.value}/post/$id${popUntilRoute == null ? '' : '?popUntilRoute=$popUntilRoute'}';
  }

  bool get isHolderListReadAndCopyPost =>
      holderListReadAndCopyDigitalDocument != null || boardGroupCategory?.name == AppConfig.holderListReadAndCopyName;

  bool get isActive => deleted == false && reported == false;
}
