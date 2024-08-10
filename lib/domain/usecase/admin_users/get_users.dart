import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/repository/admin_user_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetUsers {
  final AdminUserRepository repository;

  const GetUsers({required this.repository});

  Future<Result<DataResponse<List<User>>, Exception>> call(
      {String? searchType, String? searchKeyword, int? page, int? size, String? sorts, String? filterType}) {
    return repository.get(
      searchType: searchType,
      searchKeyword: searchKeyword,
      page: page,
      size: size,
      sorts: sorts,
      filterType: filterType,
    );
  }
}
