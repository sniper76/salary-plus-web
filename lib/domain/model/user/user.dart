import 'package:act_web/domain/enum/user_role.dart';
import 'package:act_web/domain/enum/user_status_type.dart';
import 'package:act_web/domain/model/stock/base_stock.dart';
import 'package:act_web/domain/model/user/badge_visibility.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String? email;
  final String name;
  final String gender;
  final String phoneNumber;
  final int? totalAssetAmount;
  final bool isAgreeToReceiveMail;
  final bool isAdmin;
  final DateTime? birthDate;
  final String? nickname;
  final String? address;
  final String? addressDetail;
  final String? zipcode;
  final String? jobTitle;
  final String? profileImageUrl;
  final DateTime? lastPinNumberVerifiedAt;
  final bool isPinNumberRegistered;
  @JsonKey(unknownEnumValue: UserStatusType.unknown)
  final UserStatusType status;
  final List<String>? leadingSolidarityStockCodes;
  final List<UserRole>? roles;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? editedAt;
  final List<BadgeVisibility> userBadgeVisibilities;
  final bool? isSolidarityLeaderConfidentialAgreementSigned;
  final List<BaseStock>? holdingStocks;

  const User({
    required this.id,
    required this.name,
    required this.gender,
    required this.phoneNumber,
    this.totalAssetAmount = 0,
    this.isAgreeToReceiveMail = false,
    this.isAdmin = false,
    this.birthDate,
    this.email,
    this.nickname,
    this.address,
    this.addressDetail,
    this.zipcode,
    this.jobTitle,
    this.profileImageUrl,
    this.lastPinNumberVerifiedAt,
    this.roles,
    this.leadingSolidarityStockCodes,
    this.isPinNumberRegistered = false,
    this.status = UserStatusType.unknown,
    this.createdAt,
    this.updatedAt,
    this.editedAt,
    this.userBadgeVisibilities = const [],
    this.isSolidarityLeaderConfidentialAgreementSigned,
    this.holdingStocks,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

extension UserExtension on User {
  bool get isActiveStatus => status == UserStatusType.active;

  bool get needToInfoRegister => status == UserStatusType.processing;

  bool get isAcceptorUser => !isAdmin && (roles ?? []).contains(UserRole.acceptorUser);

  bool get isSolidarityLeader => leadingSolidarityStockCodes != null && leadingSolidarityStockCodes!.isNotEmpty;

  User copyWith({
    String? nickname,
    String? address,
    String? addressDetail,
    bool? isAgreeToReceiveMail,
    bool? isSolidarityLeaderConfidentialAgreementSigned,
  }) {
    return User(
      id: id,
      name: name,
      gender: gender,
      totalAssetAmount: totalAssetAmount,
      phoneNumber: phoneNumber,
      isAdmin: isAdmin,
      birthDate: birthDate,
      email: email,
      nickname: nickname ?? this.nickname,
      address: address ?? this.address,
      addressDetail: addressDetail ?? this.addressDetail,
      isAgreeToReceiveMail: isAgreeToReceiveMail ?? this.isAgreeToReceiveMail,
      zipcode: zipcode,
      jobTitle: jobTitle,
      profileImageUrl: profileImageUrl,
      lastPinNumberVerifiedAt: lastPinNumberVerifiedAt,
      isPinNumberRegistered: isPinNumberRegistered,
      status: status,
      roles: roles,
      leadingSolidarityStockCodes: leadingSolidarityStockCodes,
      isSolidarityLeaderConfidentialAgreementSigned:
          isSolidarityLeaderConfidentialAgreementSigned ?? this.isSolidarityLeaderConfidentialAgreementSigned,
      holdingStocks: holdingStocks,
    );
  }
}
