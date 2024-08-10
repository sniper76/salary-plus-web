import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/cms_commons.dart';
import 'package:act_cms/domain/model/enum/action_document_type.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/model/simple_stock_group.dart';
import 'package:flutter/cupertino.dart';

class CMSCommonsService extends ChangeNotifier {
  CMSCommons? _cmsCommons;

  CMSCommons? get cmsCommons => _cmsCommons;

  init() async {}

  void setCMSCommons(CMSCommons? data) {
    _cmsCommons = data;
    notifyListeners();
  }

  void deleteStockGroup(int stockGroupId) {
    if (_cmsCommons == null) return;

    final newStockGroup = _cmsCommons!.stockGroups.where((stockGroup) => stockGroupId != stockGroup.id).toList();

    _cmsCommons = _cmsCommons!.copyWith(stockGroups: newStockGroup);
  }

  List<BoardGroupCategory> getCategoryByBoardGroup(BoardGroupType boardGroup) {
    final result = _cmsCommons?.boardGroups.firstWhere((c) => (c.name == boardGroup.name.toUpperCase()));
    return result?.categories ?? [];
  }

  List<ActionDocumentType> getActionDocumentTypeList() {
    return [ActionDocumentType.poll, ActionDocumentType.digitalDocument, ActionDocumentType.allsign];
  }

  List<SimpleStockGroup> getFilteredCandidateStockGroupList(String searchKeyword) {
    if (searchKeyword == "") {
      return [];
    } else {
      final keyword = searchKeyword.toLowerCase();
      final candidateStockList = _cmsCommons?.stockGroups
          .where((stock) => stock.name.toLowerCase().contains(keyword))
          .map((data) => SimpleStockGroup(id: data.id, name: data.name))
          .toList();

      return candidateStockList ?? [];
    }
  }

  List<SimpleStock> getFilteredCandidateStockList(String searchKeyword) {
    if (searchKeyword == "") {
      return _cmsCommons?.stocks ?? [];
    } else {
      final candidateStockList = _cmsCommons?.stocks
          .where((stock) {
            String searchKeywordLower = searchKeyword.toLowerCase();
            String stockCodeLower = stock.code.toLowerCase();
            String stockNameLower = stock.name.toLowerCase();

            return stockCodeLower.startsWith(searchKeywordLower) ||
                (searchKeywordLower.length >= 2 && stockNameLower.contains(searchKeywordLower));
          })
          .map((data) => SimpleStock(code: data.code, name: data.name))
          .toList();
      return candidateStockList ?? [];
    }
  }
}
