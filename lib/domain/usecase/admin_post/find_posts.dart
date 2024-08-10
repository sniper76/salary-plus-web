import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/board_sort_type.dart';
import 'package:act_cms/domain/model/enum/post_search_type.dart';
import 'package:act_cms/domain/model/enum/post_status_type.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/repository/admin_post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class FindPosts {
  final AdminPostRepository repository;

  const FindPosts({required this.repository});

  Future<Result<DataResponse<List<Post>>, Exception>> call({
    required BoardGroupType boardGroup,
    BoardGroupCategory? boardCategory,
    BoardSearchType? searchType,
    String? searchKeyword,
    PostStatusType? status,
    int page = 1,
    int size = 20,
    BoardSortType? sort,
    DateTime? searchStartDate,
    DateTime? searchEndDate,
  }) {
    final sorts = sort != null ? ['${sort.value}:DESC', '${BoardSortType.createdAt.value}:DESC'] : null;
    return repository.get(
      boardGroup: boardGroup,
      boardCategory: boardCategory,
      searchType: searchType,
      searchKeyword: searchKeyword,
      status: status,
      page: page,
      size: size,
      sorts: sorts?.join(','),
      searchStartDateString: searchStartDate?.toUtc().toIso8601String(),
      searchEndDateString: searchEndDate?.toUtc().toIso8601String(),
    );
  }
}
