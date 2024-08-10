part of 'cms_group_bloc.dart';

@immutable
abstract class CmsStockGroupEvent {
  const CmsStockGroupEvent._();

  const factory CmsStockGroupEvent.init(int? code) = CmsStockGroupOnInit;

  const factory CmsStockGroupEvent.searchStockGroupKeword(String keyword) = SearchStockGroupKeword;

  const factory CmsStockGroupEvent.searchStocksByCodeList(String codeList) = SearchStocksByCodeList;

  const factory CmsStockGroupEvent.setStockGroupName(String codeList) = SetStockGroupName;

  const factory CmsStockGroupEvent.addStock(SimpleStock stock) = AddStock;

  const factory CmsStockGroupEvent.addStockByBatchList(List<SimpleStock> stockList) = AddStockByBatch;

  const factory CmsStockGroupEvent.deleteStock(SimpleStock stock) = DeleteStock;

  const factory CmsStockGroupEvent.deleteStockGroup(int stockGroupId) = DeleteStockGroup;

  const factory CmsStockGroupEvent.deleteMatchBatchStock(SimpleStock stock) = DeleteMatchBatchStock;

  const factory CmsStockGroupEvent.deleteNonMatchBatchStock(String stock) = DeleteNonMatchBatchStock;

  const factory CmsStockGroupEvent.searchStockByKeyword(String keyword) = SearchStockByKeyword;

  const factory CmsStockGroupEvent.registerStockGroup() = RegisterStockGroup;

  const factory CmsStockGroupEvent.setDescripntion(String description) = SetStockGroupDescription;

  const factory CmsStockGroupEvent.setEditorble(bool isEditable) = StockGroupEnableEditable;
}

class CmsStockGroupOnInit extends CmsStockGroupEvent {
  final int? id;

  const CmsStockGroupOnInit(this.id) : super._();
}

class SearchStockGroupKeword extends CmsStockGroupEvent {
  final String keyword;

  const SearchStockGroupKeword(this.keyword) : super._();
}

class SearchStocksByCodeList extends CmsStockGroupEvent {
  final String codeList;

  const SearchStocksByCodeList(this.codeList) : super._();
}

class SetStockGroupName extends CmsStockGroupEvent {
  final String name;

  const SetStockGroupName(this.name) : super._();
}

class SetStockGroupDescription extends CmsStockGroupEvent {
  final String description;

  const SetStockGroupDescription(this.description) : super._();
}

class AddStock extends CmsStockGroupEvent {
  final SimpleStock stock;

  const AddStock(this.stock) : super._();
}

class AddStockByBatch extends CmsStockGroupEvent {
  final List<SimpleStock> stockList;

  const AddStockByBatch(this.stockList) : super._();
}

class DeleteStock extends CmsStockGroupEvent {
  final SimpleStock stock;

  const DeleteStock(this.stock) : super._();
}

class DeleteStockGroup extends CmsStockGroupEvent {
  final int stockGroupId;

  const DeleteStockGroup(this.stockGroupId) : super._();
}

class DeleteMatchBatchStock extends CmsStockGroupEvent {
  final SimpleStock stock;

  const DeleteMatchBatchStock(this.stock) : super._();
}

class DeleteNonMatchBatchStock extends CmsStockGroupEvent {
  final String stock;

  const DeleteNonMatchBatchStock(this.stock) : super._();
}

class SearchStockByKeyword extends CmsStockGroupEvent {
  final String keyword;

  const SearchStockByKeyword(this.keyword) : super._();
}

class RegisterStockGroup extends CmsStockGroupEvent {
  const RegisterStockGroup() : super._();
}

class StockGroupEnableEditable extends CmsStockGroupEvent {
  final bool isEditable;

  const StockGroupEnableEditable(this.isEditable) : super._();
}
