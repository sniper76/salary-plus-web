import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/model/stock/solidarity.dart';
import 'package:act_web/domain/repository/home_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetMySolidarityList {
  final HomeRepository repository;

  const GetMySolidarityList({required this.repository});

  Future<Result<DataResponse<List<Solidarity>>, Exception>> call({
    int page = 1,
    int size = 10,
    bool isFetchingWhole = false,
  }) {
    return repository.getMySolidarityList(
      page: page,
      size: size,
      isFetchingWhole: isFetchingWhole,
    );
  }
}
