import 'package:json_annotation/json_annotation.dart';

part 'solidarity_leader_election_candidate.g.dart';

@JsonSerializable()
class SolidarityLeaderElectionCandidate {
  final int id;
  final String nickname;
  final String? profileImageUrl;
  final String individualStockCountLabel;
  final int solidarityApplicantId;

  const SolidarityLeaderElectionCandidate({
    required this.id,
    required this.nickname,
    required this.individualStockCountLabel,
    required this.solidarityApplicantId,
    this.profileImageUrl,
  });

  factory SolidarityLeaderElectionCandidate.fromJson(Map<String, dynamic> json) =>
      _$SolidarityLeaderElectionCandidateFromJson(json);

  Map<String, dynamic> toJson() => _$SolidarityLeaderElectionCandidateToJson(this);
}
