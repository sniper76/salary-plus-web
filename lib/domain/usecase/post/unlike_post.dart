import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:act_web/domain/repository/post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UnlikePost {
  final PostRepository repository;
  const UnlikePost({required this.repository});

  Future<Result<Post, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
  }) {
    return repository.unlikePost(
      stockCode: stockCode,
      boardGroupType: boardGroupType,
      postId: postId,
    );
  }
}
