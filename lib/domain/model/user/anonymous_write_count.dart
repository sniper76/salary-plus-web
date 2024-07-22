import 'package:act_web/domain/model/post/write_count.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anonymous_write_count.freezed.dart';
part 'anonymous_write_count.g.dart';

@freezed
class AnonymousWriteCount with _$AnonymousWriteCount {
  const factory AnonymousWriteCount({
    required WriteCount post,
    required WriteCount comment,
  }) = _AnonymousWriteCount;

  factory AnonymousWriteCount.fromJson(Map<String, dynamic> json) => _$AnonymousWriteCountFromJson(json);
}
