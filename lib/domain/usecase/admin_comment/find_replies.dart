import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/comment.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/board_sort_type.dart';
import 'package:act_cms/domain/repository/admin_comment_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class FindReplies {
  final AdminCommentRepository repository;

  const FindReplies({required this.repository});

  Future<Result<DataResponse<List<Comment>>, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
    int page = 1,
    int size = 20,
    BoardSortType? sort,
  }) {
    final sorts = sort != null
        ? [
            '${sort.value}:${sort == BoardSortType.createdAtAsc ? 'ASC' : 'DESC'}',
            '${BoardSortType.createdAt.value}:ASC'
          ]
        : null;
    return repository.replies(
      stockCode: stockCode,
      boardGroupType: boardGroupType,
      postId: postId,
      commentId: commentId,
      page: page,
      size: size,
      sorts: sorts?.join(','),
    );
  }
}
