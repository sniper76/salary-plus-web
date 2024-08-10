import 'package:act_cms/core/util/helper.dart';
import 'package:act_cms/data/datasource/remote/api_datasource.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/solidarity.dart';
import 'package:act_cms/domain/repository/admin_solidarity_repository.dart';
import 'package:multiple_result/src/result.dart';

class AdminSolidarityRepositoryImpl implements AdminSolidarityRepository {
  final ApiDataSource dataSource;

  const AdminSolidarityRepositoryImpl({required this.dataSource});

  @override
  Future<Result<void, Exception>> setLeader(int solidarityId, int solidarityApplicantId) async {
    final data = {'solidarityApplicantId': solidarityApplicantId};
    return safeCall<void>(dataSource.setAdminSolidarityLeader(solidarityId, data));
  }

  @override
  Future<Result<void, Exception>> setCorporationLeader(int solidarityId, int userId) async {
    final data = {'userId': userId};
    return safeCall<void>(dataSource.setAdminSolidarityCorporationLeader(solidarityId, data));
  }

  @override
  Future<Result<void, Exception>> withdrawLeaderApplicant(String stockCode, int solidarityApplicantId, String reason) {
    final data = {'reason': reason};
    return safeCall<void>(dataSource.withdrawSolidarityLeaderApplicant(stockCode, solidarityApplicantId, data));
  }

  @override
  Future<Result<void, Exception>> deleteSolidarityLeader(int solidarityId, int solidarityLeaderId) {
    final data = {'solidarityLeaderId': solidarityLeaderId};
    return safeCall<void>(dataSource.unsetAdminSolidarityLeader(solidarityId, data));
  }

  @override
  Future<Result<Solidarity, Exception>> setActive(int solidarityId) async {
    final res = await safeCall<DataResponse<Solidarity>>(dataSource.setAdminSolidarityActive(solidarityId));
    final result = res.tryGetSuccess()?.data;
    return (res.isSuccess() && result != null) ? Result.success(result) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<void, Exception>> updateLeaderComment(int solidarityId, String message) {
    final data = {'message': message};
    return safeCall<void>(dataSource.updateAdminSolidarityLeaderComment(solidarityId, data));
  }
}
