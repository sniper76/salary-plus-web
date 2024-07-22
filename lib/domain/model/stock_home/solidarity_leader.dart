import 'package:act_web/domain/enum/leader_status_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'solidarity_leader.freezed.dart';
part 'solidarity_leader.g.dart';

@freezed
class SolidarityLeader with _$SolidarityLeader {
  const SolidarityLeader._();

  const factory SolidarityLeader({
    @JsonKey(unknownEnumValue: SolidarityLeaderStatusType.unknown) required SolidarityLeaderStatusType status,
    String? message,
    bool? applied,
    int? solidarityId,
  }) = _SolidarityLeader;

  factory SolidarityLeader.fromJson(Map<String, dynamic> json) => _$SolidarityLeaderFromJson(json);
}

extension SolidarityLeaderExtension on SolidarityLeader {
  bool get isElected => status == SolidarityLeaderStatusType.elected;

  bool get canApply => applied == false;

  String get leaderMessage => message ?? '';
}
