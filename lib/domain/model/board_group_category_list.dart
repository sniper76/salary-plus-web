import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/enum/board_category.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';

class BoardGroupCategoryList {
  final String name;
  final String displayName;
  final BoardGroupType boardGroup;
  final bool active;
  final int displayOrder;

  const BoardGroupCategoryList._(this.name, this.displayName, this.boardGroup, this.active, this.displayOrder);

  static const BoardGroupCategoryList DAILY_ACT =
      BoardGroupCategoryList._("DAILY_ACT", "분석자료", BoardGroupType.analysis, true, 0);
  static const BoardGroupCategoryList STOCK_CURRENT_ISSUES =
      BoardGroupCategoryList._("STOCK_CURRENT_ISSUES", "종목현안", BoardGroupType.analysis, false, 1);
  static const BoardGroupCategoryList TOPICS =
      BoardGroupCategoryList._("TOPICS", "주담통", BoardGroupType.analysis, false, 2);
  static const BoardGroupCategoryList WEEKLY_ISSUES =
      BoardGroupCategoryList._("WEEKLY_ISSUES", "주간이슈", BoardGroupType.analysis, false, 3);
  static const BoardGroupCategoryList ANALYZE_REPORTS =
      BoardGroupCategoryList._("ANALYZE_REPORTS", "리포트 분석", BoardGroupType.analysis, false, 4);
  static const BoardGroupCategoryList SOLIDARITY_LEADER_LETTERS =
      BoardGroupCategoryList._("SOLIDARITY_LEADER_LETTERS", "주주연대 공지", BoardGroupType.analysis, true, 5);
  static BoardGroupCategoryList DEBATE = BoardGroupCategoryList._(
      BoardGroupType.debate.value, BoardGroupType.debate.title, BoardGroupType.debate, true, 0);
  static BoardGroupCategoryList FREE_DEBATE = BoardGroupCategoryList._(
      "FREE_DEBATE", BoardGroupType.globalcommunity.title, BoardGroupType.globalcommunity, true, 1);
  static BoardGroupCategoryList SURVEYS = BoardGroupCategoryList._(
      BoardCategoryType.surveys.value, BoardCategoryType.surveys.title, BoardGroupType.action, true, 0);
  static BoardGroupCategoryList DIGITAL_DELEGATION = BoardGroupCategoryList._(BoardCategoryType.digitalDelegation.value,
      BoardCategoryType.digitalDelegation.title, BoardGroupType.action, true, 1);
  static BoardGroupCategoryList CO_HOLDING_ARRANGEMENTS = BoardGroupCategoryList._(
      BoardCategoryType.coHoldingArrangements.value,
      BoardCategoryType.coHoldingArrangements.title,
      BoardGroupType.action,
      true,
      2);
  static BoardGroupCategoryList ETC = BoardGroupCategoryList._(
      BoardCategoryType.etc.value, BoardCategoryType.etc.title, BoardGroupType.action, true, 3);
  static const BoardGroupCategoryList STOCKHOLDER_ACTION =
      BoardGroupCategoryList._("STOCKHOLDER_ACTION", "주주행동", BoardGroupType.globalboard, true, 0);
  static const BoardGroupCategoryList NOTICE =
      BoardGroupCategoryList._("NOTICE", "ACT공지", BoardGroupType.globalboard, true, 1);
  static const BoardGroupCategoryList STOCK_ANALYSIS_DATA =
      BoardGroupCategoryList._("STOCK_ANALYSIS_DATA", "분석자료", BoardGroupType.globalboard, true, 2);
  static const BoardGroupCategoryList ALL = BoardGroupCategoryList._("ALL", "전체", BoardGroupType.unknown, true, 0);

  static List<BoardGroupCategoryList> get values => [
        ALL,
        DAILY_ACT,
        STOCK_CURRENT_ISSUES,
        TOPICS,
        WEEKLY_ISSUES,
        ANALYZE_REPORTS,
        SOLIDARITY_LEADER_LETTERS,
        DEBATE,
        FREE_DEBATE,
        SURVEYS,
        DIGITAL_DELEGATION,
        CO_HOLDING_ARRANGEMENTS,
        ETC,
        STOCKHOLDER_ACTION,
        NOTICE,
        STOCK_ANALYSIS_DATA,
      ];

  static List<BoardGroupCategory> get activeBoardCategories => values
      .where((c) => c.active)
      .map((item) => BoardGroupCategory(displayName: item.displayName, name: item.name))
      .toList();

  static List<BoardGroupCategory> activeBoardCategoriesByBoardGroup(BoardGroupType group) => values
      .where((c) => (c.boardGroup == group && c.active) || c.name == "ALL")
      .map((item) => BoardGroupCategory(displayName: item.displayName, name: item.name))
      .toList();
}
