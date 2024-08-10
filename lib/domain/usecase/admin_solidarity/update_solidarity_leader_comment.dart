import 'package:act_cms/domain/repository/admin_solidarity_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UpdateSolidarityLeaderComment {
  final AdminSolidarityRepository repository;

  const UpdateSolidarityLeaderComment({required this.repository});

  Future<Result<void, Exception>> call({required int solidarityId, required String message}) {
    return repository.updateLeaderComment(solidarityId, message);
  }
}
