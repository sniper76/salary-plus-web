import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/enum/board_sort_type.dart';
import 'package:act_web/domain/model/post/comment.dart';
import 'package:act_web/domain/repository/comment_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetReplyList {
  final CommentRepository repository;
  const GetReplyList({required this.repository});

  Future<Result<DataResponse<List<Comment>>, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
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
    return repository.getReplyList(
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
