part of 'bloc.dart';

@immutable
abstract class StopWordsEvent {
  const StopWordsEvent._();

  const factory StopWordsEvent.init() = StopsWordOnInit;

  const factory StopWordsEvent.fetchStopWords({
    int page,
    int size,
    String? searchKeyWord,
    StopWordSortType? sortType,
  }) = StopsWordsOnFetchStopWords;

  const factory StopWordsEvent.createStopWord(String newWtopWord) = StopsWordsOnCreateStopWord;

  const factory StopWordsEvent.changeStopWordStatus({
    required int stopWordId,
    required StopWordStatus beforeStatus,
    required StopWordStatus afterStatus,
  }) = StopsWordsOnChangeStopWordStatus;

  const factory StopWordsEvent.deleteStopWord(int stopWordId) = StopWordsOnDeleteStopWord;

  const factory StopWordsEvent.loadMore({
    int page,
  }) = StopsWordOnLoadMore;

  const factory StopWordsEvent.searchKeyword(String keyword) = StopsWordOnSearchKeword;

  const factory StopWordsEvent.changeSortType(StopWordSortType changedSortType) = StopsWordOnChangeSortType;

  const factory StopWordsEvent.changeFilterType(StopWordFilterType changedFilterType) = StopsWordOnChangeFilterType;
}

class StopsWordOnInit extends StopWordsEvent {
  const StopsWordOnInit() : super._();
}

class StopsWordOnStockList extends StopWordsEvent {
  final List<Stock> stockList;

  const StopsWordOnStockList(this.stockList) : super._();
}

class StopsWordOnSelectStock extends StopWordsEvent {
  final SimpleStock stock;

  const StopsWordOnSelectStock(this.stock) : super._();
}

class StopsWordsOnFetchStopWords extends StopWordsEvent {
  final int? page;
  final int? size;
  final String? searchKeyWord;
  final StopWordSortType? sortType;
  final StopWordFilterType? filterType;

  const StopsWordsOnFetchStopWords({
    this.page = 1,
    this.size = apiLoadSize,
    this.searchKeyWord,
    this.sortType,
    this.filterType,
  }) : super._();
}

class StopsWordsOnCreateStopWord extends StopWordsEvent {
  final String newStopWord;

  const StopsWordsOnCreateStopWord(this.newStopWord) : super._();
}

class StopsWordsOnChangeStopWordStatus extends StopWordsEvent {
  final int stopWordId;
  final StopWordStatus beforeStatus;
  final StopWordStatus afterStatus;

  const StopsWordsOnChangeStopWordStatus({
    required this.stopWordId,
    required this.beforeStatus,
    required this.afterStatus,
  }) : super._();
}

class StopWordsOnDeleteStopWord extends StopWordsEvent {
  final int stopWordId;

  const StopWordsOnDeleteStopWord(this.stopWordId) : super._();
}

class StopsWordOnLoadMore extends StopWordsEvent {
  final int page;

  const StopsWordOnLoadMore({
    this.page = 1,
  }) : super._();
}

class StopsWordOnSearchKeword extends StopWordsEvent {
  final String keyword;

  const StopsWordOnSearchKeword(this.keyword) : super._();
}

class StopsWordOnChangeSortType extends StopWordsEvent {
  final StopWordSortType changedSortType;

  const StopsWordOnChangeSortType(this.changedSortType) : super._();
}

class StopsWordOnChangeFilterType extends StopWordsEvent {
  final StopWordFilterType changedFilterType;

  const StopsWordOnChangeFilterType(this.changedFilterType) : super._();
}
