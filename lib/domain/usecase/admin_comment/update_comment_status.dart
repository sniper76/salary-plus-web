import 'package:act_cms/domain/model/comment.dart';
import 'package:act_cms/domain/repository/admin_comment_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UpdateCommentStatus {
  final AdminCommentRepository repository;

  const UpdateCommentStatus({required this.repository});

  Future<Result<Comment, Exception>> call({
    required String stockCode,
    required String boardGroup,
    required int postId,
    required int commentId,
    required String status,
  }) {
    return repository.updateStatus(
      stockCode: stockCode,
      boardGroup: boardGroup,
      postId: postId,
      commentId: commentId,
      status: status,
    );
  }
}
