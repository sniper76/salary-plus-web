// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solidarity_leader_election_application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolidarityLeaderElectionApplication
    _$SolidarityLeaderElectionApplicationFromJson(Map<String, dynamic> json) =>
        SolidarityLeaderElectionApplication(
          reasonsForApply: json['reasonsForApply'] as String,
          knowledgeOfCompanyManagement:
              json['knowledgeOfCompanyManagement'] as String,
          goals: json['goals'] as String,
          commentsForStockHolder: json['commentsForStockHolder'] as String,
        );

Map<String, dynamic> _$SolidarityLeaderElectionApplicationToJson(
        SolidarityLeaderElectionApplication instance) =>
    <String, dynamic>{
      'reasonsForApply': instance.reasonsForApply,
      'knowledgeOfCompanyManagement': instance.knowledgeOfCompanyManagement,
      'goals': instance.goals,
      'commentsForStockHolder': instance.commentsForStockHolder,
    };
