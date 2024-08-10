import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/campaign.dart';
import 'package:act_cms/domain/model/enum/board_sort_type.dart';
import 'package:act_cms/domain/model/enum/campaign_search_type.dart';
import 'package:act_cms/domain/repository/admin_campaign_repository.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:multiple_result/multiple_result.dart';

class GetCampaigns {
  final AdminCampaignRepository repository;

  const GetCampaigns({required this.repository});

  Future<Result<DataResponse<List<Campaign>>, Exception>> call({
    required CampaignSearchType searchType,
    BoardGroupCategory? boardCategory,
    String? searchKeyword,
    int page = 1,
    int size = apiLoadSize,
    BoardSortType? sort,
  }) {
    final sorts = sort != null ? ['${sort.value}:DESC', '${BoardSortType.createdAt.value}:DESC'] : null;
    return repository.list(
      searchType: searchType,
      searchKeyword: searchKeyword,
      boardCategory: boardCategory?.name ?? BoardGroupCategory.defaultCategory().name,
      page: page,
      size: size,
      sorts: sorts?.join(','),
    );
  }
}
