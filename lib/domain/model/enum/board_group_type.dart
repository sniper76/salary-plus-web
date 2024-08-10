import 'package:json_annotation/json_annotation.dart';

enum BoardGroupType {
  @JsonValue('ANALYSIS')
  analysis,
  @JsonValue('ACTION')
  action,
  @JsonValue('DEBATE')
  debate,
  @JsonValue('GLOBALBOARD')
  globalboard,
  @JsonValue('GLOBALCOMMUNITY')
  globalcommunity,
  @JsonValue('GLOBALEVENT')
  globalevent,
  @JsonValue('UNKNOWN')
  unknown,
}

extension BoardGroupTypeExtension on BoardGroupType {
  bool get isWriteable => this == BoardGroupType.debate;

  bool get enablePoll => this != BoardGroupType.analysis && this != BoardGroupType.unknown;

  bool get enableDigitalProxy => this == BoardGroupType.action;

  String get value {
    switch (this) {
      case BoardGroupType.analysis:
        return 'ANALYSIS';
      case BoardGroupType.action:
        return 'ACTION';
      case BoardGroupType.debate:
        return 'DEBATE';
      case BoardGroupType.globalboard:
        return 'GLOBALBOARD';
      case BoardGroupType.globalcommunity:
        return 'GLOBALCOMMUNITY';
      case BoardGroupType.globalevent:
        return 'GLOBALEVENT';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case BoardGroupType.analysis:
        return '게시판(종목)';
      case BoardGroupType.action:
        return '액션';
      case BoardGroupType.debate:
        return '토론방';
      case BoardGroupType.globalboard:
        return '게시판(뉴스)';
      case BoardGroupType.globalcommunity:
        return '커뮤니티';
      default:
        return '';
    }
  }
}
