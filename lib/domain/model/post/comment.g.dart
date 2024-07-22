// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: (json['id'] as num).toInt(),
      content: _contentFromJson(json['content'] as String),
      userId: (json['userId'] as num).toInt(),
      userProfile: json['userProfile'] == null
          ? null
          : UserProfile.fromJson(json['userProfile'] as Map<String, dynamic>),
      deleted: json['deleted'] as bool? ?? false,
      reported: json['reported'] as bool? ?? false,
      liked: json['liked'] as bool? ?? false,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      replyCommentCount: (json['replyCommentCount'] as num?)?.toInt() ?? 0,
      replyComments: (json['replyComments'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      editedAt: DateTime.parse(json['editedAt'] as String),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'userId': instance.userId,
      'userProfile': instance.userProfile,
      'deleted': instance.deleted,
      'reported': instance.reported,
      'liked': instance.liked,
      'likeCount': instance.likeCount,
      'replyCommentCount': instance.replyCommentCount,
      'replyComments': instance.replyComments,
      'createdAt': instance.createdAt.toIso8601String(),
      'editedAt': instance.editedAt.toIso8601String(),
    };
