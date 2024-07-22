import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/model/post/comment.dart';
import 'package:act_web/domain/repository/comment_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class CreateReply {
  final CommentRepository repository;
  const CreateReply({required this.repository});

  Future<Result<Comment, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
    required String content,
    bool isAnonymous = false,
  }) {
    return repository.createReply(
      stockCode: stockCode,
      boardGroupType: boardGroupType,
      postId: postId,
      commentId: commentId,
      content: content,
      isAnonymous: isAnonymous,
    );
  }
}