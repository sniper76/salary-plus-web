import 'package:act_cms/domain/repository/admin_solidarity_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class WithdrawSolidarlityLeaderApplicant {
  final AdminSolidarityRepository repository;

  const WithdrawSolidarlityLeaderApplicant({required this.repository});

  Future<Result<void, Exception>> call(
      {required String stockCode, required int solidarityApplicantId, required String reason}) {
    return repository.withdrawLeaderApplicant(stockCode, solidarityApplicantId, reason);
  }
}
