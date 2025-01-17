// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SectionItemImpl _$$SectionItemImplFromJson(Map<String, dynamic> json) =>
    _$SectionItemImpl(
      title: json['title'] as String,
      link: json['link'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      deleted: json['deleted'] as bool? ?? false,
      reported: json['reported'] as bool? ?? false,
      isNew: json['isNew'] as bool? ?? false,
      isExclusiveToHolders: json['isExclusiveToHolders'] as bool? ?? false,
      thumbnailImageUrl: json['thumbnailImageUrl'] as String?,
      userProfile: json['userProfile'] == null
          ? null
          : UserProfile.fromJson(json['userProfile'] as Map<String, dynamic>),
      boardGroupCategory: json['boardCategory'] == null
          ? null
          : BoardGroupCategory.fromJson(
              json['boardCategory'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SectionItemImplToJson(_$SectionItemImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'viewCount': instance.viewCount,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'deleted': instance.deleted,
      'reported': instance.reported,
      'isNew': instance.isNew,
      'isExclusiveToHolders': instance.isExclusiveToHolders,
      'thumbnailImageUrl': instance.thumbnailImageUrl,
      'userProfile': instance.userProfile,
      'boardCategory': instance.boardGroupCategory,
    };
