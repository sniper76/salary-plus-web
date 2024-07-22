import 'package:act_web/domain/enum/search_type.dart';
import 'package:act_web/domain/model/stock/stock.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_ranking.freezed.dart';
part 'search_ranking.g.dart';

@freezed
class SearchRanking with _$SearchRanking {
  const factory SearchRanking({
    String? title,
    String? baseDateTime,
    List<Stock>? stocks,
    SearchRankingType? type,
  }) = _SearchRanking;

  factory SearchRanking.fromJson(Map<String, dynamic> json) => _$SearchRankingFromJson(json);
}
