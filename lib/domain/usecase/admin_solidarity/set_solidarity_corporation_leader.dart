import 'package:act_cms/domain/repository/admin_solidarity_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class SetSolidarityCorporationLeader {
  final AdminSolidarityRepository repository;

  const SetSolidarityCorporationLeader({required this.repository});

  Future<Result<void, Exception>> call({required int solidarityId, required int userId}) {
    return repository.setCorporationLeader(solidarityId, userId);
  }
}
