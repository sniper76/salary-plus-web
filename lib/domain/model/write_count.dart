import 'package:json_annotation/json_annotation.dart';

part 'write_count.g.dart';

@JsonSerializable()
class WriteCount {
  final int current;
  final int max;

  const WriteCount({
    required this.current,
    required this.max,
  });

  factory WriteCount.fromJson(Map<String, dynamic> json) => _$WriteCountFromJson(json);

  Map<String, dynamic> toJson() => _$WriteCountToJson(this);
}

extension WriteCountExtension on WriteCount {
  bool get canWrite => current < max;

  int get remainingCount => (max - current > 0) ? max - current : 0;
}
