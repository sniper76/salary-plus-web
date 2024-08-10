import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/stock_summary.dart';
import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetStockStatistics {
  final AdminStockRepository repository;

  const GetStockStatistics({required this.repository});

  Future<Result<DataResponse<List<StockSummary>>, Exception>> call({
    required String code,
    required String type,
    required String periodType,
    required String period,
  }) {
    return repository.getStatistics(
      code: code,
      type: type,
      periodType: periodType,
      period: period,
    );
  }
}
