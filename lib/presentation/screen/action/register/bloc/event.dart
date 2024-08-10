part of 'bloc.dart';

@immutable
abstract class PostEvent {
  const PostEvent._();

  const factory PostEvent.init(ActionPostType postType) = PostSaveOnInit;

  const factory PostEvent.setTargetSearchType(BoardTargetSearchType? postSearchType) = PostSaveOnChangedPostSearchType;

  const factory PostEvent.uploadImage(File file) = PostSaveOnUploadImage;

  const factory PostEvent.deleteUploadImage() = PostSaveOnDeleteUploadImage;

  const factory PostEvent.searchStock(String keword) = PostSaveOnSearchStock;

  const factory PostEvent.searchStockGroup(String keword) = PostSaveOnSearchStockGroup;

  const factory PostEvent.setTitle(String title) = PostSaveOnSetTitle;

  const factory PostEvent.setCampaignTitle(String title) = PostSaveOnSetCampaignTitle;

  const factory PostEvent.setTargetStock(SimpleStock stock) = PostOnSelectStock;

  const factory PostEvent.setTargetStockGroup(SimpleStockGroup stockGroup) = PostOnSelectStockGroup;

  const factory PostEvent.setIsActive(bool isActive) = PostSaveOnSetIsActive;

  const factory PostEvent.setActionDocType(ActionDocumentType actionDocumentType) = PostSaveOnSetActionDocType;

  const factory PostEvent.addPoll() = PostOnAddPoll;

  const factory PostEvent.setDigitalDocumentCategory(DigitalDocumentType digitalDocumentCategory) =
      PostSaveOnSetDigitalDocumentCategory;

  const factory PostEvent.setIsNotification(bool isNotification) = PostSaveOnSetIsNotification;

  const factory PostEvent.setActionPreview(
      {required bool isPreviewOn,
      String? type,
      String? shareholderMeetingType,
      String? shareholderMeetingName,
      DateTime? shareholderMeetingDate,
      String? designatedAgentNames,
      String? companyRegistrationNumber,
      String? title,
      String? content,
      int? acceptUserId,
      List<DigitalDocumentItem>? digitalDocumentList,
      String? companyName}) = PostSaveOnSetActionPreview;

  const factory PostEvent.actionSave({
    required String title,
    required String content,
    required BoardGroupCategory boardGroupCategory,
    required bool isNotification,
    bool isAnonymous,
    List<Poll>? polls,
    DigitalProxyResult? digitalProxy,
    DigitalDocumentAdmin? digitalDocument,
  }) = PostActionOnSave;

  const factory PostEvent.campaignSave({
    required String title,
    required String content,
    required BoardGroupCategory boardGroupCategory,
    required bool isNotification,
    bool isAnonymous,
    List<Poll>? polls,
    DigitalProxyResult? digitalProxy,
    DigitalDocumentAdmin? digitalDocument,
  }) = PostCampaignOnSave;

  const factory PostEvent.createReferenceDates({
    required DateTime date,
  }) = PostOnCreateReferenceDay;

  const factory PostEvent.setReferenceDay({
    required StockReferenceDate day,
  }) = PostOnSetReferenceDay;

  const factory PostEvent.clearToastMsg() = ClearToastMsg;

  const factory PostEvent.onEditPoll({
    required int pollId,
    DateTime? startedAt,
    DateTime? endedAt,
    String? content,
    String? title,
    List<String>? items,
    PollSelectionType? selectionType,
    PollVoteType? voteType,
  }) = PostOnEditPoll;

  const factory PostEvent.onDeletePoll(int pollIndex) = PostOnDeletePoll;
}

class PostSaveOnInit extends PostEvent {
  final ActionPostType postType;

  const PostSaveOnInit(this.postType) : super._();
}

class PostOnSelectStock extends PostEvent {
  final SimpleStock stock;

  const PostOnSelectStock(this.stock) : super._();
}

class PostOnSelectStockGroup extends PostEvent {
  final SimpleStockGroup stockGroup;

  const PostOnSelectStockGroup(this.stockGroup) : super._();
}

class PostSaveOnChangedPostSearchType extends PostEvent {
  final BoardTargetSearchType? postSearchType;

  const PostSaveOnChangedPostSearchType(this.postSearchType) : super._();
}

class PostSaveOnUploadImage extends PostEvent {
  final File file;

  const PostSaveOnUploadImage(this.file) : super._();
}

class PostSaveOnDeleteUploadImage extends PostEvent {
  const PostSaveOnDeleteUploadImage() : super._();
}

class PostSaveOnSearchStock extends PostEvent {
  final String keyword;

  const PostSaveOnSearchStock(this.keyword) : super._();
}

class PostSaveOnSearchStockGroup extends PostEvent {
  final String keyword;

  const PostSaveOnSearchStockGroup(this.keyword) : super._();
}

class PostSaveOnSetTitle extends PostEvent {
  final String title;

  const PostSaveOnSetTitle(this.title) : super._();
}

class PostSaveOnSetCampaignTitle extends PostEvent {
  final String title;

  const PostSaveOnSetCampaignTitle(this.title) : super._();
}

class PostSaveOnSetIsActive extends PostEvent {
  final bool isActive;

  const PostSaveOnSetIsActive(this.isActive) : super._();
}

class PostActionOnSave extends PostEvent {
  final String title;
  final String content;
  final bool isAnonymous;
  final List<Poll>? polls;
  final BoardGroupCategory boardGroupCategory;
  final DigitalProxyResult? digitalProxy;
  final DigitalDocumentAdmin? digitalDocument;
  final bool isNotification;

  const PostActionOnSave({
    required this.title,
    required this.content,
    required this.boardGroupCategory,
    required this.isNotification,
    this.isAnonymous = false,
    this.polls,
    this.digitalProxy,
    this.digitalDocument,
  }) : super._();
}

class PostCampaignOnSave extends PostEvent {
  final String title;
  final String content;
  final bool isAnonymous;
  final List<Poll>? polls;
  final BoardGroupCategory boardGroupCategory;
  final DigitalProxyResult? digitalProxy;
  final DigitalDocumentAdmin? digitalDocument;
  final bool isNotification;

  const PostCampaignOnSave({
    required this.title,
    required this.content,
    required this.boardGroupCategory,
    required this.isNotification,
    this.isAnonymous = false,
    this.polls,
    this.digitalProxy,
    this.digitalDocument,
  }) : super._();
}

class PostSaveOnSetActionDocType extends PostEvent {
  final ActionDocumentType actionDocumentType;

  const PostSaveOnSetActionDocType(this.actionDocumentType) : super._();
}

class PostSaveOnSetDigitalDocumentCategory extends PostEvent {
  final DigitalDocumentType category;

  const PostSaveOnSetDigitalDocumentCategory(this.category) : super._();
}

class PostOnCreateReferenceDay extends PostEvent {
  final DateTime date;

  const PostOnCreateReferenceDay({required this.date}) : super._();
}

class PostOnSetReferenceDay extends PostEvent {
  final StockReferenceDate day;

  const PostOnSetReferenceDay({required this.day}) : super._();
}

class PostSaveOnSetActionPreview extends PostEvent {
  final bool isPreviewOn;
  final String? type;
  final String? shareholderMeetingType;
  final String? shareholderMeetingName;
  final DateTime? shareholderMeetingDate;
  final String? designatedAgentNames;
  final String? companyRegistrationNumber;
  final String? title;
  final String? content;
  final int? acceptUserId;
  final String? companyName;
  final List<DigitalDocumentItem>? digitalDocumentList;

  const PostSaveOnSetActionPreview(
      {required this.isPreviewOn,
      this.type,
      this.shareholderMeetingType,
      this.shareholderMeetingName,
      this.shareholderMeetingDate,
      this.designatedAgentNames,
      this.companyRegistrationNumber,
      this.title,
      this.content,
      this.acceptUserId,
      this.digitalDocumentList,
      this.companyName})
      : super._();
}

class PostSaveOnSetIsNotification extends PostEvent {
  final bool isNotification;

  const PostSaveOnSetIsNotification(this.isNotification) : super._();
}

class ClearToastMsg extends PostEvent {
  const ClearToastMsg() : super._();
}

class PostOnAddPoll extends PostEvent {
  const PostOnAddPoll() : super._();
}

class PostOnEditPoll extends PostEvent {
  final int pollId;
  final String? title;
  final String? content;
  final List<String>? items;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final PollSelectionType? selectionType;
  final PollVoteType? voteType;

  const PostOnEditPoll({
    required this.pollId,
    this.title,
    this.content,
    this.items,
    this.startedAt,
    this.endedAt,
    this.selectionType,
    this.voteType,
  }) : super._();
}

class PostOnDeletePoll extends PostEvent {
  final int pollIndex;

  const PostOnDeletePoll(this.pollIndex) : super._();
}
