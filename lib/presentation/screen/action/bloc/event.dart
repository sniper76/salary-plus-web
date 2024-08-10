part of 'bloc.dart';

@immutable
abstract class ActionEvent {
  const ActionEvent._();

  const factory ActionEvent.init() = ActionOnInit;

  const factory ActionEvent.postOnPostList(List<Post> postList) = ActionOnPostList;

  const factory ActionEvent.postOnSetSearchKeyword(String searchKeyword) = ActionOnSetSearchKeyword;

  const factory ActionEvent.postOnSetBoardCategory(BoardGroupCategory boardCategory) = ActionOnSetBoardCategory;

  const factory ActionEvent.postOnSetSearchType(BoardSearchType searchType) = ActionOnSetSearchType;

  const factory ActionEvent.postOnSetPostStatusType(PostStatusType postStatusType) = ActionOnSetPostStatusType;

  const factory ActionEvent.fetchPostLoadMore({
    String? searchKeyword,
    int page,
    int size,
    String? sorts,
  }) = ActionOnLoadMore;

  const factory ActionEvent.setSelectedSimpleStock(SimpleStock simpleStock) = ActionOnSetSelectedSimpleStock;

  const factory ActionEvent.updatePost(int postId, String stockCode) = ActionOnUpdatedPost;

  const factory ActionEvent.pageRefresh() = ActionOnPageRefresh;

  const factory ActionEvent.downloadExcel(int documentId) = ActionOnExcelDownload;

  const factory ActionEvent.requestZipFile(Post post, bool isSecured) = ActionOnZipFileRequest;

  const factory ActionEvent.getZipFileStatus() = ActionOnGetZipFileStatus;

  const factory ActionEvent.removeZipFileStatus() = ActionOnRemoveZipFileStatus;

  const factory ActionEvent.testText(String testText) = ActionOnTestText;

  const factory ActionEvent.setSeletedPost(Post post) = ActionOnSetSelectedPost;

  const factory ActionEvent.getPosts(
      {BoardGroupType? boardGroup,
      BoardGroupCategory? boardCategory,
      BoardSearchType? searchType,
      String? searchKeyword,
      PostStatusType? status,
      int? page,
      int? size,
      BoardSortType? sort}) = ActionOnGetPosts;

  const factory ActionEvent.setIsSuccessChangeReferenceDay(bool isSuccessChangeReferenceDay) =
      ActionOnSuccessChagnedReferenceDay;

  const factory ActionEvent.updateReferenceDay(
          int stockReferenceDateId, String stockCode, DateTime referenceDate, int digitalDocumentId) =
      ActionOnUpdateReferenceDay;
}

class ActionOnInit extends ActionEvent {
  const ActionOnInit() : super._();
}

class ActionOnPostList extends ActionEvent {
  final List<Post> postList;

  const ActionOnPostList(this.postList) : super._();
}

class ActionOnSetSearchKeyword extends ActionEvent {
  final String searchKeyword;

  const ActionOnSetSearchKeyword(this.searchKeyword) : super._();
}

class ActionOnSetSearchType extends ActionEvent {
  final BoardSearchType searchType;

  const ActionOnSetSearchType(this.searchType) : super._();
}

class ActionOnSetPostStatusType extends ActionEvent {
  final PostStatusType postStatusType;

  const ActionOnSetPostStatusType(this.postStatusType) : super._();
}

class ActionOnSetBoardCategory extends ActionEvent {
  final BoardGroupCategory boardCategory;

  const ActionOnSetBoardCategory(this.boardCategory) : super._();
}

class ActionOnLoadMore extends ActionEvent {
  final String? searchKeyword;
  final int page;
  final int size;
  final String? sorts;

  const ActionOnLoadMore({
    this.searchKeyword,
    this.page = 1,
    this.size = apiLoadSize,
    this.sorts,
  }) : super._();
}

class ActionOnSetSelectedSimpleStock extends ActionEvent {
  final SimpleStock simpleStock;

  const ActionOnSetSelectedSimpleStock(this.simpleStock) : super._();
}

class ActionOnUpdatedPost extends ActionEvent {
  final int postId;
  final String stockCode;

  const ActionOnUpdatedPost(this.postId, this.stockCode) : super._();
}

class ActionOnPageRefresh extends ActionEvent {
  const ActionOnPageRefresh() : super._();
}

class ActionOnExcelDownload extends ActionEvent {
  final int documentId;

  const ActionOnExcelDownload(this.documentId) : super._();
}

class ActionOnZipFileRequest extends ActionEvent {
  final Post post;
  final bool isSecured;

  const ActionOnZipFileRequest(this.post, this.isSecured) : super._();
}

class ActionOnGetZipFileStatus extends ActionEvent {
  const ActionOnGetZipFileStatus() : super._();
}

class ActionOnRemoveZipFileStatus extends ActionEvent {
  const ActionOnRemoveZipFileStatus() : super._();
}

class ActionOnTestText extends ActionEvent {
  final String testText;

  const ActionOnTestText(this.testText) : super._();
}

class ActionOnSetSelectedPost extends ActionEvent {
  final Post post;

  const ActionOnSetSelectedPost(this.post) : super._();
}

class ActionOnGetPosts extends ActionEvent {
  final BoardGroupType? boardGroup;
  final BoardGroupCategory? boardCategory;
  final BoardSearchType? searchType;
  final String? searchKeyword;
  final PostStatusType? status;
  final int? page;
  final int? size;
  final BoardSortType? sort;

  const ActionOnGetPosts({
    this.boardGroup,
    this.boardCategory,
    this.searchType,
    this.searchKeyword,
    this.status,
    this.page,
    this.size,
    this.sort,
  }) : super._();
}

class ActionOnSuccessChagnedReferenceDay extends ActionEvent {
  final bool isSuccessChangeReferenceDay;

  const ActionOnSuccessChagnedReferenceDay(this.isSuccessChangeReferenceDay) : super._();
}

class ActionOnUpdateReferenceDay extends ActionEvent {
  final int stockReferenceDateId;
  final String stockCode;
  final DateTime referenceDate;
  final int digitalDocumentId;

  const ActionOnUpdateReferenceDay(
      this.stockReferenceDateId, this.stockCode, this.referenceDate, this.digitalDocumentId)
      : super._();
}
