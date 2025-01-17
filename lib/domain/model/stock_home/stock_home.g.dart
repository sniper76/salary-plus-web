// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StockHomeImpl _$$StockHomeImplFromJson(Map<String, dynamic> json) =>
    _$StockHomeImpl(
      sections: (json['sections'] as List<dynamic>)
          .map((e) => Section.fromJson(e as Map<String, dynamic>))
          .toList(),
      dashboard: json['dashboard'] == null
          ? null
          : Dashboard.fromJson(json['dashboard'] as Map<String, dynamic>),
      leader: json['leader'] == null
          ? null
          : SolidarityLeader.fromJson(json['leader'] as Map<String, dynamic>),
      notices: (json['notices'] as List<dynamic>?)
          ?.map((e) => StockHomeNotice.fromJson(e as Map<String, dynamic>))
          .toList(),
      leaderElectionDetail: json['leaderElectionDetail'] == null
          ? null
          : LeaderElectionDetail.fromJson(
              json['leaderElectionDetail'] as Map<String, dynamic>),
      stock: json['stock'] == null
          ? null
          : Stock.fromJson(json['stock'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StockHomeImplToJson(_$StockHomeImpl instance) =>
    <String, dynamic>{
      'sections': instance.sections,
      'dashboard': instance.dashboard,
      'leader': instance.leader,
      'notices': instance.notices,
      'leaderElectionDetail': instance.leaderElectionDetail,
      'stock': instance.stock,
    };
