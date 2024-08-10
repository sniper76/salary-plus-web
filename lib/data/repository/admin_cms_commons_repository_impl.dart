import 'package:act_cms/core/util/helper.dart';
import 'package:act_cms/data/datasource/remote/api_datasource.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/cms_commons.dart';
import 'package:act_cms/domain/repository/admin_cms_commons_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class AdminCMSCommonsRepositoryImpl implements AdminCMSCommonsRepository {
  final ApiDataSource dataSource;

  const AdminCMSCommonsRepositoryImpl({required this.dataSource});

  @override
  Future<Result<CMSCommons, Exception>> getCommons() async {
    final res = await safeCall<DataResponse<CMSCommons>>(dataSource.getAdminCMSCommons());
    final result = res.tryGetSuccess()?.data;
    return (res.isSuccess() && result != null) ? Result.success(result) : Result.error(res.tryGetError()!);
  }
}
