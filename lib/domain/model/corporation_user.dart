import 'package:act_cms/domain/model/enum/user_status_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'corporation_user.g.dart';

@JsonSerializable()
class CorporationUser {
  final int id;
  final int userId;
  final String corporateNo;
  final String corporateName;
  final List<String> leadingSolidarityStockCodes;
  final UserStatusType status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CorporationUser({
    required this.id,
    required this.userId,
    required this.corporateNo,
    required this.corporateName,
    this.leadingSolidarityStockCodes = const [],
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  CorporationUser copyWith({
    int? id,
    int? userId,
    String? corporateNo,
    String? corporateName,
    List<String>? leadingSolidarityStockCodes,
    UserStatusType? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CorporationUser(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      corporateNo: corporateNo ?? this.corporateNo,
      corporateName: corporateName ?? this.corporateName,
      leadingSolidarityStockCodes: leadingSolidarityStockCodes ?? this.leadingSolidarityStockCodes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory CorporationUser.fromJson(Map<String, dynamic> json) => _$CorporationUserFromJson(json);

  Map<String, dynamic> toJson() => _$CorporationUserToJson(this);
}
