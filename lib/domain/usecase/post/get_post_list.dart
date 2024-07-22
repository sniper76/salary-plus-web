import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/enum/board_sort_type.dart';
import 'package:act_web/domain/model/post/board_group_category.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:act_web/domain/repository/post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetPostList {
  final PostRepository repository;

  const GetPostList({required this.repository});

  Future<Result<DataResponse<List<Post>>, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    BoardGroupCategory? boardGroupCategory,
    int page = 1,
    int size = 10,
    BoardSortType? sort,
    bool? isExclusiveToHolders,
  }) {
    final sorts = sort != null ? ['${sort.value}:DESC', '${BoardSortType.createdAt.value}:DESC'] : null;
    final bool isGroupedCategory = boardGroupCategory?.isGroup == true;

    if (isGroupedCategory) {
      return repository.getPostList(
        stockCode: stockCode,
        boardGroupType: boardGroupType,
        // changing points due to isGroupedCategory
        groupedBoardGroupCategoryName: boardGroupCategory?.name,
        page: page,
        size: size,
        sorts: sorts?.join(','),
        isExclusiveToHolders: isExclusiveToHolders,
      );
    } else {
      return repository.getPostList(
        stockCode: stockCode,
        boardGroupType: boardGroupType,
        // changing points due to isGroupedCategory
        boardGroupCategoryName: boardGroupCategory?.name,
        page: page,
        size: size,
        sorts: sorts?.join(','),
        isExclusiveToHolders: isExclusiveToHolders,
      );
    }
  }
}
