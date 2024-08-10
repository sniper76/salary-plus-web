import 'package:json_annotation/json_annotation.dart';

part 'solidarity_election_winner.g.dart';

@JsonSerializable()
class SolidarityElectionWinner {
  final bool isElected;
  final String? nickname;

  const SolidarityElectionWinner({
    required this.isElected,
    required this.nickname,
  });

  factory SolidarityElectionWinner.fromJson(Map<String, dynamic> json) => _$SolidarityElectionWinnerFromJson(json);

  Map<String, dynamic> toJson() => _$SolidarityElectionWinnerToJson(this);
}
