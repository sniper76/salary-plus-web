// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solidarity_leader_election_candidate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolidarityLeaderElectionCandidate _$SolidarityLeaderElectionCandidateFromJson(
        Map<String, dynamic> json) =>
    SolidarityLeaderElectionCandidate(
      id: (json['id'] as num).toInt(),
      nickname: json['nickname'] as String,
      individualStockCountLabel: json['individualStockCountLabel'] as String,
      solidarityApplicantId: (json['solidarityApplicantId'] as num).toInt(),
      profileImageUrl: json['profileImageUrl'] as String?,
    );

Map<String, dynamic> _$SolidarityLeaderElectionCandidateToJson(
        SolidarityLeaderElectionCandidate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'profileImageUrl': instance.profileImageUrl,
      'individualStockCountLabel': instance.individualStockCountLabel,
      'solidarityApplicantId': instance.solidarityApplicantId,
    };
