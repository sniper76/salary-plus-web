import 'package:act_web/core/util/helper.dart';
import 'package:act_web/data/datasource/remote/api_datasource.dart';
import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/model/user/succeeded_web_verification.dart';
import 'package:act_web/domain/model/user/user.dart';
import 'package:act_web/domain/model/user/web_verification.dart';
import 'package:act_web/domain/repository/auth_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiDataSource remoteDataSource;
  final ApiDataSource remoteDataSourceForPolling;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.remoteDataSourceForPolling,
  });

  @override
  Future<Result<WebVerification, Exception>> createWebVerification({required String authenticationReference}) {
    return safeCall<WebVerification>(
      remoteDataSource.createWebVerification({
        'authenticationReference': authenticationReference,
      }),
    );
  }

  @override
  Future<Result<SucceededWebVerification, Exception>> verifyWebVerification({
    required String authenticationReference,
    required String verificationCode,
  }) {
    return safeCall<SucceededWebVerification>(
      remoteDataSourceForPolling.verifyWebVerification({
        'authenticationReference': authenticationReference,
        'verificationCode': verificationCode,
      }),
    );
  }

  @override
  Future<Result<User, Exception>> fetchUserMe() async {
    final res = await safeCall<DataResponse<User>>(remoteDataSource.fetchUserMe());
    final data = res.tryGetSuccess()?.data;
    return (res.isSuccess() && data != null) ? Result.success(data) : Result.error(res.tryGetError()!);
  }
}
