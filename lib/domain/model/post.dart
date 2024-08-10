import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/digital_document.dart';
import 'package:act_cms/domain/model/digital_proxy.dart';
import 'package:act_cms/domain/model/enum/board_category.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/post_status_type.dart';
import 'package:act_cms/domain/model/group_push.dart';
import 'package:act_cms/domain/model/holder_list_read_and_copy_digital_document.dart';
import 'package:act_cms/domain/model/poll.dart';
import 'package:act_cms/domain/model/post_image.dart';
import 'package:act_cms/domain/model/push_request.dart';
import 'package:act_cms/domain/model/solidarity_election_result.dart';
import 'package:act_cms/domain/model/stock.dart';
import 'package:act_cms/domain/model/user_profile.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends Equatable {
  final int id;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? content;
  final UserProfile? userProfile;
  @JsonKey(name: 'status', unknownEnumValue: PostStatusType.unknown)
  final PostStatusType status;
  @JsonKey(name: 'boardCategory')
  final BoardGroupCategory? boardGroupCategory;
  @JsonKey(name: 'boardGroup', unknownEnumValue: BoardGroupType.unknown)
  final BoardGroupType? boardGroupType;
  final bool? isNotification;
  final bool isActive;
  final Stock? stock;
  final int? boardId;
  final int? userId;
  final int viewCount;
  final int commentCount;
  final int? likeCount;
  final bool? liked;
  final bool? deleted;
  final bool? reported;
  final bool? isAuthorAdmin;
  @JsonKey(name: 'postImageList')
  final List<PostImage>? postImages;
  final List<Poll>? polls;
  @JsonKey(includeToJson: false)
  final String? thumbnailImageUrl;
  final bool isExclusiveToHolders;

  final GroupPush? push;
  final PushRequest? pushRequest;

  // 모두싸인을 이용한 전자문서
  final DigitalProxy? digitalProxy;

  // 내부 시스템을 이용한 전자문서
  final DigitalDocument? digitalDocument;

  // TODO: 나중에 상속을 통해 분리해야함 (digitalProxy, digitalDocument 등등)
  final SolidarityElectionResult? election;

  // 주주명부 열람/등사 청구
  final HolderListReadAndCopyDigitalDocument? holderListReadAndCopyDigitalDocument;

  final DateTime? activeStartDate;
  final DateTime? activeEndDate;

  const Post({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    this.content,
    this.userProfile,
    this.boardGroupCategory,
    this.boardGroupType,
    this.stock,
    this.boardId,
    this.userId,
    this.viewCount = 0,
    this.likeCount = 0,
    this.commentCount = 0,
    this.liked = false,
    this.deleted = false,
    this.reported = false,
    this.isAuthorAdmin = false,
    this.isNotification = false,
    this.isActive = true,
    this.postImages,
    this.polls,
    this.digitalProxy,
    this.digitalDocument,
    required this.status,
    this.thumbnailImageUrl,
    this.isExclusiveToHolders = false,
    this.activeStartDate,
    this.activeEndDate,
    this.push,
    this.pushRequest,
    this.election,
    this.holderListReadAndCopyDigitalDocument,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  Post copyWith({
    int? commentCount,
    int? likeCount,
    bool? liked,
    Stock? stock,
    String? title,
    String? content,
    BoardGroupCategory? boardGroupCategory,
    bool? isNotification,
    bool? isActive,
    bool? isExclusiveToHolders,
    DateTime? activeStartDate,
    DateTime? activeEndDate,
    GroupPush? push,
    PushRequest? pushRequest,
  }) {
    return Post(
      id: id,
      title: title ?? this.title,
      createdAt: createdAt,
      updatedAt: updatedAt,
      content: content ?? this.content,
      userProfile: userProfile,
      boardGroupCategory: boardGroupCategory ?? this.boardGroupCategory,
      boardGroupType: boardGroupType,
      stock: stock ?? this.stock,
      boardId: boardId,
      userId: userId,
      viewCount: viewCount,
      commentCount: commentCount ?? this.commentCount,
      likeCount: likeCount ?? this.likeCount,
      liked: liked ?? this.liked,
      deleted: deleted,
      reported: reported,
      isAuthorAdmin: isAuthorAdmin,
      postImages: postImages,
      polls: polls,
      digitalProxy: digitalProxy,
      digitalDocument: digitalDocument,
      status: status,
      isNotification: isNotification ?? this.isNotification,
      isActive: isActive ?? this.isActive,
      isExclusiveToHolders: isExclusiveToHolders ?? this.isExclusiveToHolders,
      activeEndDate: activeEndDate ?? this.activeEndDate,
      activeStartDate: activeStartDate ?? this.activeStartDate,
      push: push ?? this.push,
      pushRequest: pushRequest ?? this.pushRequest,
      election: election,
      holderListReadAndCopyDigitalDocument: holderListReadAndCopyDigitalDocument,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        createdAt,
        updatedAt,
        userId,
        viewCount,
        commentCount,
        likeCount,
        liked,
        deleted,
        reported,
        isAuthorAdmin,
        postImages,
        polls,
        digitalProxy,
        digitalDocument,
        status,
        isNotification,
        isActive,
        isExclusiveToHolders,
        pushRequest,
        activeEndDate,
        activeStartDate,
        election,
        holderListReadAndCopyDigitalDocument,
      ];
}

extension PostExtension on Post {
  bool get isDeleted => deleted ?? false;

  bool get isReported => reported ?? false;

  bool get isHolderListReadAndCopyPost =>
      holderListReadAndCopyDigitalDocument != null ||
      boardGroupCategory?.name == BoardCategoryType.holderListReadAndCopy.value;

  int get likedCount => likeCount ?? 0;

  UserProfile get displayUserProfile => userProfile ?? const UserProfile(nickname: '익명');

  String get isExclusiveToHoldersString => isExclusiveToHolders ? '주주에게만' : '전체';

  String getDetailRoutePath({
    required String stockCode,
    required BoardGroupType boardGroupType,
  }) {
    return '/stock/$stockCode/board/${boardGroupType.value}/post/$id';
  }
}
