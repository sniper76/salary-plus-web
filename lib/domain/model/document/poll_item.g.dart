// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PollItemImpl _$$PollItemImplFromJson(Map<String, dynamic> json) =>
    _$PollItemImpl(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String,
      voteItemCount: (json['voteItemCount'] as num?)?.toInt() ?? 0,
      voteItemStockSum: (json['voteItemStockSum'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PollItemImplToJson(_$PollItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'voteItemCount': instance.voteItemCount,
      'voteItemStockSum': instance.voteItemStockSum,
    };
