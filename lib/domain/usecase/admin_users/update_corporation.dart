import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/corporation_user.dart';
import 'package:act_cms/domain/repository/admin_user_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UpdateCorporation {
  final AdminUserRepository repository;

  const UpdateCorporation({required this.repository});

  Future<Result<DataResponse<CorporationUser>, Exception>> call(
      {required String corporateNo, required String corporateName, required int corporateId}) {
    return repository.updateCorporation(
      corporateNo: corporateNo,
      corporateName: corporateName,
      corporateId: corporateId,
    );
  }
}
