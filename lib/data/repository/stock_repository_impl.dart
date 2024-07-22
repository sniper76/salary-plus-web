import 'package:act_web/core/util/helper.dart';
import 'package:act_web/data/datasource/remote/api_datasource.dart';
import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/model/ranking/search_ranking.dart';
import 'package:act_web/domain/model/stock_home/stock_home.dart';
import 'package:act_web/domain/repository/stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class StockRepositoryImpl implements StockRepository {
  final ApiDataSource dataSource;

  const StockRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Result<DataResponse<List<SearchRanking>>, Exception>> getSearchRankingList() {
    return safeCall<DataResponse<List<SearchRanking>>>(dataSource.getSearchRankingList());
  }

  @override
  Future<Result<StockHome, Exception>> getStockHome(String stockCode) {
    return safeCall<StockHome>(dataSource.getStockHome(stockCode));
  }

  @override
  Future<Result<void, Exception>> updateSolidarityLeaderMessage({
    required String stockCode,
    required int solidarityId,
    required String message,
  }) {
    final Map<String, dynamic> data = {'message': message};

    return safeCall<void>(dataSource.updateSolidarityLeaderMessage(stockCode, solidarityId, data));
  }
}
