import 'package:act_cms/domain/model/solidarity_election_winner.dart';
import 'package:act_cms/domain/model/solidarity_leader_election_candidate.dart';
import 'package:act_cms/domain/model/solidarity_leader_election_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'solidarity_election_result.g.dart';

@JsonSerializable()
class SolidarityElectionResult {
  final SolidarityElectionWinner? winner;
  final List<SolidarityLeaderElectionCandidate> applicants;
  final SolidarityLeaderElectionDetail electionDetail;

  const SolidarityElectionResult({
    required this.winner,
    required this.applicants,
    required this.electionDetail,
  });

  factory SolidarityElectionResult.fromJson(Map<String, dynamic> json) => _$SolidarityElectionResultFromJson(json);

  Map<String, dynamic> toJson() => _$SolidarityElectionResultToJson(this);
}
