import 'package:json_annotation/json_annotation.dart';

part 'push.g.dart';

@JsonSerializable()
class Push {
  final int id;
  final String content;
  final String? title;
  final DateTime? targetDatetime;
  final DateTime? sentStartDatetime;
  final DateTime? sentEndDatetime;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Push({
    required this.id,
    required this.content,
    this.title,
    this.targetDatetime,
    this.sentStartDatetime,
    this.sentEndDatetime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Push.fromJson(Map<String, dynamic> json) => _$PushFromJson(json);

  Map<String, dynamic> toJson() => _$PushToJson(this);
}
