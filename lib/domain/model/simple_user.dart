import 'package:act_cms/domain/model/enum/user_status_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'simple_user.g.dart';

@JsonSerializable()
class SimpleUser {
  final int id;
  final String? email;
  final String name;
  final DateTime? birthDate;
  final String phoneNumber;
  final String? gender;
  final String? nickname;
  @JsonKey(unknownEnumValue: UserStatusType.unknown)
  final UserStatusType status;

  const SimpleUser({
    required this.id,
    required this.name,
    this.gender,
    required this.phoneNumber,
    this.birthDate,
    this.email,
    this.nickname,
    this.status = UserStatusType.unknown,
  });

  factory SimpleUser.fromJson(Map<String, dynamic> json) => _$SimpleUserFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleUserToJson(this);
}
