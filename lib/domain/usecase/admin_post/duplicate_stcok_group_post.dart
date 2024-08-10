import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/repository/admin_post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class DuplicateStockGroupPost {
  final AdminPostRepository repository;

  const DuplicateStockGroupPost({required this.repository});

  Future<Result<Post, Exception>> call({
    required int postId,
    required String stockCode,
  }) {
    return repository.duplicateStockGroup(
      postId: postId,
      stockCode: stockCode,
    );
  }
}
