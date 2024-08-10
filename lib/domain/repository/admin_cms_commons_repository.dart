import 'package:act_cms/domain/model/cms_commons.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AdminCMSCommonsRepository {
  Future<Result<CMSCommons, Exception>> getCommons();
}
