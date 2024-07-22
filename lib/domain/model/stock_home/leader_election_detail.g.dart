// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leader_election_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaderElectionDetailImpl _$$LeaderElectionDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaderElectionDetailImpl(
      solidarityLeaderElectionId:
          (json['solidarityLeaderElectionId'] as num).toInt(),
      electionStatus:
          $enumDecode(_$ElectionStatusEnumMap, json['electionStatus']),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$$LeaderElectionDetailImplToJson(
        _$LeaderElectionDetailImpl instance) =>
    <String, dynamic>{
      'solidarityLeaderElectionId': instance.solidarityLeaderElectionId,
      'electionStatus': _$ElectionStatusEnumMap[instance.electionStatus]!,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };

const _$ElectionStatusEnumMap = {
  ElectionStatus.candidateRegistrationPeriod: 'CANDIDATE_REGISTRATION_PERIOD',
  ElectionStatus.votePeriod: 'VOTE_PERIOD',
  ElectionStatus.finished: 'FINISHED',
};
