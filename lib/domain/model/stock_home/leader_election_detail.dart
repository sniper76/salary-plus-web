import 'package:act_web/core/extension/datetime_extension.dart';
import 'package:act_web/domain/enum/election_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'leader_election_detail.freezed.dart';
part 'leader_election_detail.g.dart';

@freezed
class LeaderElectionDetail with _$LeaderElectionDetail {
  const LeaderElectionDetail._();

  const factory LeaderElectionDetail({
    required int solidarityLeaderElectionId,
    required ElectionStatus electionStatus,
    required DateTime startDate,
    required DateTime endDate,
  }) = _LeaderElectionDetail;

  factory LeaderElectionDetail.fromJson(Map<String, dynamic> json) => _$LeaderElectionDetailFromJson(json);
}

extension LeaderElectionDetailExtension on LeaderElectionDetail {
  String get getElectionPeriodString {
    return '${startDate.toFormatString(pattern: 'yyyy.MM.dd')} ~ ${endDate.toFormatString(pattern: 'yyyy.MM.dd')}';
  }
}
