// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RankingStockImpl _$$RankingStockImplFromJson(Map<String, dynamic> json) =>
    _$RankingStockImpl(
      stockCode: json['stockCode'] as String,
      stockName: json['stockName'] as String,
      stakeString: json['stake'] as String,
      marketValueString: json['marketValue'] as String,
      stakeRank: (json['stakeRank'] as num).toInt(),
      stakeRankDelta: (json['stakeRankDelta'] as num).toInt(),
      marketValueRank: (json['marketValueRank'] as num).toInt(),
      marketValueRankDelta: (json['marketValueRankDelta'] as num).toInt(),
    );

Map<String, dynamic> _$$RankingStockImplToJson(_$RankingStockImpl instance) =>
    <String, dynamic>{
      'stockCode': instance.stockCode,
      'stockName': instance.stockName,
      'stake': instance.stakeString,
      'marketValue': instance.marketValueString,
      'stakeRank': instance.stakeRank,
      'stakeRankDelta': instance.stakeRankDelta,
      'marketValueRank': instance.marketValueRank,
      'marketValueRankDelta': instance.marketValueRankDelta,
    };
