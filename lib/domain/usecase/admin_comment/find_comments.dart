import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/comment.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/board_sort_type.dart';
import 'package:act_cms/domain/repository/admin_comment_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class FindComments {
  final AdminCommentRepository repository;

  const FindComments({required this.repository});

  Future<Result<DataResponse<List<Comment>>, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
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
    return repository.list(
      stockCode: stockCode,
      boardGroupType: boardGroupType,
      postId: postId,
      page: page,
      size: size,
      sorts: sorts?.join(','),
    );
  }
}
