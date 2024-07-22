import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/enum/board_sort_type.dart';
import 'package:act_web/domain/model/post/comment.dart';
import 'package:act_web/domain/repository/comment_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetCommentList {
  final CommentRepository repository;
  const GetCommentList({required this.repository});

  Future<Result<DataResponse<List<Comment>>, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    int page = 1,
    int size = 10,
    BoardSortType? sort,
  }) {
    final sorts = sort != null
        ? [
            '${sort.value}:${sort == BoardSortType.createdAtAsc ? 'ASC' : 'DESC'}',
            '${BoardSortType.createdAt.value}:ASC'
          ]
        : null;
    return repository.getCommentList(
      stockCode: stockCode,
      boardGroupType: boardGroupType,
      postId: postId,
      page: page,
      size: size,
      sorts: sorts?.join(','),
    );
  }
}
