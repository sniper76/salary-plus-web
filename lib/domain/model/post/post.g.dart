// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
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
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      liked: json['liked'] as bool? ?? false,
      deleted: json['deleted'] as bool? ?? false,
      reported: json['reported'] as bool? ?? false,
      isAuthorAdmin: json['isAuthorAdmin'] as bool? ?? false,
      isExclusiveToHolders: json['isExclusiveToHolders'] as bool? ?? false,
      isNew: json['isNew'] as bool? ?? false,
      thumbnailImageUrl: json['thumbnailImageUrl'] as String?,
      postImages: (json['postImageList'] as List<dynamic>?)
          ?.map((e) => PostImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      polls: (json['polls'] as List<dynamic>?)
              ?.map((e) => Poll.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      digitalProxy: json['digitalProxy'] == null
          ? null
          : DigitalProxy.fromJson(json['digitalProxy'] as Map<String, dynamic>),
      digitalDocument: json['digitalDocument'] == null
          ? null
          : DigitalDocument.fromJson(
              json['digitalDocument'] as Map<String, dynamic>),
      holderListReadAndCopyDigitalDocument:
          json['holderListReadAndCopyDigitalDocument'] == null
              ? null
              : HolderListReadAndCopyDigitalDocument.fromJson(
                  json['holderListReadAndCopyDigitalDocument']
                      as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'content': instance.content,
      'userProfile': instance.userProfile,
      'boardCategory': instance.boardGroupCategory,
      'boardGroup': _$BoardGroupTypeEnumMap[instance.boardGroupType],
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
      'isExclusiveToHolders': instance.isExclusiveToHolders,
      'isNew': instance.isNew,
      'thumbnailImageUrl': instance.thumbnailImageUrl,
      'postImageList': instance.postImages,
      'polls': instance.polls,
      'digitalProxy': instance.digitalProxy,
      'digitalDocument': instance.digitalDocument,
      'holderListReadAndCopyDigitalDocument':
          instance.holderListReadAndCopyDigitalDocument,
    };

const _$BoardGroupTypeEnumMap = {
  BoardGroupType.analysis: 'ANALYSIS',
  BoardGroupType.action: 'ACTION',
  BoardGroupType.debate: 'DEBATE',
  BoardGroupType.globalboard: 'GLOBALBOARD',
  BoardGroupType.globalcommunity: 'GLOBALCOMMUNITY',
  BoardGroupType.globalevent: 'GLOBALEVENT',
  BoardGroupType.actBest: 'ACT_BEST',
  BoardGroupType.unknown: 'UNKNOWN',
};
