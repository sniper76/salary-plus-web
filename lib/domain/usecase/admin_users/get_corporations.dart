import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/corporation_user.dart';
import 'package:act_cms/domain/repository/admin_user_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetCorporations {
  final AdminUserRepository repository;

  const GetCorporations({required this.repository});

  Future<Result<DataResponse<List<CorporationUser>>, Exception>> call(
      {String? searchType, String? searchKeyword, int? page, int? size, String? sorts}) {
    return repository.getCorporations(
      searchType: searchType,
      searchKeyword: searchKeyword,
      page: page,
      size: size,
      sorts: sorts,
    );
  }
}
