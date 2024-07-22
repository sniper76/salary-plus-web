part of 'bloc.dart';

@freezed
class StockEvent with _$StockEvent {
  const factory StockEvent.init() = _OnInit;

  const factory StockEvent.changePage({required int page}) = _OnChangePage;

  const factory StockEvent.changeDisplayOrder({required int previousIndex, required int currentIndex}) =
      _OnChangeDisplayOrder;

  const factory StockEvent.updateDisplayOrder() = _OnUpdateDisplayOrder;

  const factory StockEvent.fetchMySolidarity({required int page, required bool isFetchingWhole}) = _OnFetchMySolidarity;

  const factory StockEvent.fetchSearchRanking() = _OnFetchSearchRanking;
}
