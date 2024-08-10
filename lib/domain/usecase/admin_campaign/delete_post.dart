import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/repository/admin_post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class DeletePost {
  final AdminPostRepository repository;

  const DeletePost({required this.repository});

  Future<Result<void, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
  }) {
    return repository.delete(
      stockCode: stockCode,
      boardGroupType: boardGroupType,
      postId: postId,
    );
  }
}
