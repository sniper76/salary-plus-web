import 'package:act_cms/domain/model/solidarity_leader_election_applicant.dart';
import 'package:json_annotation/json_annotation.dart';

part 'solidarity_leader_election_detail.g.dart';

@JsonSerializable()
class SolidarityLeaderElectionDetail {
  final int solidarityLeaderElectionId;
  final String status;
  final int totalVoterCount;
  final bool isVoted;
  final List<SolidarityLeaderElectionApplicant> pollApplicants;

  const SolidarityLeaderElectionDetail({
    required this.solidarityLeaderElectionId,
    required this.status,
    required this.totalVoterCount,
    required this.isVoted,
    required this.pollApplicants,
  });

  factory SolidarityLeaderElectionDetail.fromJson(Map<String, dynamic> json) =>
      _$SolidarityLeaderElectionDetailFromJson(json);

  Map<String, dynamic> toJson() => _$SolidarityLeaderElectionDetailToJson(this);
}
