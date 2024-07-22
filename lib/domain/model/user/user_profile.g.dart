// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      nickname: json['nickname'] as String,
      isSolidarityLeader: json['isSolidarityLeader'] as bool,
      profileImageUrl: json['profileImageUrl'] as String?,
      individualStockCountLabel: json['individualStockCountLabel'] as String?,
      totalAssetLabel: json['totalAssetLabel'] as String?,
      leadingStocks: (json['leadingStocks'] as List<dynamic>?)
          ?.map((e) => LeadingStock.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'isSolidarityLeader': instance.isSolidarityLeader,
      'profileImageUrl': instance.profileImageUrl,
      'individualStockCountLabel': instance.individualStockCountLabel,
      'totalAssetLabel': instance.totalAssetLabel,
      'leadingStocks': instance.leadingStocks,
    };
