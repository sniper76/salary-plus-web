import 'package:act_web/core/util/helper.dart';
import 'package:act_web/data/datasource/remote/api_datasource.dart';
import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/model/stock/solidarity.dart';
import 'package:act_web/domain/repository/home_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiDataSource dataSource;

  const HomeRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Result<DataResponse<List<Solidarity>>, Exception>> getMySolidarityList({
    required int page,
    required int size,
    required bool isFetchingWhole,
  }) async {
    if (isFetchingWhole) {
      return await safeCall<DataResponse<List<Solidarity>>>(dataSource.getWholeMySolidarityList(page));
    } else {
      return await safeCall<DataResponse<List<Solidarity>>>(dataSource.getPagedMySolidarityList(page, size));
    }
  }

  @override
  Future<Result<List<Solidarity>, Exception>> updateMySolidarityDisplayOrder(List<String> orderedStockCodes) async {
    final data = {
      'data': orderedStockCodes,
    };
    final res = await safeCall<DataResponse<List<Solidarity>>>(dataSource.updateMySolidarityDisplayOrder(data));
    return res.isSuccess() ? Result.success(res.tryGetSuccess()?.data ?? []) : Result.error(res.tryGetError()!);
  }
}
