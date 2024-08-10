import 'package:act_cms/core/extension/string_extension.dart';
import 'package:act_cms/domain/model/user_profile.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment extends Equatable {
  final int id;
  @JsonKey(fromJson: _contentFromJson)
  final String content;
  final int userId;
  final UserProfile? userProfile;
  final bool deleted;
  final bool reported;
  final bool liked;
  final int likeCount;
  final int replyCommentCount;
  final DateTime createdAt;
  final DateTime editedAt;
  final bool isTemporaryAdded;

  const Comment({
    required this.id,
    required this.content,
    required this.userId,
    this.userProfile,
    this.deleted = false,
    this.reported = false,
    this.liked = false,
    this.likeCount = 0,
    this.replyCommentCount = 0,
    required this.createdAt,
    required this.editedAt,
    this.isTemporaryAdded = false,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  static String _contentFromJson(String value) => value.unEscapedString;

  Comment copyWith({
    int? likeCount,
    bool? liked,
    bool? deleted,
    String? content,
    bool? isTemporaryAdded,
  }) {
    return Comment(
      id: id,
      content: content ?? this.content,
      userId: userId,
      userProfile: userProfile,
      createdAt: createdAt,
      editedAt: editedAt,
      replyCommentCount: replyCommentCount,
      likeCount: likeCount ?? this.likeCount,
      liked: liked ?? this.liked,
      deleted: deleted ?? this.deleted,
      reported: reported,
      isTemporaryAdded: isTemporaryAdded ?? this.isTemporaryAdded,
    );
  }

  @override
  List<Object?> get props => [
        id,
        content,
        userId,
        userProfile,
        liked,
        likeCount,
        createdAt,
        editedAt,
        replyCommentCount,
        deleted,
        reported,
      ];
}

extension CommentExtension on Comment {
  bool get isActive => !deleted && !reported;
}
