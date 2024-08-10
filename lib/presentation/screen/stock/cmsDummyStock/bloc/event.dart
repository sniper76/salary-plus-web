part of 'bloc.dart';

@immutable
abstract class CmsDummyEvent {
  const CmsDummyEvent._();

  const factory CmsDummyEvent.onInit() = OnInit;

  const factory CmsDummyEvent.onSelectedStock(SimpleStock selectedStock) = OnSelectedStock;

  const factory CmsDummyEvent.onGetStockReferenceDate(String selectedStockCode) = OnGetReferenceDate;

  const factory CmsDummyEvent.onSearchStock() = OnSearchStock;

  const factory CmsDummyEvent.onSearchKeyword(String searchText) = OnSearchKeyword;

  const factory CmsDummyEvent.onSelectedReferenceDate(StockReferenceDate selectedReferenceDate) =
      OnSelectedReferenceDate;

  const factory CmsDummyEvent.onAddDummyStock(int userId) = OnAddDummyStock;
}

class OnInit extends CmsDummyEvent {
  const OnInit() : super._();
}

class OnSelectedStock extends CmsDummyEvent {
  final SimpleStock selectedStock;

  const OnSelectedStock(this.selectedStock) : super._();
}

class OnGetReferenceDate extends CmsDummyEvent {
  final String selectedStockCode;

  const OnGetReferenceDate(this.selectedStockCode) : super._();
}

class OnSearchStock extends CmsDummyEvent {
  const OnSearchStock() : super._();
}

class OnSearchKeyword extends CmsDummyEvent {
  final String searchText;

  const OnSearchKeyword(this.searchText) : super._();
}

class OnSelectedReferenceDate extends CmsDummyEvent {
  final StockReferenceDate selectedReferenceDate;

  const OnSelectedReferenceDate(this.selectedReferenceDate) : super._();
}

class OnAddDummyStock extends CmsDummyEvent {
  final int userId;

  const OnAddDummyStock(this.userId) : super._();
}
