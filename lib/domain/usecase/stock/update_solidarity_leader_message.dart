import 'package:act_web/domain/repository/stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UpdateSolidarityLeaderMessage {
  final StockRepository repository;

  const UpdateSolidarityLeaderMessage({required this.repository});

  Future<Result<void, Exception>> call(
      {required String stockCode, required int solidarityId, required String message}) {
    return repository.updateSolidarityLeaderMessage(stockCode: stockCode, solidarityId: solidarityId, message: message);
  }
}
