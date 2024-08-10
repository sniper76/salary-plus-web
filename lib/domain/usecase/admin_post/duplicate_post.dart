import 'package:act_cms/domain/repository/admin_post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class DuplicatePost {
  final AdminPostRepository repository;

  const DuplicatePost({required this.repository});

  Future<Result<void, Exception>> call({
    required int postId,
    required int stockGroupId,
  }) {
    return repository.duplicate(
      postId: postId,
      stockGroupId: stockGroupId,
    );
  }
}
