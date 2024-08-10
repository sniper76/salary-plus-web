import 'package:json_annotation/json_annotation.dart';

part 'searching.g.dart';

@JsonSerializable()
class Searching {
  final int? period;
  final String? from;
  final String? to;

  const Searching({
    this.period,
    this.from,
    this.to,
  });

  factory Searching.fromJson(Map<String, dynamic> json) => _$SearchingFromJson(json);

  Map<String, dynamic> toJson() => _$SearchingToJson(this);
}
