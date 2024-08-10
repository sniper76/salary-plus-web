// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      content: json['content'] as String?,
      userProfile: json['userProfile'] == null
          ? null
          : UserProfile.fromJson(json['userProfile'] as Map<String, dynamic>),
      boardGroupCategory: json['boardCategory'] == null
          ? null
          : BoardGroupCategory.fromJson(
              json['boardCategory'] as Map<String, dynamic>),
      boardGroupType: $enumDecodeNullable(
          _$BoardGroupTypeEnumMap, json['boardGroup'],
          unknownValue: BoardGroupType.unknown),
      stock: json['stock'] == null
          ? null
          : Stock.fromJson(json['stock'] as Map<String, dynamic>),
      boardId: (json['boardId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      liked: json['liked'] as bool? ?? false,
      deleted: json['deleted'] as bool? ?? false,
      reported: json['reported'] as bool? ?? false,
      isAuthorAdmin: json['isAuthorAdmin'] as bool? ?? false,
      isNotification: json['isNotification'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      postImages: (json['postImageList'] as List<dynamic>?)
          ?.map((e) => PostImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      polls: (json['polls'] as List<dynamic>?)
          ?.map((e) => Poll.fromJson(e as Map<String, dynamic>))
          .toList(),
      digitalProxy: json['digitalProxy'] == null
          ? null
          : DigitalProxy.fromJson(json['digitalProxy'] as Map<String, dynamic>),
      digitalDocument: json['digitalDocument'] == null
          ? null
          : DigitalDocument.fromJson(
              json['digitalDocument'] as Map<String, dynamic>),
      status: $enumDecode(_$PostStatusTypeEnumMap, json['status'],
          unknownValue: PostStatusType.unknown),
      thumbnailImageUrl: json['thumbnailImageUrl'] as String?,
      isExclusiveToHolders: json['isExclusiveToHolders'] as bool? ?? false,
      activeStartDate: json['activeStartDate'] == null
          ? null
          : DateTime.parse(json['activeStartDate'] as String),
      activeEndDate: json['activeEndDate'] == null
          ? null
          : DateTime.parse(json['activeEndDate'] as String),
      push: json['push'] == null
          ? null
          : GroupPush.fromJson(json['push'] as Map<String, dynamic>),
      pushRequest: json['pushRequest'] == null
          ? null
          : PushRequest.fromJson(json['pushRequest'] as Map<String, dynamic>),
      election: json['election'] == null
          ? null
          : SolidarityElectionResult.fromJson(
              json['election'] as Map<String, dynamic>),
      holderListReadAndCopyDigitalDocument:
          json['holderListReadAndCopyDigitalDocument'] == null
              ? null
              : HolderListReadAndCopyDigitalDocument.fromJson(
                  json['holderListReadAndCopyDigitalDocument']
                      as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'content': instance.content,
      'userProfile': instance.userProfile,
      'status': _$PostStatusTypeEnumMap[instance.status]!,
      'boardCategory': instance.boardGroupCategory,
      'boardGroup': _$BoardGroupTypeEnumMap[instance.boardGroupType],
      'isNotification': instance.isNotification,
      'isActive': instance.isActive,
      'stock': instance.stock,
      'boardId': instance.boardId,
      'userId': instance.userId,
      'viewCount': instance.viewCount,
      'commentCount': instance.commentCount,
      'likeCount': instance.likeCount,
      'liked': instance.liked,
      'deleted': instance.deleted,
      'reported': instance.reported,
      'isAuthorAdmin': instance.isAuthorAdmin,
      'postImageList': instance.postImages,
      'polls': instance.polls,
      'isExclusiveToHolders': instance.isExclusiveToHolders,
      'push': instance.push,
      'pushRequest': instance.pushRequest,
      'digitalProxy': instance.digitalProxy,
      'digitalDocument': instance.digitalDocument,
      'election': instance.election,
      'holderListReadAndCopyDigitalDocument':
          instance.holderListReadAndCopyDigitalDocument,
      'activeStartDate': instance.activeStartDate?.toIso8601String(),
      'activeEndDate': instance.activeEndDate?.toIso8601String(),
    };

const _$BoardGroupTypeEnumMap = {
  BoardGroupType.analysis: 'ANALYSIS',
  BoardGroupType.action: 'ACTION',
  BoardGroupType.debate: 'DEBATE',
  BoardGroupType.globalboard: 'GLOBALBOARD',
  BoardGroupType.globalcommunity: 'GLOBALCOMMUNITY',
  BoardGroupType.globalevent: 'GLOBALEVENT',
  BoardGroupType.unknown: 'UNKNOWN',
};

const _$PostStatusTypeEnumMap = {
  PostStatusType.active: 'ACTIVE',
  PostStatusType.processing: 'PROCESSING',
  PostStatusType.inactive_by_user: 'INACTIVE_BY_USER',
  PostStatusType.inactive_by_admin: 'INACTIVE_BY_ADMIN',
  PostStatusType.withdawal_by_request: 'WITHDRAWAL_REQUESTED',
  PostStatusType.deleted_by_user: 'DELETED_BY_USER',
  PostStatusType.deleted_by_admin: 'DELETED_BY_ADMIN',
  PostStatusType.delete: 'DELETED',
  PostStatusType.all: 'ALL',
  PostStatusType.unknown: 'UNKNOWN',
};
