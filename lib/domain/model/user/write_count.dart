import 'package:freezed_annotation/freezed_annotation.dart';

part 'write_count.freezed.dart';
part 'write_count.g.dart';

@freezed
class WriteCount with _$WriteCount {
  const WriteCount._();

  const factory WriteCount({
    required int current,
    required int max,
  }) = _WriteCount;

  factory WriteCount.fromJson(Map<String, dynamic> json) => _$WriteCountFromJson(json);
}

extension WriteCountExtension on WriteCount {
  bool get canWrite => current < max;
  int get remainingCount => (max - current > 0) ? max - current : 0;
}
