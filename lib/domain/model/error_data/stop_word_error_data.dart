import 'package:json_annotation/json_annotation.dart';

part 'stop_word_error_data.g.dart';

@JsonSerializable()
class StopWordErrorData {
  final String word;
  final int stopWordId;

  StopWordErrorData({
    required this.word,
    required this.stopWordId,
  });

  factory StopWordErrorData.fromJson(Map<String, dynamic> json) => _$StopWordErrorDataFromJson(json);

  Map<String, dynamic> toJson() => _$StopWordErrorDataToJson(this);
}
