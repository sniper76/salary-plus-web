import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:act_web/domain/repository/post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class LikePost {
  final PostRepository repository;
  const LikePost({required this.repository});

  Future<Result<Post, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
  }) {
    return repository.likePost(
      stockCode: stockCode,
      boardGroupType: boardGroupType,
      postId: postId,
    );
  }
}
