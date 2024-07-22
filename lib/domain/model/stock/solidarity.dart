import 'package:act_web/domain/enum/solidarity_status_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:act_web/domain/model/stock/link.dart';

part 'solidarity.freezed.dart';
part 'solidarity.g.dart';

@freezed
class Solidarity with _$Solidarity {
  const Solidarity._();

  const factory Solidarity({
    required String name,
    required String code,
    @Default(0) int memberCount,
    @Default(0) int requiredMemberCount,
    @Default(50) int minThresholdMemberCount,
    @Default(0.0) double stake,
    @Default(0) int stakeRankDelta,
    @Default(SolidarityStatusType.unknown) SolidarityStatusType status,
    List<Link>? links,
    String? representativePhoneNumber,
    String? stakeRank,
  }) = _Solidarity;

  factory Solidarity.fromJson(Map<String, dynamic> json) => _$SolidarityFromJson(json);

  bool get isActive => status == SolidarityStatusType.active;

  String get stockLogoUrl => 'https://cdn.deepsearch.com/company/logo/$code.png';
}

extension SolidarityExtension on Solidarity {
  bool isSameSolidarity(Solidarity solidarity) {
    return code == solidarity.code;
  }
}
