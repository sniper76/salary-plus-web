import 'package:act_cms/domain/model/solidarity_leader_election_application.dart';
import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetSolidarityLeaderElectionApplcation {
  final AdminStockRepository repository;

  const GetSolidarityLeaderElectionApplcation({required this.repository});

  Future<Result<SolidarityLeaderElectionApplication, Exception>> call({
    required String stockCode,
    required int solidarityLeaderElectionId,
    required int solidarityApplicantId,
  }) {
    return repository.getSolidarityLeaderElectionApplcation(
      stockCode: stockCode,
      solidarityLeaderElectionId: solidarityLeaderElectionId,
      solidarityApplicantId: solidarityApplicantId,
    );
  }
}
