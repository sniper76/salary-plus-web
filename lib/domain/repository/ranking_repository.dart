import 'package:salary_plus_web/data/response/data_response.dart';
import 'package:salary_plus_web/domain/model/ranking/ranking_stock.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class RankingRepository {
  Future<Result<DataResponse<List<RankingStock>>, Exception>> getRankingStockList(String sort, int size);
}
