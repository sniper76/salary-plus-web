import 'package:act_cms/domain/model/stock_group.dart';
import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class CreateStockGroup {
  final AdminStockRepository repository;

  const CreateStockGroup({required this.repository});

  Future<Result<StockGroup, Exception>> call({required String name, String? description, List<String>? stockCodes}) {
    return repository.CreateStockGroup(name: name, description: description, stockCodes: stockCodes);
  }
}
