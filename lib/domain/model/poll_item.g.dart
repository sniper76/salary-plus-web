// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollItem _$PollItemFromJson(Map<String, dynamic> json) => PollItem(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String,
      voteCount: (json['voteItemCount'] as num?)?.toInt() ?? 0,
      stockSum: (json['voteItemStockSum'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PollItemToJson(PollItem instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'voteItemCount': instance.voteCount,
      'voteItemStockSum': instance.stockSum,
    };
