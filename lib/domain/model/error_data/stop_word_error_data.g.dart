// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_word_error_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StopWordErrorData _$StopWordErrorDataFromJson(Map<String, dynamic> json) =>
    StopWordErrorData(
      word: json['word'] as String,
      stopWordId: (json['stopWordId'] as num).toInt(),
    );

Map<String, dynamic> _$StopWordErrorDataToJson(StopWordErrorData instance) =>
    <String, dynamic>{
      'word': instance.word,
      'stopWordId': instance.stopWordId,
    };
