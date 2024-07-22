import 'package:act_web/domain/enum/ranking_sort_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ranking_stock.freezed.dart';
part 'ranking_stock.g.dart';

@freezed
class RankingStock with _$RankingStock {
  const RankingStock._();

  const factory RankingStock({
    required String stockCode,
    required String stockName,
    @JsonKey(name: 'stake') required String stakeString,
    @JsonKey(name: 'marketValue') required String marketValueString,
    required int stakeRank,
    required int stakeRankDelta,
    required int marketValueRank,
    required int marketValueRankDelta,
  }) = _RankingStock;

  factory RankingStock.fromJson(Map<String, dynamic> json) => _$RankingStockFromJson(json);
}

extension RankingStockExtension on RankingStock {
  String getMainString(RankingSortType sortType) {
    switch (sortType) {
      case RankingSortType.stakeAsc:
        return stakeString;
      case RankingSortType.marketValueAsc:
        return marketValueString;
    }
  }

  String getSubString(RankingSortType sortType) {
    switch (sortType) {
      case RankingSortType.stakeAsc:
        return marketValueString;
      case RankingSortType.marketValueAsc:
        return stakeString;
    }
  }
}
