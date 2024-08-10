import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/stock.dart';
import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetAutoCompeteStocks {
  final AdminStockRepository repository;

  const GetAutoCompeteStocks({required this.repository});

  Future<Result<DataResponse<List<Stock>>, Exception>> call({String? searchKeyword}) {
    return repository.getAutoComplete(searchKeyword: searchKeyword);
  }
}
