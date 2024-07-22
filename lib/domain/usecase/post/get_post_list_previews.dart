import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/model/post/board_group_category.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:act_web/domain/repository/post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetPostListPreviews {
  final PostRepository repository;

  const GetPostListPreviews({required this.repository});

  Future<Result<DataResponse<List<Post>>, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    BoardGroupCategory? boardGroupCategory,
  }) {
    final bool isGroupedCategory = boardGroupCategory?.isGroup == true;

    if (isGroupedCategory) {
      return repository.getPostListPreviews(
        stockCode: stockCode,
        boardGroupType: boardGroupType,
        // changing points due to isGroupedCategory
        groupedBoardGroupCategoryName: boardGroupCategory?.name,
      );
    } else {
      return repository.getPostListPreviews(
        stockCode: stockCode,
        boardGroupType: boardGroupType,
        // changing points due to isGroupedCategory
        boardGroupCategoryName: boardGroupCategory?.name,
      );
    }
  }
}
