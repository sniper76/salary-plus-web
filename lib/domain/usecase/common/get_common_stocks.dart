import 'package:act_web/domain/model/stock/base_stock.dart';
import 'package:act_web/domain/repository/common_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetCommonStocks {
  final CommonRepository repository;

  GetCommonStocks({required this.repository});

  Future<Result<List<BaseStock>, Exception>> call() => repository.getCommonStocks();
}
