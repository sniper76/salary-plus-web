import 'package:act_cms/domain/model/stock_group.dart';
import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UpdateStockGroupDetail {
  final AdminStockRepository repository;

  const UpdateStockGroupDetail({required this.repository});

  Future<Result<StockGroup, Exception>> call(
      {required int stockGroupId,
      required String name,
      required String description,
      required List<String> stockCodes}) {
    return repository.updateGroupDetail(
        stockGroupId: stockGroupId, name: name, description: description, stockCodes: stockCodes);
  }
}
