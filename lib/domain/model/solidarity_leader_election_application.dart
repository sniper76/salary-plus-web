import 'package:json_annotation/json_annotation.dart';

part 'solidarity_leader_election_application.g.dart';

@JsonSerializable()
class SolidarityLeaderElectionApplication {
  final String reasonsForApply;
  final String knowledgeOfCompanyManagement;
  final String goals;
  final String commentsForStockHolder;

  const SolidarityLeaderElectionApplication({
    required this.reasonsForApply,
    required this.knowledgeOfCompanyManagement,
    required this.goals,
    required this.commentsForStockHolder,
  });

  factory SolidarityLeaderElectionApplication.fromJson(Map<String, dynamic> json) =>
      _$SolidarityLeaderElectionApplicationFromJson(json);

  Map<String, dynamic> toJson() => _$SolidarityLeaderElectionApplicationToJson(this);
}
