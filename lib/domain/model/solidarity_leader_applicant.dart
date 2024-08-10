import 'package:act_cms/domain/model/enum/user_status_type.dart';
import 'package:act_cms/domain/model/simple_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'solidarity_leader_applicant.g.dart';

@JsonSerializable()
class SolidarityLeaderApplicant extends SimpleUser {
  final int solidarityApplicantId;

  const SolidarityLeaderApplicant({
    required int id,
    String? email,
    required String name,
    DateTime? birthDate,
    required String phoneNumber,
    String? gender,
    String? nickname,
    UserStatusType status = UserStatusType.unknown,
    required this.solidarityApplicantId,
  }) : super(
          id: id,
          email: email,
          name: name,
          birthDate: birthDate,
          phoneNumber: phoneNumber,
          gender: gender,
          nickname: nickname,
          status: status,
        );

  factory SolidarityLeaderApplicant.fromJson(Map<String, dynamic> json) => _$SolidarityLeaderApplicantFromJson(json);

  Map<String, dynamic> toJson() => _$SolidarityLeaderApplicantToJson(this);
}
