import 'package:act_web/domain/model/stock_home/stock_home.dart';
import 'package:act_web/domain/repository/stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetStockHome {
  final StockRepository repository;

  const GetStockHome({required this.repository});

  Future<Result<StockHome, Exception>> call(String stockCode) {
    return repository.getStockHome(stockCode);
  }
}
