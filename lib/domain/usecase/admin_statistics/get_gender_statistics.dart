import 'package:act_cms/domain/model/dashboard_gender_statistics.dart';
import 'package:act_cms/domain/repository/admin_statistics_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetGenderStatistics {
  final AdminStatisticsRepository repository;

  const GetGenderStatistics({required this.repository});

  Future<Result<DashboardGenderStatistics, Exception>> call(
      {String? periodType, String? searchFrom, String? searchTo}) {
    return repository.getGenderStatistics(periodType: periodType, searchFrom: searchFrom, searchTo: searchTo);
  }
}
