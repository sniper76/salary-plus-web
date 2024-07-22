import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/repository/comment_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class LikeComment {
  final CommentRepository repository;
  const LikeComment({required this.repository});

  Future<Result<void, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
  }) {
    return repository.likeComment(
      stockCode: stockCode,
      boardGroupType: boardGroupType,
      postId: postId,
      commentId: commentId,
    );
  }
}
