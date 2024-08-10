part of 'bloc.dart';

@immutable
abstract class CampaignDetailEvent {
  const CampaignDetailEvent._();

  const factory CampaignDetailEvent.onInit(int campaignId) = OnInit;

  const factory CampaignDetailEvent.onSetStock(CampaignPost stock) = OnSetStock;

  const factory CampaignDetailEvent.onSearchStock(String searchText) = OnSearchStock;

  const factory CampaignDetailEvent.onDeleteCampaign(int campaignId) = OnDeleteCampaign;

  const factory CampaignDetailEvent.onGetPost(int postId, String stockCode) = OnGetPost;
}

class OnInit extends CampaignDetailEvent {
  final int campaignId;

  const OnInit(this.campaignId) : super._();
}

class OnSetStock extends CampaignDetailEvent {
  final CampaignPost stock;

  const OnSetStock(this.stock) : super._();
}

class OnSearchStock extends CampaignDetailEvent {
  final String searchText;

  const OnSearchStock(this.searchText) : super._();
}

class OnGetPost extends CampaignDetailEvent {
  final int postId;
  final String stockCode;

  const OnGetPost(this.postId, this.stockCode) : super._();
}

class OnDeleteCampaign extends CampaignDetailEvent {
  final int campaignId;

  const OnDeleteCampaign(this.campaignId) : super._();
}
