import 'package:act_web/domain/model/user/anonymous_write_count.dart';
import 'package:act_web/domain/repository/user_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetAnonymousWriteCount {
  final UserRepository repository;
  const GetAnonymousWriteCount({required this.repository});

  Future<Result<AnonymousWriteCount, Exception>> call() {
    return repository.getAnonymousWriteCount();
  }
}
