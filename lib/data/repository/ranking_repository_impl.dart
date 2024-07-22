import 'package:act_web/core/util/helper.dart';
import 'package:act_web/data/datasource/local/local_storage_datasource.dart';
import 'package:act_web/data/datasource/remote/api_datasource.dart';
import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/model/ranking/ranking_stock.dart';
import 'package:act_web/domain/repository/ranking_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class RankingRepositoryImpl implements RankingRepository {
  final ApiDataSource remoteDataSource;
  final LocalStorageDataSource localDataSource;

  const RankingRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<DataResponse<List<RankingStock>>, Exception>> getRankingStockList(String sorts, int size) async {
    DateTime? lastCacheTime = await localDataSource.getLastRankingStockListCacheTime(sorts);
    try {
      if (lastCacheTime != null && DateTime.now().difference(lastCacheTime).inMinutes <= 30) {
        final List<RankingStock>? localRankingStockList =
            await localDataSource.readRankingStockListFromLocalStorage(sorts);
        return Success(DataResponse(data: localRankingStockList));
      } else {
        final Result<DataResponse<List<RankingStock>>, Exception> result =
            await safeCall<DataResponse<List<RankingStock>>>(remoteDataSource.getRankingStockList(sorts, size));

        if (result.isSuccess() && result.tryGetSuccess()?.data != null) {
          await localDataSource.saveRankingStockListToLocalStorage(result.tryGetSuccess()!.data!, sorts);
        } else {
          localDataSource.removeRankingStockListFromLocalStorage(sorts);
        }

        return result;
      }
    } catch (e) {
      final Result<DataResponse<List<RankingStock>>, Exception> result =
          await safeCall<DataResponse<List<RankingStock>>>(remoteDataSource.getRankingStockList(sorts, size));

      if (result.isSuccess() && result.tryGetSuccess()?.data != null) {
        await localDataSource.saveRankingStockListToLocalStorage(result.tryGetSuccess()!.data!, sorts);
      } else {
        localDataSource.removeRankingStockListFromLocalStorage(sorts);
      }

      return result;
    }
  }
}
