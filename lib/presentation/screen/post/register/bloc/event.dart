part of 'bloc.dart';

@immutable
abstract class PostEvent {
  const PostEvent._();

  const factory PostEvent.init() = OnInit;

  const factory PostEvent.changedCategory(BoardGroupCategory? category) = OnChangedCategory;

  const factory PostEvent.uploadImage(File file) = OnUploadImage;

  const factory PostEvent.deleteUploadImage() = OnDeleteUploadImage;

  const factory PostEvent.searchStock({required String stockSearchKeyword, bool isStockGroup}) = OnSearchStock;

  const factory PostEvent.setTitle(String title) = OnSetTitle;

  const factory PostEvent.setCampaignTitle(String title) = OnSetCampaignTitle;

  const factory PostEvent.selectStock(SimpleStock stock) = OnSelectStock;

  const factory PostEvent.selectStockGroup(SimpleStockGroup stock) = OnSelectStockGroup;

  const factory PostEvent.setIsActive(bool isActive) = OnSetIsActive;

  const factory PostEvent.setIsExclusiveToUsers(bool isExclusiveToHolders) = OnSetIsExclusiveToUsers;

  const factory PostEvent.setIsNotification(bool isNotification) = OnSetIsNotification;

  const factory PostEvent.save({
    required String title,
    required String content,
    required bool isNotification,
    required bool isActive,
    List<Poll>? polls,
    DigitalProxyResult? digitalProxy,
  }) = OnSavePost;

  const factory PostEvent.updateCampaign({
    required String title,
    required String content,
    required bool isNotification,
    required bool isActive,
    List<Poll>? polls,
    DigitalProxyResult? digitalProxy,
  }) = OnUpdateCampaign;

  const factory PostEvent.setTargetDate(DateTime date) = OnUpdateTargetDate;
}

class OnInit extends PostEvent {
  const OnInit() : super._();
}

class OnSelectStock extends PostEvent {
  final SimpleStock stock;

  const OnSelectStock(this.stock) : super._();
}

class OnSelectStockGroup extends PostEvent {
  final SimpleStockGroup stockGroup;

  const OnSelectStockGroup(this.stockGroup) : super._();
}

class OnChangedCategory extends PostEvent {
  final BoardGroupCategory? boardGroupCategory;

  const OnChangedCategory(this.boardGroupCategory) : super._();
}

class OnUploadImage extends PostEvent {
  final File file;

  const OnUploadImage(this.file) : super._();
}

class OnDeleteUploadImage extends PostEvent {
  const OnDeleteUploadImage() : super._();
}

class OnSearchStock extends PostEvent {
  final String stockSearchKeyword;
  final bool isStockGroup;

  const OnSearchStock({required this.stockSearchKeyword, this.isStockGroup = false}) : super._();
}

class OnSetTitle extends PostEvent {
  final String title;

  const OnSetTitle(this.title) : super._();
}

class OnSetCampaignTitle extends PostEvent {
  final String campaignTitle;

  const OnSetCampaignTitle(this.campaignTitle) : super._();
}

class OnSetIsActive extends PostEvent {
  final bool isActive;

  const OnSetIsActive(this.isActive) : super._();
}

class OnSetIsExclusiveToUsers extends PostEvent {
  final bool isExclusiveToHolders;

  const OnSetIsExclusiveToUsers(this.isExclusiveToHolders) : super._();
}

class OnSetIsNotification extends PostEvent {
  final bool isNotification;

  const OnSetIsNotification(this.isNotification) : super._();
}

class OnSavePost extends PostEvent {
  final String title;
  final String content;
  final bool isNotification;
  final bool isActive;
  final List<Poll>? polls;
  final DigitalProxyResult? digitalProxy;

  const OnSavePost({
    required this.title,
    required this.content,
    required this.isNotification,
    required this.isActive,
    this.polls,
    this.digitalProxy,
  }) : super._();
}

class OnUpdateCampaign extends PostEvent {
  final String title;
  final String content;
  final bool isNotification;
  final bool isActive;
  final List<Poll>? polls;
  final DigitalProxyResult? digitalProxy;

  const OnUpdateCampaign({
    required this.title,
    required this.content,
    required this.isNotification,
    required this.isActive,
    this.polls,
    this.digitalProxy,
  }) : super._();
}

class OnUpdateTargetDate extends PostEvent {
  final DateTime date;

  const OnUpdateTargetDate(this.date) : super._();
}
