import 'package:act_web/domain/model/user/anonymous_write_count.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class UserRepository {
  Future<Result<AnonymousWriteCount, Exception>> getAnonymousWriteCount();

  Future<Result<void, Exception>> blockUser({
    required int targetUserId,
  });
}
