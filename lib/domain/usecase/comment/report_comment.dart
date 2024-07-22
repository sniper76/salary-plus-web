import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/repository/comment_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class ReportComment {
  final CommentRepository repository;
  const ReportComment({required this.repository});

  Future<Result<void, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
    required String reason,
  }) {
    return repository.reportComment(
      stockCode: stockCode,
      boardGroupType: boardGroupType,
      postId: postId,
      commentId: commentId,
      reason: reason,
    );
  }
}
