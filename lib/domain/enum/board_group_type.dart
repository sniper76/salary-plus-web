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
  @JsonValue("ACT_BEST")
  actBest,
  @JsonValue('UNKNOWN')
  unknown,
}

extension BoardGroupTypeExtension on BoardGroupType {
  static final Map<String, BoardGroupType> boardGroupTypeByTitleMap = {
    '공지': BoardGroupType.analysis,
    '액션': BoardGroupType.action,
    '토론방': BoardGroupType.debate,
  };

  bool get isWriteableForAllUsers => [BoardGroupType.debate, BoardGroupType.globalcommunity].contains(this);

  bool get isNotWriteable =>
      [BoardGroupType.actBest, BoardGroupType.globalboard, BoardGroupType.globalevent].contains(this);

  bool get isWriteableForSolidarityLeader => this == BoardGroupType.analysis;

  bool get enablePoll => this != BoardGroupType.analysis && this != BoardGroupType.unknown;

  bool get enableExclusiveToHolders =>
      [BoardGroupType.debate, BoardGroupType.action, BoardGroupType.analysis].contains(this);

  bool get enableSelectPollVoteType => ![BoardGroupType.globalcommunity, BoardGroupType.unknown].contains(this);

  bool get enableDigitalProxy => this == BoardGroupType.action;

  bool get isVisibleCategory => ![BoardGroupType.globalcommunity].contains(this);

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
      case BoardGroupType.actBest:
        return 'ACT_BEST';
      default:
        return '';
    }
  }

  String get title {
    switch (this) {
      case BoardGroupType.analysis:
        return '공지';
      case BoardGroupType.action:
        return '액션';
      case BoardGroupType.debate:
        return '토론방';
      case BoardGroupType.globalboard:
        return '주주행동 News';
      case BoardGroupType.globalcommunity:
        return '자유게시판';
      case BoardGroupType.globalevent:
        return '이벤트/공지';
      case BoardGroupType.actBest:
        return '';
      default:
        return '';
    }
  }

  String get iconPath {
    switch (this) {
      case BoardGroupType.analysis:
        return 'assets/images/ic_analysis.svg';
      case BoardGroupType.action:
        return 'assets/images/ic_action.svg';
      case BoardGroupType.debate:
        return 'assets/images/ic_debate.svg';
      case BoardGroupType.globalboard:
        return 'assets/images/ic_global_board.svg';
      case BoardGroupType.globalcommunity:
        return 'assets/images/ic_debate.svg';
      case BoardGroupType.globalevent:
        return '';
      case BoardGroupType.actBest:
        return '';
      default:
        return '';
    }
  }
}
