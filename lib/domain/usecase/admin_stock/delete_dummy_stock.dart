import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class DeleteDummyStock {
  final AdminStockRepository repository;

  const DeleteDummyStock({required this.repository});

  Future<Result<void, Exception>> call({required int userId, required String stockCode}) {
    return repository.deleteDummyStock(userId: userId, stockCode: stockCode);
  }
}
