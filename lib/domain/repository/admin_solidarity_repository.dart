import 'package:act_cms/domain/model/solidarity.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AdminSolidarityRepository {
  // Future<Result<List<User>, Exception>> getApplicants(int solidarityId);
  Future<Result<void, Exception>> setLeader(int solidarityId, int solidarityApplicantId);

  Future<Result<void, Exception>> setCorporationLeader(int solidarityId, int userId);

  Future<Result<void, Exception>> withdrawLeaderApplicant(String stockCode, int solidarityApplicantId, String reason);

  Future<Result<void, Exception>> deleteSolidarityLeader(int solidarityId, int solidarityLeaderId);

  Future<Result<Solidarity, Exception>> setActive(int solidarityId);

  Future<Result<void, Exception>> updateLeaderComment(int solidarityId, String message);
}
