import 'package:json_annotation/json_annotation.dart';

part 'poll_item.g.dart';

@JsonSerializable()
class PollItem {
  final int id;
  final String text;
  @JsonKey(name: 'voteItemCount')
  final int voteCount;
  @JsonKey(name: 'voteItemStockSum')
  final int stockSum;

  const PollItem({
    required this.id,
    required this.text,
    this.voteCount = 0,
    this.stockSum = 0,
  });

  factory PollItem.fromJson(Map<String, dynamic> json) => _$PollItemFromJson(json);

  Map<String, dynamic> toJson() => _$PollItemToJson(this);
}
