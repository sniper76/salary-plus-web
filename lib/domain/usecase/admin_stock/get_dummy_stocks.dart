import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/user_stock_data.dart';
import 'package:multiple_result/multiple_result.dart';

import 'package:act_cms/domain/repository/admin_user_repository.dart';

class GetUserDummyStocks {
  final AdminUserRepository repository;

  const GetUserDummyStocks({required this.repository});

  Future<Result<DataResponse<List<UserStockData>>, Exception>> call(
      {required int userId, int? page, int? size, String? sort}) {
    {
      return repository.getDummyStocks(userId: userId, page: page, size: size, sorts: sort);
    }
  }
}
