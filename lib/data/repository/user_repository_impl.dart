import 'package:salary_plus_web/core/util/helper.dart';
import 'package:salary_plus_web/data/datasource/remote/api_datasource.dart';
import 'package:salary_plus_web/data/response/data_response.dart';
import 'package:salary_plus_web/domain/model/user/anonymous_write_count.dart';
import 'package:salary_plus_web/domain/repository/user_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiDataSource dataSource;
  const UserRepositoryImpl({required this.dataSource});

  @override
  Future<Result<AnonymousWriteCount, Exception>> getAnonymousWriteCount() async {
    final res = await safeCall<DataResponse<AnonymousWriteCount>>(dataSource.getAnonymousWriteCount());
    final anonymousWriteCount = res.tryGetSuccess()?.data;
    return (res.isSuccess() && anonymousWriteCount != null)
        ? Result.success(anonymousWriteCount)
        : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<void, Exception>> blockUser({required int targetUserId}) async {
    final data = {'targetUserId': targetUserId};
    return await safeCall(dataSource.blockUser(data));
  }
}
