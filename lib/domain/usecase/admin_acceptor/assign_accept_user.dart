import 'package:act_cms/domain/repository/admin_acceptor_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class AssignAcceptUser {
  final AdminAcceptorRepository repository;

  const AssignAcceptUser({required this.repository});

  Future<Result<void, Exception>> call({required String code, required int userId}) {
    return repository.assignAcceptUser(code: code, userId: userId);
  }
}
