import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/repository/comment_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UnlikeComment {
  final CommentRepository repository;
  const UnlikeComment({required this.repository});

  Future<Result<void, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
  }) {
    return repository.unlikeComment(
      stockCode: stockCode,
      boardGroupType: boardGroupType,
      postId: postId,
      commentId: commentId,
    );
  }
}