part of 'bloc.dart';

@immutable
abstract class PopupEvent {
  const PopupEvent._();

  const factory PopupEvent.init(Popup? updatePopup) = PopupOnInit;

  const factory PopupEvent.setTargetStockType(PopupStockTargetType searchType) = PopupOnSetStockType;

  const factory PopupEvent.setTargetDisplayType(PopupDisplayTargetType searchType) = PopupOnSetDisplayType;

  const factory PopupEvent.setTargetLinkType(PopupLinkType linkType) = PopupOnSetLinkType;

  const factory PopupEvent.searchKeyword(String searchKeyword) = PopupOnSetTargetSearchKeyword;

  const factory PopupEvent.setStartDatetime(DateTime newDate) = PopupOnSetStartDatetime;

  const factory PopupEvent.setEndDatetime(DateTime newDate) = PopupOnSetEndDatetime;

  const factory PopupEvent.setStock(String stock) = PopupOnSetStockCode;

  const factory PopupEvent.setStockGroup(int stockGroup) = PopupOnSetStockGroupId;

  const factory PopupEvent.savePopup({
    required String title,
    required DateTime targetStartDatetime,
    required DateTime targetEndDatetime,
    required PopupDisplayTargetType displayTargetType,
    required PopupStockTargetType stockTargetType,
    required String content,
    required PopupLinkType linkType,
    String? stockCode,
    int? stockGroupId,
    String? linkTitle,
    String? postId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? popupId,
  }) = PopupOnSave;

  const factory PopupEvent.fetchPopupLoadMore({
    String? searchKeyword,
    int page,
    int size,
    String? sorts,
  }) = PopupOnLoadMore;
}

class PopupOnInit extends PopupEvent {
  final Popup? updatePopup;

  const PopupOnInit(this.updatePopup) : super._();
}

class PopupOnSetStockType extends PopupEvent {
  final PopupStockTargetType targetStockType;

  const PopupOnSetStockType(this.targetStockType) : super._();
}

class PopupOnSetDisplayType extends PopupEvent {
  final PopupDisplayTargetType displayTargetType;

  const PopupOnSetDisplayType(this.displayTargetType) : super._();
}

class PopupOnSetLinkType extends PopupEvent {
  final PopupLinkType targetLinkType;

  const PopupOnSetLinkType(this.targetLinkType) : super._();
}

class PopupOnSetTargetSearchKeyword extends PopupEvent {
  final String searchKeyword;

  const PopupOnSetTargetSearchKeyword(this.searchKeyword) : super._();
}

class PopupOnSetLinkPostId extends PopupEvent {
  final int postId;

  const PopupOnSetLinkPostId(this.postId) : super._();
}

class PopupOnSetStartDatetime extends PopupEvent {
  final DateTime newDate;

  const PopupOnSetStartDatetime(this.newDate) : super._();
}

class PopupOnSetEndDatetime extends PopupEvent {
  final DateTime newDate;

  const PopupOnSetEndDatetime(this.newDate) : super._();
}

class PopupOnSetStockCode extends PopupEvent {
  final String stockCode;

  const PopupOnSetStockCode(this.stockCode) : super._();
}

class PopupOnSetStockGroupId extends PopupEvent {
  final int stockGroupId;

  const PopupOnSetStockGroupId(this.stockGroupId) : super._();
}

class PopupOnSave extends PopupEvent {
  final String title;
  final DateTime targetStartDatetime;
  final DateTime targetEndDatetime;
  final PopupDisplayTargetType displayTargetType;
  final String? stockCode;
  final int? stockGroupId;
  final PopupStockTargetType stockTargetType;
  final String content;
  final PopupLinkType linkType;
  final String? linkTitle;
  final String? postId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? popupId;

  const PopupOnSave({
    required this.title,
    required this.targetStartDatetime,
    required this.targetEndDatetime,
    required this.displayTargetType,
    required this.stockTargetType,
    required this.content,
    required this.linkType,
    this.stockCode,
    this.stockGroupId,
    this.postId,
    this.linkTitle,
    this.createdAt,
    this.updatedAt,
    this.popupId,
  }) : super._();
}

class PopupOnLoadMore extends PopupEvent {
  final String? searchKeyword;
  final int page;
  final int size;
  final String? sorts;

  const PopupOnLoadMore({
    this.searchKeyword,
    this.page = 1,
    this.size = apiLoadSize,
    this.sorts,
  }) : super._();
}
