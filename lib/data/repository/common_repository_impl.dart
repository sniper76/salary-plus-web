import 'package:act_web/core/service/user_auth_service.dart';
import 'package:act_web/core/util/helper.dart';
import 'package:act_web/data/datasource/remote/api_datasource.dart';
import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/model/stock/base_stock.dart';
import 'package:act_web/domain/repository/common_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class CommonRepositoryImpl implements CommonRepository {
  final UserAuthService authService;
  final ApiDataSource dataSource;

  CommonRepositoryImpl({
    required this.authService,
    required this.dataSource,
  });
  @override
  @override
  Future<Result<List<BaseStock>, Exception>> getCommonStocks() async {
    if (authService.hasAccessToken()) {
      final res = await safeCall<DataResponse<List<BaseStock>>>(dataSource.getCommonStocks());
      final stockResult = res.tryGetSuccess()?.data;
      return res.isSuccess() ? Result.success(stockResult ?? []) : Result.error(res.tryGetError()!);
    }
    return Result.error(Exception('Access token denied'));
  }

  @override
  Future<Result<void, Exception>> postStockSearchTrend({required String stockCode}) {
    return safeCall<void>(dataSource.postStockSearchTrend(stockCode));
  }
}
