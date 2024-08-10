import 'package:json_annotation/json_annotation.dart';

part 'push_user.g.dart';

@JsonSerializable()
class PushUser {
  final String name;
  final String nickname;

  const PushUser({
    required this.name,
    required this.nickname,
  });

  factory PushUser.fromJson(Map<String, dynamic> json) => _$PushUserFromJson(json);

  Map<String, dynamic> toJson() => _$PushUserToJson(this);
}
