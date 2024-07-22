import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/model/post/board_group_category.dart';
import 'package:act_web/domain/repository/post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetBoardGroupCategories {
  final PostRepository repository;
  const GetBoardGroupCategories({required this.repository});

  Future<Result<List<BoardGroupCategory>, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
  }) {
    return repository.getBoardGroupCategories(
      stockCode: stockCode,
      boardGroupType: boardGroupType,
    );
  }
}
