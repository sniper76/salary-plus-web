part of 'bloc.dart';

@freezed
class PostSaveEvent with _$PostSaveEvent {
  factory PostSaveEvent.init() = _OnInit;

  factory PostSaveEvent.disableSavedContentDialog() = _OnDisableSavedContentDialog;

  factory PostSaveEvent.tempSavePostContent(String content) = _OnTempSavePostContent;

  factory PostSaveEvent.changeStock(String? stockCode) = _OnChangeStock;

  factory PostSaveEvent.searchStock(String? stockCode) = _OnSearchStock;

  factory PostSaveEvent.changeOption((BoardGroupType, BoardGroupCategory)? option) = _OnChangeCategory;

  factory PostSaveEvent.uploadImage(List<int> file) = _OnUploadImage;

  factory PostSaveEvent.deleteUploadImage() = _OnDeleteUploadImage;

  factory PostSaveEvent.toggleAnonymous() = _OnToggleAnonymous;

  factory PostSaveEvent.toggleIsExclusiveToHolders() = _OnToggleIsExclusiveToHolders;

  factory PostSaveEvent.createPoll(PollRegisterResult pollRegisterResult) = _OnCreatePoll;

  factory PostSaveEvent.updatePoll(PollRegisterResult pollRegisterResult) = _OnUpdatePoll;

  factory PostSaveEvent.deletePoll(int index) = _OnDeletePoll;

  factory PostSaveEvent.save({
    required String title,
    required String content,
    required bool isAnonymous,
    List<Poll>? polls,
  }) = _OnSave;
}
