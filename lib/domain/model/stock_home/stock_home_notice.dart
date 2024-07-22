import 'package:act_web/domain/enum/notice_level.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_home_notice.freezed.dart';
part 'stock_home_notice.g.dart';

@freezed
class StockHomeNotice with _$StockHomeNotice {
  const factory StockHomeNotice({
    required NoticeLevel noticeLevel,
    required String message,
  }) = _StockHomeNotice;

  factory StockHomeNotice.fromJson(Map<String, dynamic> json) => _$StockHomeNoticeFromJson(json);
}
