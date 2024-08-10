import 'package:act_cms/core/util/helper.dart';
import 'package:act_cms/data/datasource/remote/api_datasource.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/dashboard_age_statistics.dart';
import 'package:act_cms/domain/model/dashboard_gender_statistics.dart';
import 'package:act_cms/domain/model/dashboard_statistics.dart';
import 'package:act_cms/domain/repository/admin_statistics_repository.dart';
import 'package:multiple_result/src/result.dart';

class AdminStatisticsRepositoryImpl implements AdminStatisticsRepository {
  final ApiDataSource dataSource;

  const AdminStatisticsRepositoryImpl({required this.dataSource});

  @override
  Future<Result<DataResponse<List<DashboardStatistics>>, Exception>> getStatistics({
    String? type,
    String? stockCode,
    String? periodType,
    String? searchFrom,
    String? searchTo,
  }) {
    return safeCall<DataResponse<List<DashboardStatistics>>>(
        dataSource.getAdminStatistics(type, stockCode, periodType, searchFrom, searchTo));
  }

  @override
  Future<Result<DashboardGenderStatistics, Exception>> getGenderStatistics(
      {String? periodType, String? searchFrom, String? searchTo}) async {
    final res = await safeCall<DataResponse<DashboardGenderStatistics>>(
        dataSource.getAdminGenderStatistics(periodType, searchFrom, searchTo));
    final result = res.tryGetSuccess()?.data;
    return (res.isSuccess() && result != null) ? Result.success(result) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<DashboardAgeStatistics, Exception>> getAgeStatistics(
      {String? periodType, String? searchFrom, String? searchTo}) async {
    final res = await safeCall<DataResponse<DashboardAgeStatistics>>(
        dataSource.getAdminAgeStatistics(periodType, searchFrom, searchTo));
    final result = res.tryGetSuccess()?.data;
    return (res.isSuccess() && result != null) ? Result.success(result) : Result.error(res.tryGetError()!);
  }
}
