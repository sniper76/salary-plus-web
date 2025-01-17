// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_ranking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchRankingImpl _$$SearchRankingImplFromJson(Map<String, dynamic> json) =>
    _$SearchRankingImpl(
      title: json['title'] as String?,
      baseDateTime: json['baseDateTime'] as String?,
      stocks: (json['stocks'] as List<dynamic>?)
          ?.map((e) => Stock.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: $enumDecodeNullable(_$SearchRankingTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$SearchRankingImplToJson(_$SearchRankingImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'baseDateTime': instance.baseDateTime,
      'stocks': instance.stocks,
      'type': _$SearchRankingTypeEnumMap[instance.type],
    };

const _$SearchRankingTypeEnumMap = {
  SearchRankingType.serachTrendRanking: 'SEARCH_TREND_STOCK',
  SearchRankingType.stakeRanking: 'STAKE_RANKING_STOCK',
  SearchRankingType.none: '',
};
