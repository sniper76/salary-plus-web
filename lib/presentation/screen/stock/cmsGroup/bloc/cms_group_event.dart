part of 'cms_group_bloc.dart';

@immutable
abstract class CmsStockGroupEvent {
  const CmsStockGroupEvent._();

  const factory CmsStockGroupEvent.init() = CmsStockGroupOnInit;

  const factory CmsStockGroupEvent.cmsStockOnStockList(List<StockGroup> stockList) = CmsStockGroupOnStockList;

  const factory CmsStockGroupEvent.cmsStockOnSetCode(int stockGroupId) = CmsStockGroupOnSetStockGroupId;

  const factory CmsStockGroupEvent.cmsStockOnPaginatorIndex(int paginatorIndex) = CmsStockGroupOnPaginatorIndex;

  const factory CmsStockGroupEvent.fetchCmsStockGroup({int? stockGroupId, int page, int size, String? sorts}) =
      FetchCmsStockGroup;

  const factory CmsStockGroupEvent.fetchUserDetail(int userId) = FetchUserDetail;

  const factory CmsStockGroupEvent.fetchCmsStockGroupLoadMore({
    int? stockGroupId,
    int page,
    int size,
    String? sorts,
  }) = CmsStockGroupOnLoadMore;

  const factory CmsStockGroupEvent.searchKeyword(String keyword) = SearchKeword;

  const factory CmsStockGroupEvent.submitKeyword(String keyword) = SubmitKeyword;

  const factory CmsStockGroupEvent.filterStockGroupList(int stockGroupId) = FilterStockGroupList;
}

class CmsStockGroupOnInit extends CmsStockGroupEvent {
  const CmsStockGroupOnInit() : super._();
}

class CmsStockGroupOnStockList extends CmsStockGroupEvent {
  final List<StockGroup> stockList;

  const CmsStockGroupOnStockList(this.stockList) : super._();
}

class CmsStockGroupOnSetStockGroupId extends CmsStockGroupEvent {
  final int stockGroupId;

  const CmsStockGroupOnSetStockGroupId(this.stockGroupId) : super._();
}

class CmsStockGroupOnPaginatorIndex extends CmsStockGroupEvent {
  final int paginatorIndex;

  const CmsStockGroupOnPaginatorIndex(this.paginatorIndex) : super._();
}

class FetchCmsStockGroup extends CmsStockGroupEvent {
  final int? stockGroupId;
  final int page;
  final int size;
  final String? sorts;

  const FetchCmsStockGroup({
    this.stockGroupId,
    this.page = 1,
    this.size = apiLoadSize,
    this.sorts,
  }) : super._();
}

class CmsStockGroupOnLoadMore extends CmsStockGroupEvent {
  final int? stockGroupId;
  final int page;
  final int size;
  final String? sorts;

  const CmsStockGroupOnLoadMore({
    this.stockGroupId,
    this.page = 1,
    this.size = apiLoadSize,
    this.sorts,
  }) : super._();
}

class FetchUserDetail extends CmsStockGroupEvent {
  final int userId;

  const FetchUserDetail(this.userId) : super._();
}

class SearchKeword extends CmsStockGroupEvent {
  final String keyword;

  const SearchKeword(this.keyword) : super._();
}

class SubmitKeyword extends CmsStockGroupEvent {
  final String keyword;

  const SubmitKeyword(this.keyword) : super._();
}

class FilterStockGroupList extends CmsStockGroupEvent {
  final int stockGroupId;

  const FilterStockGroupList(this.stockGroupId) : super._();
}
