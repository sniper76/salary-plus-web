import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class AddDummyStock {
  final AdminStockRepository repository;

  const AddDummyStock({required this.repository});

  Future<Result<void, Exception>> call(
      {required int userId, required String stockCode, required int stockReferenceDateId}) {
    return repository.addDummyStock(userId: userId, stockCode: stockCode, stockReferenceDateId: stockReferenceDateId);
  }
}
