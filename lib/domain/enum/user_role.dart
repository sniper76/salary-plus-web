import 'package:json_annotation/json_annotation.dart';

enum UserRole {
  @JsonValue('SUPER_ADMIN')
  superAdmin('SUPER_ADMIN', '슈퍼 관리자'),
  @JsonValue('ADMIN')
  admin('ADMIN', '관리자'),
  @JsonValue('USER')
  user('USER', '주주대표'),
  @JsonValue('ACCEPTOR_USER')
  acceptorUser('ACCEPTOR_USER', '유저');

  const UserRole(this.value, this.title);

  final String value;
  final String title;
}
