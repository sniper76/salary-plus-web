import 'package:act_web/domain/model/stock/stock.dart';
import 'package:act_web/domain/model/stock_home/dashboard/dashboard.dart';
import 'package:act_web/domain/model/stock_home/leader_election_detail.dart';
import 'package:act_web/domain/model/stock_home/section/section.dart';
import 'package:act_web/domain/model/stock_home/solidarity_leader.dart';
import 'package:act_web/domain/model/stock_home/stock_home_notice.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_home.freezed.dart';
part 'stock_home.g.dart';

@freezed
class StockHome with _$StockHome {
  const factory StockHome({
    required List<Section> sections,
    Dashboard? dashboard,
    SolidarityLeader? leader,
    List<StockHomeNotice>? notices,
    LeaderElectionDetail? leaderElectionDetail,
    Stock? stock,
  }) = _StockHome;

  factory StockHome.fromJson(Map<String, dynamic> json) => _$StockHomeFromJson(json);
}
