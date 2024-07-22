import 'package:act_web/domain/repository/common_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class PostStockSearchTrends {
  final CommonRepository repository;

  PostStockSearchTrends({required this.repository});

  Future<Result<void, Exception>> call({required String stockCode}) {
    return repository.postStockSearchTrend(stockCode: stockCode);
  }
}
