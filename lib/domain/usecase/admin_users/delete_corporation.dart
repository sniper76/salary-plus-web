import 'package:act_cms/domain/repository/admin_user_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class DeleteCorporation {
  final AdminUserRepository repository;

  const DeleteCorporation({required this.repository});

  Future<Result<void, Exception>> call({required int corporationId}) {
    return repository.deleteCorporation(corporationId: corporationId);
  }
}
