import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/enum/board_sort_type.dart';
import 'package:act_cms/domain/model/enum/popup/popup_search_type.dart';
import 'package:act_cms/domain/model/enum/popup/popup_status.dart';
import 'package:act_cms/domain/model/popup.dart';
import 'package:act_cms/domain/repository/admin_popup_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class FindPopups {
  final AdminPopupRepository repository;

  const FindPopups({required this.repository});

  Future<Result<DataResponse<List<Popup>>, Exception>> call({
    required String searchKeyword,
    required PopupSearchType searchType,
    PopupStatus? popupStatus,
    int page = 1,
    int size = 20,
    BoardSortType? sort,
  }) {
    final sorts = sort != null ? ['${sort.value}:DESC', '${BoardSortType.createdAt.value}:DESC'] : null;
    return repository.list(
      searchType: searchType,
      searchKeyword: searchKeyword,
      popupStatus: popupStatus?.value,
      page: page,
      size: size,
      sorts: sorts?.join(','),
    );
  }
}
