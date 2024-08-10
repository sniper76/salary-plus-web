part of 'bloc.dart';

@immutable
abstract class CampaignListEvent {
  const CampaignListEvent._();

  const factory CampaignListEvent.onInit() = OnInit;

  const factory CampaignListEvent.onPageRefresh() = OnPageRefresh;

  const factory CampaignListEvent.onSetSearchType(CampaignSearchType searchType) = OnSetSearchType;

  const factory CampaignListEvent.onSetBoardCategory(BoardGroupCategory boardCategory) = OnSetBoardCategory;

  const factory CampaignListEvent.onLoadMore({String? searchKeyword, int? page, int? size, String? sorts}) = OnLoadMore;

  const factory CampaignListEvent.onDownloadCSV(int campaignId) = OnDownloadCSV;

  const factory CampaignListEvent.onRequestZipFile(int campaignId, bool isSecured) = OnRequestZipFile;

  const factory CampaignListEvent.onGetCampaignDetail(int campaignId) = OnGetCampaignDetail;
}

class OnInit extends CampaignListEvent {
  const OnInit() : super._();
}

class OnPageRefresh extends CampaignListEvent {
  const OnPageRefresh() : super._();
}

class OnSetSearchType extends CampaignListEvent {
  final CampaignSearchType searchType;

  const OnSetSearchType(this.searchType) : super._();
}

class OnSetBoardCategory extends CampaignListEvent {
  final BoardGroupCategory boardCategory;

  const OnSetBoardCategory(this.boardCategory) : super._();
}

class OnDownloadCSV extends CampaignListEvent {
  final int campaignId;

  const OnDownloadCSV(this.campaignId) : super._();
}

class OnGetCampaignDetail extends CampaignListEvent {
  final int campaignId;

  const OnGetCampaignDetail(this.campaignId) : super._();
}

class OnRequestZipFile extends CampaignListEvent {
  final int campaignId;
  final bool isSecured;

  const OnRequestZipFile(this.campaignId, this.isSecured) : super._();
}

class OnLoadMore extends CampaignListEvent {
  final String? searchKeyword;
  final int? page;
  final int? size;
  final String? sorts;

  const OnLoadMore({
    this.searchKeyword,
    this.page,
    this.size,
    this.sorts,
  }) : super._();
}
