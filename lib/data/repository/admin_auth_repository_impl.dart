import 'package:act_cms/core/util/helper.dart';
import 'package:act_cms/data/datasource/remote/api_datasource.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/model/verify_auth.dart';
import 'package:act_cms/domain/repository/admin_auth_repository.dart';
import 'package:multiple_result/src/result.dart';

class AdminAuthRepositoryImpl implements AdminAuthRepository {
  final ApiDataSource dataSource;

  const AdminAuthRepositoryImpl({required this.dataSource});

  @override
  Future<Result<VerifyAuth, Exception>> login({required String email, required String password}) {
    final data = {'email': email, 'password': password};
    return safeCall<VerifyAuth>(dataSource.loginAdmin(data));
  }

  @override
  Future<Result<User, Exception>> changePassword(
      {required String currentPassword, required String password, required String confirmPassword}) async {
    final data = {
      'currentPassword': currentPassword,
      'password': password,
      'confirmPassword': confirmPassword,
    };

    final res = await safeCall<DataResponse<User>>(dataSource.changeAdminPassword(data));
    final result = res.tryGetSuccess()?.data;

    return (res.isSuccess() && result != null) ? Result.success(result) : Result.error(res.tryGetError()!);
  }
}
