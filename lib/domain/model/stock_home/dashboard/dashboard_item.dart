import 'package:act_web/domain/model/stock_home/dashboard/variation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_item.freezed.dart';
part 'dashboard_item.g.dart';

@freezed
class DashboardItem with _$DashboardItem {
  const factory DashboardItem({
    required String title,
    required String value,
    required Variation variation,
  }) = _DashboardItem;

  factory DashboardItem.fromJson(Map<String, dynamic> json) => _$DashboardItemFromJson(json);
}
