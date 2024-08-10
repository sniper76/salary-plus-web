import 'package:act_cms/domain/model/stock_reference_date.dart';
import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class CreateReferenceDates {
  final AdminStockRepository repository;

  const CreateReferenceDates({required this.repository});

  Future<Result<StockReferenceDate, Exception>> call({required String stockCode, DateTime? date}) {
    return repository.createReferenceDates(stockCode: stockCode, date: date);
  }
}
