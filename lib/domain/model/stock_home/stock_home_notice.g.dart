// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_home_notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StockHomeNoticeImpl _$$StockHomeNoticeImplFromJson(
        Map<String, dynamic> json) =>
    _$StockHomeNoticeImpl(
      noticeLevel: $enumDecode(_$NoticeLevelEnumMap, json['noticeLevel']),
      message: json['message'] as String,
    );

Map<String, dynamic> _$$StockHomeNoticeImplToJson(
        _$StockHomeNoticeImpl instance) =>
    <String, dynamic>{
      'noticeLevel': _$NoticeLevelEnumMap[instance.noticeLevel]!,
      'message': instance.message,
    };

const _$NoticeLevelEnumMap = {
  NoticeLevel.info: 'INFO',
  NoticeLevel.warning: 'WARNING',
  NoticeLevel.critical: 'CRITICAL',
};
