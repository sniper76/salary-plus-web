import 'package:act_web/domain/model/stock/leading_stock.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const UserProfile._();

  const factory UserProfile({
    required String nickname,
    required bool isSolidarityLeader,
    String? profileImageUrl,
    String? individualStockCountLabel,
    String? totalAssetLabel,
    List<LeadingStock>? leadingStocks,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}

extension UserProfileExtension on UserProfile {
  bool get isAnonymous => profileImageUrl == null && individualStockCountLabel == null && totalAssetLabel == null;

  String? get leadingStocksNameString {
    if (leadingStocks == null || leadingStocks?.isEmpty == true) return null;
    List<String> returnStringList = [];

    for (LeadingStock leadingStock in leadingStocks!) {
      returnStringList.add(leadingStock.name);
    }

    return returnStringList.join(', ');
  }
}
