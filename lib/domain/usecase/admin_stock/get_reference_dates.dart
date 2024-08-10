import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/stock_reference_date.dart';
import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetReferenceDates {
  final AdminStockRepository repository;

  const GetReferenceDates({required this.repository});

  Future<Result<DataResponse<List<StockReferenceDate>>, Exception>> call({
    required String stockCode,
  }) {
    return repository.getReferenceDates(
      stockCode: stockCode,
    );
  }
}
