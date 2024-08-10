import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/dashboard_statistics.dart';
import 'package:act_cms/domain/repository/admin_statistics_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetStatistics {
  final AdminStatisticsRepository repository;

  const GetStatistics({required this.repository});

  Future<Result<DataResponse<List<DashboardStatistics>>, Exception>> call(
      {String? type, String? stockCode, String? periodType, String? searchFrom, String? searchTo}) {
    return repository.getStatistics(
        type: type, stockCode: stockCode, periodType: periodType, searchFrom: searchFrom, searchTo: searchTo);
  }
}
