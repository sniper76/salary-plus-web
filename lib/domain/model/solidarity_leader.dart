import 'package:act_cms/domain/model/enum/user_status_type.dart';
import 'package:act_cms/domain/model/simple_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'solidarity_leader.g.dart';

@JsonSerializable()
class SolidarityLeader extends SimpleUser {
  final String? message;
  final int solidarityId;
  final int solidarityLeaderId;
  final int userId;
  final String? corporateNo;

  const SolidarityLeader({
    required this.userId,
    String? email,
    required String name,
    DateTime? birthDate,
    required String phoneNumber,
    String? gender,
    String? nickname,
    UserStatusType status = UserStatusType.unknown,
    this.message,
    this.corporateNo,
    required this.solidarityId,
    required this.solidarityLeaderId,
  }) : super(
          id: userId,
          email: email,
          name: name,
          birthDate: birthDate,
          phoneNumber: phoneNumber,
          gender: gender,
          nickname: nickname,
          status: status,
        );

  factory SolidarityLeader.fromJson(Map<String, dynamic> json) => _$SolidarityLeaderFromJson(json);

  Map<String, dynamic> toJson() => _$SolidarityLeaderToJson(this);
}
