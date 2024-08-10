import 'package:json_annotation/json_annotation.dart';

part 'can_use.g.dart';

@JsonSerializable()
class CanUse {
  final bool canUse;

  const CanUse({this.canUse = false});

  factory CanUse.fromJson(Map<String, dynamic> json) => _$CanUseFromJson(json);

  Map<String, dynamic> toJson() => _$CanUseToJson(this);
}
