// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockHome _$StockHomeFromJson(Map<String, dynamic> json) => StockHome(
      dashboard: json['dashboard'] == null
          ? null
          : Dashboard.fromJson(json['dashboard'] as Map<String, dynamic>),
      leader: json['leader'] == null
          ? null
          : Leader.fromJson(json['leader'] as Map<String, dynamic>),
      sections: (json['sections'] as List<dynamic>)
          .map((e) => Section.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StockHomeToJson(StockHome instance) => <String, dynamic>{
      'dashboard': instance.dashboard,
      'leader': instance.leader,
      'sections': instance.sections,
    };
