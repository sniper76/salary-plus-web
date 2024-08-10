import 'package:act_cms/domain/model/enum/stop_word_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stop_word.g.dart';

@JsonSerializable()
class StopWord {
  final int id;
  final String word;
  final StopWordStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const StopWord({
    required this.id,
    required this.word,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StopWord.fromJson(Map<String, dynamic> json) => _$StopWordFromJson(json);

  Map<String, dynamic> toJson() => _$StopWordToJson(this);
}
