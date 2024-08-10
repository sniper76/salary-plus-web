import 'package:act_cms/domain/model/stock_group_detail.dart';
import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetStockGroupDetail {
  final AdminStockRepository repository;

  const GetStockGroupDetail({required this.repository});

  Future<Result<StockGroupDetail, Exception>> call({
    required stockGroupId,
  }) {
    return repository.getGroupDetail(
      stockGroupId: stockGroupId,
    );
  }
}
