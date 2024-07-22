import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll_item.g.dart';
part 'poll_item.freezed.dart';

@freezed
class PollItem with _$PollItem {
  const factory PollItem({
    required int id,
    required String text,
    @Default(0) int voteItemCount,
    @Default(0) int voteItemStockSum,
  }) = _PollItem;

  factory PollItem.fromJson(Map<String, dynamic> json) => _$PollItemFromJson(json);
}
