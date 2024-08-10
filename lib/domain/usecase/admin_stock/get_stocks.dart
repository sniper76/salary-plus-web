import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/stock.dart';
import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetStocks {
  final AdminStockRepository repository;

  const GetStocks({required this.repository});

  Future<Result<DataResponse<List<Stock>>, Exception>> call({
    String? code,
    int? page,
    int? size,
    String? sorts,
  }) {
    return repository.get(
      code: code,
      page: page,
      size: size,
      sorts: sorts,
    );
  }
}
