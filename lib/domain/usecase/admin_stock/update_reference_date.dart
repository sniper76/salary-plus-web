import 'package:act_cms/domain/model/stock_reference_date.dart';
import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UpdateReferenceDate {
  final AdminStockRepository repository;

  const UpdateReferenceDate({required this.repository});

  Future<Result<StockReferenceDate, Exception>> call({
    required int stockReferenceDateId,
    required String stockCode,
    DateTime? referenceDate,
  }) {
    return repository.updateReferenceDate(
        stockReferenceDateId: stockReferenceDateId, stockCode: stockCode, referenceDate: referenceDate);
  }
}
