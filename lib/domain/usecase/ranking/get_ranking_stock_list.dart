import 'package:salary_plus_web/data/response/data_response.dart';
import 'package:salary_plus_web/domain/model/ranking/ranking_stock.dart';
import 'package:salary_plus_web/domain/repository/ranking_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetRankingStockList {
  final RankingRepository repository;
  const GetRankingStockList({required this.repository});

  Future<Result<DataResponse<List<RankingStock>>, Exception>> call({required String sorts, int size = 50}) =>
      repository.getRankingStockList(sorts, size);
}
