part of 'doc_bloc.dart';

@immutable
abstract class DigitalDocumentEvent {
  const DigitalDocumentEvent._();

  const factory DigitalDocumentEvent.init() = DigitalDocumentOnInit;

  const factory DigitalDocumentEvent.getPDF(int userID, int digitalDocumentID) = DigitalDocumentOnGetPDF;

  const factory DigitalDocumentEvent.setSearchKeyword(String searchKeyword) = DigitalDocumentOnSetSearchKeyword;

  const factory DigitalDocumentEvent.fetchList({String? searchKeyword, int page, int size, String? sorts}) =
      DigitalDocumentOnFetchList;
}

class DigitalDocumentOnInit extends DigitalDocumentEvent {
  const DigitalDocumentOnInit() : super._();
}

class DigitalDocumentOnSetSearchKeyword extends DigitalDocumentEvent {
  final String searchKeyword;

  const DigitalDocumentOnSetSearchKeyword(this.searchKeyword) : super._();
}

class DigitalDocumentOnFetchList extends DigitalDocumentEvent {
  final String? searchKeyword;
  final int page;
  final int size;
  final String? sorts;

  const DigitalDocumentOnFetchList({
    this.searchKeyword,
    this.page = 1,
    this.size = apiLoadSize,
    this.sorts,
  }) : super._();
}

class DigitalDocumentOnGetPDF extends DigitalDocumentEvent {
  final int userID;
  final int digitalDocumentID;

  const DigitalDocumentOnGetPDF(this.userID, this.digitalDocumentID) : super._();
}
