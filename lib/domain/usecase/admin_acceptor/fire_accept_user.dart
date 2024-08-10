import 'package:act_cms/domain/repository/admin_acceptor_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class FireAcceptUser {
  final AdminAcceptorRepository repository;

  const FireAcceptUser({required this.repository});

  Future<Result<void, Exception>> call({required String code, required int userId}) {
    return repository.fireAcceptUser(code: code, userId: userId);
  }
}
