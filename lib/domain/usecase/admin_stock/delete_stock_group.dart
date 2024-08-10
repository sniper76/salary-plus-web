import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class DeleteStockGroup {
  final AdminStockRepository repository;

  const DeleteStockGroup({required this.repository});

  Future<Result<void, Exception>> call({
    required stockGroupId,
  }) {
    return repository.deleteStockGroup(stockGroupId: stockGroupId);
  }
}
