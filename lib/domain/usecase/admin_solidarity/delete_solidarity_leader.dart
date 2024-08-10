import 'package:act_cms/domain/repository/admin_solidarity_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class DeleteSolidarityLeader {
  final AdminSolidarityRepository repository;

  const DeleteSolidarityLeader({required this.repository});

  Future<Result<void, Exception>> call({required int solidarityId, required int solidarityLeaderId}) {
    return repository.deleteSolidarityLeader(solidarityId, solidarityLeaderId);
  }
}
