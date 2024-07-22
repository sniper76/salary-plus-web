import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/model/stock/solidarity.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class HomeRepository {
  Future<Result<DataResponse<List<Solidarity>>, Exception>> getMySolidarityList({
    required int page,
    required int size,
    required bool isFetchingWhole,
  });

  Future<Result<List<Solidarity>, Exception>> updateMySolidarityDisplayOrder(List<String> orderedStockCodes);
}
