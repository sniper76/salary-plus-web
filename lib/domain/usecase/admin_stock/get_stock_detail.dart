import 'package:act_cms/domain/model/stock_detail.dart';
import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetStockDetail {
  final AdminStockRepository repository;

  const GetStockDetail({required this.repository});

  Future<Result<StockDetail, Exception>> call({
    required String code,
  }) {
    return repository.getDetail(
      code: code,
    );
  }
}
