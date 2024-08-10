import 'package:act_cms/domain/model/write_count.dart';
import 'package:json_annotation/json_annotation.dart';

part 'anonymous_write_count.g.dart';

@JsonSerializable()
class AnonymousWriteCount {
  final WriteCount post;
  final WriteCount comment;

  const AnonymousWriteCount({
    required this.post,
    required this.comment,
  });

  factory AnonymousWriteCount.fromJson(Map<String, dynamic> json) => _$AnonymousWriteCountFromJson(json);

  Map<String, dynamic> toJson() => _$AnonymousWriteCountToJson(this);
}
