import 'package:act_web/domain/model/stock_home/dashboard/dashboard_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard.freezed.dart';
part 'dashboard.g.dart';

@freezed
class Dashboard with _$Dashboard {
  const factory Dashboard({
    String? descriptionLabel,
    @Default([]) List<DashboardItem> items,
  }) = _Dashboard;

  factory Dashboard.fromJson(Map<String, dynamic> json) => _$DashboardFromJson(json);
}
