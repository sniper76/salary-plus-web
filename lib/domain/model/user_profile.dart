import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  final String nickname;
  final String? profileImageUrl;
  final String? individualStockCountLabel;
  final String? totalAssetLabel;

  const UserProfile({
    this.nickname = '',
    this.profileImageUrl,
    this.individualStockCountLabel,
    this.totalAssetLabel,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

extension UserProfileExtension on UserProfile {
  bool get isAnonymous => profileImageUrl == null && individualStockCountLabel == null && totalAssetLabel == null;
}
