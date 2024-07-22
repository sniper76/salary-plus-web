import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/repository/post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class DeletePost {
  final PostRepository repository;
  const DeletePost({required this.repository});

  Future<Result<void, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
  }) {
    return repository.deletePost(
      stockCode: stockCode,
      boardGroupType: boardGroupType,
      postId: postId,
    );
  }
}
