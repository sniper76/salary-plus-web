import 'package:act_cms/domain/repository/admin_solidarity_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class SetSolidarlityLeader {
  final AdminSolidarityRepository repository;

  const SetSolidarlityLeader({required this.repository});

  Future<Result<void, Exception>> call({required int solidarityId, required int solidarityApplicantId}) {
    return repository.setLeader(solidarityId, solidarityApplicantId);
  }
}
