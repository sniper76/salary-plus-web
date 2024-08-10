import 'package:act_cms/domain/model/digital_document_accept_user.dart';
import 'package:act_cms/domain/model/solidarity.dart';
import 'package:act_cms/domain/model/solidarity_leader.dart';
import 'package:act_cms/domain/model/solidarity_leader_applicant.dart';
import 'package:act_cms/domain/model/today_delta.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_detail.g.dart';

@JsonSerializable()
class StockDetail extends Equatable {
  final Solidarity? solidarity;
  final TodayDelta? todayDelta;
  final SolidarityLeader? solidarityLeader;
  final List<SolidarityLeaderApplicant>? solidarityLeaderApplicants;
  final DigitalDocumentAcceptUser? acceptUser;

  const StockDetail({
    this.solidarity,
    this.todayDelta,
    this.solidarityLeader,
    this.solidarityLeaderApplicants,
    this.acceptUser,
  });

  factory StockDetail.fromJson(Map<String, dynamic> json) => _$StockDetailFromJson(json);

  Map<String, dynamic> toJson() => _$StockDetailToJson(this);

  @override
  List<Object?> get props => [solidarity, todayDelta, solidarityLeader, solidarityLeaderApplicants, acceptUser];
}
