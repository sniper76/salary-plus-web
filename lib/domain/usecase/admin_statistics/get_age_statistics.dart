import 'package:act_cms/domain/model/dashboard_age_statistics.dart';
import 'package:act_cms/domain/repository/admin_statistics_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetAgeStatistics {
  final AdminStatisticsRepository repository;

  const GetAgeStatistics({required this.repository});

  Future<Result<DashboardAgeStatistics, Exception>> call({String? periodType, String? searchFrom, String? searchTo}) {
    return repository.getAgeStatistics(periodType: periodType, searchFrom: searchFrom, searchTo: searchTo);
  }
}
