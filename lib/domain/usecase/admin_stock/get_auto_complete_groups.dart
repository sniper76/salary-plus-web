import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/stock_group.dart';
import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetAutoCompeteGroups {
  final AdminStockRepository repository;

  const GetAutoCompeteGroups({required this.repository});

  Future<Result<DataResponse<List<StockGroup>>, Exception>> call({String? searchKeyword}) {
    return repository.getGroupsAutoCompete(searchKeyword: searchKeyword);
  }
}
