import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/dashboard_age_statistics.dart';
import 'package:act_cms/domain/model/dashboard_gender_statistics.dart';
import 'package:act_cms/domain/model/dashboard_statistics.dart';
import 'package:multiple_result/src/result.dart';

abstract class AdminStatisticsRepository {
  Future<Result<DataResponse<List<DashboardStatistics>>, Exception>> getStatistics({
    String? type,
    String? stockCode,
    String? periodType,
    String? searchFrom,
    String? searchTo,
  });

  Future<Result<DashboardGenderStatistics, Exception>> getGenderStatistics(
      {String? periodType, String? searchFrom, String? searchTo});

  Future<Result<DashboardAgeStatistics, Exception>> getAgeStatistics(
      {String? periodType, String? searchFrom, String? searchTo});
}
