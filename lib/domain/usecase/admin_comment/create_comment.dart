import 'package:act_cms/domain/model/comment.dart';
import 'package:act_cms/domain/repository/admin_comment_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class CreateComment {
  final AdminCommentRepository repository;

  const CreateComment({required this.repository});

  Future<Result<Comment, Exception>> call({
    required String stockCode,
    required String boardGroup,
    required int postId,
    required String content,
    required bool isAnonymous,
  }) {
    return repository.create(
      stockCode: stockCode,
      boardGroup: boardGroup,
      postId: postId,
      content: content,
      isAnonymous: isAnonymous,
    );
  }
}
