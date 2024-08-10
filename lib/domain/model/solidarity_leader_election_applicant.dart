import 'package:json_annotation/json_annotation.dart';

part 'solidarity_leader_election_applicant.g.dart';

@JsonSerializable()
class SolidarityLeaderElectionApplicant {
  final int solidarityLeaderApplicantId;
  final String nickname;
  final int totalVoteStockQuantity;
  final List<SolidarityLeaderElectionPollItem> pollItemGroups;
  final SolidarityLeaderElectionCondition finishedEarlyCondition;
  final SolidarityLeaderElectionCondition resolutionCondition;

  const SolidarityLeaderElectionApplicant({
    required this.solidarityLeaderApplicantId,
    required this.nickname,
    required this.totalVoteStockQuantity,
    required this.pollItemGroups,
    required this.finishedEarlyCondition,
    required this.resolutionCondition,
  });

  factory SolidarityLeaderElectionApplicant.fromJson(Map<String, dynamic> json) =>
      _$SolidarityLeaderElectionApplicantFromJson(json);

  Map<String, dynamic> toJson() => _$SolidarityLeaderElectionApplicantToJson(this);
}

@JsonSerializable()
class SolidarityLeaderElectionPollItem {
  final int pollItemId;
  final bool isVoted;
  final String title;
  final int voteCount;
  final int stockQuantity;

  const SolidarityLeaderElectionPollItem({
    required this.pollItemId,
    required this.isVoted,
    required this.title,
    required this.voteCount,
    required this.stockQuantity,
  });

  factory SolidarityLeaderElectionPollItem.fromJson(Map<String, dynamic> json) =>
      _$SolidarityLeaderElectionPollItemFromJson(json);

  Map<String, dynamic> toJson() => _$SolidarityLeaderElectionPollItemToJson(this);
}

@JsonSerializable()
class SolidarityLeaderElectionCondition {
  final int stockQuantity;
  final String label;
  final String unit;
  final String valueText;
  final String color;

  const SolidarityLeaderElectionCondition({
    required this.stockQuantity,
    required this.label,
    required this.unit,
    required this.valueText,
    required this.color,
  });

  factory SolidarityLeaderElectionCondition.fromJson(Map<String, dynamic> json) =>
      _$SolidarityLeaderElectionConditionFromJson(json);

  Map<String, dynamic> toJson() => _$SolidarityLeaderElectionConditionToJson(this);
}
