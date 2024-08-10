import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/stock_group.dart';
import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetGroups {
  final AdminStockRepository repository;

  const GetGroups({required this.repository});

  Future<Result<DataResponse<List<StockGroup>>, Exception>> call(
      {int? stockGroupId, int? page, int? size, String? sorts}) {
    return repository.getGroups(stockGroupId: stockGroupId, page: page, size: size, sorts: sorts);
  }
}
