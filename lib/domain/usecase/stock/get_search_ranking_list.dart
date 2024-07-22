import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/model/ranking/search_ranking.dart';
import 'package:act_web/domain/repository/stock_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetSearchRankingList {
  final StockRepository repository;

  const GetSearchRankingList({required this.repository});

  Future<Result<DataResponse<List<SearchRanking>>, Exception>> call() => repository.getSearchRankingList();
}
