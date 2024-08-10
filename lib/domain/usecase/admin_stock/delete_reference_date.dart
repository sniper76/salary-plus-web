import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class DeleteReferenceDate {
  final AdminStockRepository repository;

  const DeleteReferenceDate({required this.repository});

  Future<Result<void, Exception>> call({
    required int referenceDateId,
    required String stockCode,
    String? referenceDate,
  }) {
    return repository.deleteReferenceDate(
      referenceDateId: referenceDateId,
      stockCode: stockCode,
    );
  }
}
