import 'package:act_web/core/extension/string_extension.dart';
import 'package:act_web/domain/model/user/user_profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  const Comment._();

  const factory Comment({
    required int id,
    @JsonKey(fromJson: _contentFromJson) required String content,
    required int userId,
    UserProfile? userProfile,
    @Default(false) bool deleted,
    @Default(false) bool reported,
    @Default(false) bool liked,
    @Default(0) int likeCount,
    @Default(0) int replyCommentCount,
    @Default([]) List<Comment> replyComments,
    required DateTime createdAt,
    required DateTime editedAt,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
}

extension CommentExtension on Comment {
  bool get isActive => !deleted && !reported;
}

String _contentFromJson(String value) => value.unEscapedString;
