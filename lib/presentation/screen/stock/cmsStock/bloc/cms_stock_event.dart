part of 'cms_stock_bloc.dart';

@immutable
abstract class CmsStockEvent {
  const CmsStockEvent._();

  const factory CmsStockEvent.init() = CmsStockOnInit;

  const factory CmsStockEvent.cmsStockOnStockList(List<Stock> stockList) = CmsStockOnStockList;

  const factory CmsStockEvent.cmsStockOnSelectStock(SimpleStock stock) = CmsStockOnSelectStock;

  const factory CmsStockEvent.cmsStockOnPaginatorIndex(int paginatorIndex) = CmsStockOnPaginatorIndex;

  const factory CmsStockEvent.fetchCmsStock(
      {int page, int size, SimpleStock? stock, StockSortType? sortType, bool? clearSimpleStock}) = FetchCmsStock;

  const factory CmsStockEvent.fetchCmsStockLoadMore({
    int page,
  }) = CmsStockOnLoadMore;

  const factory CmsStockEvent.assignStockReferencDate(DateTime date) = AssignStockReferencDate;

  const factory CmsStockEvent.searchKeyword(String keyword) = SearchKeword;

  const factory CmsStockEvent.setSimpleStock(SimpleStock selectedStock) = SetSimpleStock;

  const factory CmsStockEvent.showInfo(String msg) = ShowInfo;

  const factory CmsStockEvent.changeSortType(StockSortType changedSortType) = ChangeSortType;
}

class CmsStockOnInit extends CmsStockEvent {
  const CmsStockOnInit() : super._();
}

class CmsStockOnStockList extends CmsStockEvent {
  final List<Stock> stockList;

  const CmsStockOnStockList(this.stockList) : super._();
}

class CmsStockOnSelectStock extends CmsStockEvent {
  final SimpleStock stock;

  const CmsStockOnSelectStock(this.stock) : super._();
}

class CmsStockOnPaginatorIndex extends CmsStockEvent {
  final int paginatorIndex;

  const CmsStockOnPaginatorIndex(this.paginatorIndex) : super._();
}

class FetchCmsStock extends CmsStockEvent {
  final int page;
  final int size;
  final SimpleStock? stock;
  final StockSortType? sortType;
  final bool? clearSimpleStock;

  const FetchCmsStock({
    this.stock,
    this.page = 1,
    this.size = apiLoadSize,
    this.sortType,
    this.clearSimpleStock = false,
  }) : super._();
}

class CmsStockOnLoadMore extends CmsStockEvent {
  final int page;

  const CmsStockOnLoadMore({
    this.page = 1,
  }) : super._();
}

class AssignStockReferencDate extends CmsStockEvent {
  final DateTime date;

  const AssignStockReferencDate(this.date) : super._();
}

class SearchKeword extends CmsStockEvent {
  final String keyword;

  const SearchKeword(this.keyword) : super._();
}

class SetSimpleStock extends CmsStockEvent {
  final SimpleStock seletedStock;

  const SetSimpleStock(this.seletedStock) : super._();
}

class ShowInfo extends CmsStockEvent {
  final String msg;

  const ShowInfo(this.msg) : super._();
}

class ChangeSortType extends CmsStockEvent {
  final StockSortType changedSortType;

  const ChangeSortType(this.changedSortType) : super._();
}
