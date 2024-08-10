import 'package:act_cms/core/service/cms_commons_service.dart';
import 'package:act_cms/domain/model/cms_commons.dart';
import 'package:act_cms/domain/repository/admin_cms_commons_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetCMSCommons {
  final CMSCommonsService cmsCommonsService;
  final AdminCMSCommonsRepository repository;

  const GetCMSCommons({required this.cmsCommonsService, required this.repository});

  Future<Result<CMSCommons, Exception>> call() async {
    final result = await repository.getCommons();
    if (result.isSuccess() && result.tryGetSuccess() != null) {
      cmsCommonsService.setCMSCommons(result.tryGetSuccess()!);
    }
    return result;
  }
}
