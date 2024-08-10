import 'package:act_cms/domain/model/enum/solidarity_status_type.dart';
import 'package:act_cms/domain/model/link.dart';
import 'package:json_annotation/json_annotation.dart';

part 'solidarity.g.dart';

@JsonSerializable()
class Solidarity {
  final int id;
  final String name;
  final String code;
  final int memberCount;
  final int requiredMemberCount;
  final int minThresholdMemberCount;
  final double stake;
  @JsonKey(unknownEnumValue: SolidarityStatusType.unknown)
  final SolidarityStatusType status;
  final List<Link>? links;
  final String? representativePhoneNumber;

  const Solidarity({
    required this.name,
    required this.code,
    required this.id,
    this.memberCount = 0,
    this.requiredMemberCount = 0,
    this.minThresholdMemberCount = 50,
    this.stake = 0,
    this.status = SolidarityStatusType.unknown,
    this.links,
    this.representativePhoneNumber,
  });

  factory Solidarity.fromJson(Map<String, dynamic> json) => _$SolidarityFromJson(json);

  Map<String, dynamic> toJson() => _$SolidarityToJson(this);
}

extension SolidarityExtention on Solidarity {
  bool get isActive => status == SolidarityStatusType.active;

  String get stockLogoUrl => 'https://cdn.deepsearch.com/company/logo/$code.png';
}
