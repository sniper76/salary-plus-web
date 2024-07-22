import 'package:json_annotation/json_annotation.dart';

enum SearchRankingType {
  @JsonValue('SEARCH_TREND_STOCK')
  serachTrendRanking('Search_HotRanking', 'assets/images/ic_fire.svg'),
  @JsonValue('STAKE_RANKING_STOCK')
  stakeRanking('Search_ShareRanking', 'assets/images/ic_trophy.svg'),
  @JsonValue('')
  none('', 'assets/images/ic_fire.svg'),
  ;

  final String eventName;
  final String assetPath;

  const SearchRankingType(
    this.eventName,
    this.assetPath,
  );
}
