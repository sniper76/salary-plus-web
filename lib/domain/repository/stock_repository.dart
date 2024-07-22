import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/model/ranking/search_ranking.dart';
import 'package:act_web/domain/model/stock_home/stock_home.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class StockRepository {
  Future<Result<DataResponse<List<SearchRanking>>, Exception>> getSearchRankingList();

  Future<Result<StockHome, Exception>> getStockHome(String stockCode);

  Future<Result<void, Exception>> updateSolidarityLeaderMessage({
    required String stockCode,
    required int solidarityId,
    required String message,
  });
}
