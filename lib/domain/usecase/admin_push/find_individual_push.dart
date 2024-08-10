import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/enum/board_sort_type.dart';
import 'package:act_cms/domain/model/enum/push/push_search_type.dart';
import 'package:act_cms/domain/model/individual_push.dart';
import 'package:act_cms/domain/repository/admin_push_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class FindIndividualPush {
  final AdminPushRepository repository;

  const FindIndividualPush({required this.repository});

  Future<Result<DataResponse<List<IndividualPush>>, Exception>> call({
    String? searchKeyword,
    required PushSearchType searchType,
    int page = 1,
    int size = 20,
    BoardSortType? sort,
  }) {
    final sorts = sort != null ? ['${sort.value}:DESC', '${BoardSortType.createdAt.value}:DESC'] : null;
    return repository.individualList(
      searchType: searchType.value,
      searchKeyword: searchKeyword,
      page: page,
      size: size,
      sorts: sorts?.join(','),
    );
  }
}
