import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/repository/post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class ReportPost {
  final PostRepository repository;
  const ReportPost({required this.repository});

  Future<Result<void, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required String reason,
  }) {
    return repository.reportPost(
      stockCode: stockCode,
      boardGroupType: boardGroupType,
      postId: postId,
      reason: reason,
    );
  }
}
