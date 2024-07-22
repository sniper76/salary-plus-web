import 'package:act_web/domain/model/stock/base_stock.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class CommonRepository {
  Future<Result<List<BaseStock>, Exception>> getCommonStocks();

  Future<Result<void, Exception>> postStockSearchTrend({required String stockCode});
}
