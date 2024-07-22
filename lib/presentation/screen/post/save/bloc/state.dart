part of 'bloc.dart';

@freezed
class PostSaveState with _$PostSaveState, BaseStateMixin {
  const factory PostSaveState({
    @Default(false) bool isLoading,
    String? errorToastMessage,
    String? notiToastMessage,
    String? stockCode,
    @Default('') String stockSearchKeyword,
    @Default([]) List<(BoardGroupType, BoardGroupCategory)> boardGroupOptionList,
    (BoardGroupType, BoardGroupCategory)? selectedboardGroupOption,
    @Default([]) List<UploadImageFile> uploadImageFiles,
    Post? updatedPost,
    @Default(false) bool isAnonymous,
    @Default([]) List<PollRegisterResult> pollRegisterResultList,
    @Default(false) bool isExclusiveToHolders,
    @Default(null) String? tempSavedPostContent,
    @Default(null) DateTime? tempSavedDateTime,
  }) = _PostSaveState;

  factory PostSaveState.initial() => const PostSaveState(
        isLoading: false,
        errorToastMessage: null,
        uploadImageFiles: [],
        updatedPost: null,
        pollRegisterResultList: [],
        isExclusiveToHolders: false,
      );
}

extension PostSaveStateExtesion on PostSaveState {
  PostSaveState copyWithNull({
    bool? isLoading,
    String? stockCode,
    String? stockSearchKeyword,
    List<(BoardGroupType, BoardGroupCategory)>? boardGroupOptionList,
    (BoardGroupType, BoardGroupCategory)? selectedboardGroupOption,
    List<UploadImageFile>? uploadImageFiles,
    Post? updatedPost,
    bool? isAnonymous,
    List<PollRegisterResult>? pollRegisterResultList,
    bool? isExclusiveToHolders,
    String? tempSavedPostContent,
    DateTime? tempSavedDateTime,
    String? errorToastMessage,
    String? notiToastMessage,
  }) {
    return PostSaveState(
      isLoading: isLoading ?? this.isLoading,
      stockCode: stockCode ?? this.stockCode,
      stockSearchKeyword: stockSearchKeyword ?? this.stockSearchKeyword,
      boardGroupOptionList: boardGroupOptionList ?? this.boardGroupOptionList,
      selectedboardGroupOption: selectedboardGroupOption ?? this.selectedboardGroupOption,
      uploadImageFiles: uploadImageFiles ?? this.uploadImageFiles,
      updatedPost: updatedPost,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      pollRegisterResultList: pollRegisterResultList ?? this.pollRegisterResultList,
      isExclusiveToHolders: isExclusiveToHolders ?? this.isExclusiveToHolders,
      tempSavedPostContent: tempSavedPostContent,
      tempSavedDateTime: tempSavedDateTime ?? this.tempSavedDateTime,
      errorToastMessage: errorToastMessage,
      notiToastMessage: notiToastMessage,
    );
  }
}
