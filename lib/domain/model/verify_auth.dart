import 'package:salary_plus_web/domain/model/user/token.dart';
import 'package:salary_plus_web/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_auth.g.dart';

@JsonSerializable()
class VerifyAuth {
  final Token token;
  final User user;

  VerifyAuth({
    required this.token,
    required this.user,
  });

  factory VerifyAuth.fromJson(Map<String, dynamic> json) => _$VerifyAuthFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyAuthToJson(this);
}
