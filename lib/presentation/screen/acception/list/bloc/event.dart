part of 'bloc.dart';

abstract class AcceptanceListEvent {
  const AcceptanceListEvent._();

  const factory AcceptanceListEvent.onInit() = OnInit;

  const factory AcceptanceListEvent.onGetAcceptanceList({
    DigitalDocumentType documentType,
    BoardSearchType? searchType,
    String? searchKeyword,
    int? page,
    int? size,
  }) = OnGetAcceptanceList;

  const factory AcceptanceListEvent.onSetSearchType(BoardSearchType searchType) = OnSetSearchType;

  const factory AcceptanceListEvent.onSetSearchKeyword(String searchKeyword) = OnSetSearchKeyword;

  const factory AcceptanceListEvent.onDownloadExcel(int documentId) = OnDownloadExcel;
}

class OnInit extends AcceptanceListEvent {
  const OnInit() : super._();
}

class OnSetSearchType extends AcceptanceListEvent {
  final BoardSearchType searchType;

  const OnSetSearchType(this.searchType) : super._();
}

class OnSetSearchKeyword extends AcceptanceListEvent {
  final String searchKeyword;

  const OnSetSearchKeyword(this.searchKeyword) : super._();
}

class OnGetAcceptanceList extends AcceptanceListEvent {
  final DigitalDocumentType documentType;
  final BoardSearchType? searchType;
  final String? searchKeyword;
  final int? page;
  final int? size;

  const OnGetAcceptanceList(
      {this.documentType = DigitalDocumentType.digitalProxy, this.searchType, this.searchKeyword, this.page, this.size})
      : super._();
}

class OnDownloadExcel extends AcceptanceListEvent {
  final int documentId;

  const OnDownloadExcel(this.documentId) : super._();
}
