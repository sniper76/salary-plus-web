part of 'community_bloc.dart';

@immutable
abstract class CommunityEvent {
  const CommunityEvent._();

  const factory CommunityEvent.init() = CommunityOnInit;

  const factory CommunityEvent.setSearchKeyword(String searchKeyword) = CommunityOnSetSearchKeyword;

  const factory CommunityEvent.setBoardCategory(BoardGroupCategory boardCategory) = CommunityOnSetBoardCategory;

  const factory CommunityEvent.setSearchType(BoardSearchType searchType) = CommunityOnSetSearchType;

  const factory CommunityEvent.setPostStatusType(PostStatusType postStatusType) = CommunityOnSetStatusType;

  const factory CommunityEvent.fetchCommunityPosts({
    String? searchKeyword,
    int page,
    int size,
    String? sorts,
  }) = CommunityFetchPost;

  const factory CommunityEvent.pageRefresh() = CommunityOnPageRefresh;
}

class CommunityOnInit extends CommunityEvent {
  const CommunityOnInit() : super._();
}

class CommunityOnSetSearchKeyword extends CommunityEvent {
  final String searchKeyword;

  const CommunityOnSetSearchKeyword(this.searchKeyword) : super._();
}

class CommunityOnSetSearchType extends CommunityEvent {
  final BoardSearchType searchType;

  const CommunityOnSetSearchType(this.searchType) : super._();
}

class CommunityOnSetStatusType extends CommunityEvent {
  final PostStatusType postStatusType;

  const CommunityOnSetStatusType(this.postStatusType) : super._();
}

class CommunityOnSetBoardCategory extends CommunityEvent {
  final BoardGroupCategory boardCategory;

  const CommunityOnSetBoardCategory(this.boardCategory) : super._();
}

class CommunityFetchPost extends CommunityEvent {
  final String? searchKeyword;
  final int page;
  final int size;
  final String? sorts;

  const CommunityFetchPost({
    this.searchKeyword,
    this.page = 1,
    this.size = apiLoadSize,
    this.sorts,
  }) : super._();
}

class CommunityOnPageRefresh extends CommunityEvent {
  const CommunityOnPageRefresh() : super._();
}
