// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockDetail _$StockDetailFromJson(Map<String, dynamic> json) => StockDetail(
      solidarity: json['solidarity'] == null
          ? null
          : Solidarity.fromJson(json['solidarity'] as Map<String, dynamic>),
      todayDelta: json['todayDelta'] == null
          ? null
          : TodayDelta.fromJson(json['todayDelta'] as Map<String, dynamic>),
      solidarityLeader: json['solidarityLeader'] == null
          ? null
          : SolidarityLeader.fromJson(
              json['solidarityLeader'] as Map<String, dynamic>),
      solidarityLeaderApplicants:
          (json['solidarityLeaderApplicants'] as List<dynamic>?)
              ?.map((e) =>
                  SolidarityLeaderApplicant.fromJson(e as Map<String, dynamic>))
              .toList(),
      acceptUser: json['acceptUser'] == null
          ? null
          : DigitalDocumentAcceptUser.fromJson(
              json['acceptUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockDetailToJson(StockDetail instance) =>
    <String, dynamic>{
      'solidarity': instance.solidarity,
      'todayDelta': instance.todayDelta,
      'solidarityLeader': instance.solidarityLeader,
      'solidarityLeaderApplicants': instance.solidarityLeaderApplicants,
      'acceptUser': instance.acceptUser,
    };
