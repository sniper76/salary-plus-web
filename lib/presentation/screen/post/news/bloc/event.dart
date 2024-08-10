part of 'bloc.dart';

@immutable
abstract class PostEvent {
  const PostEvent._();

  const factory PostEvent.init() = PostOnInit;

  const factory PostEvent.postOnPostList(List<Post> postList) = PostOnPostList;

  const factory PostEvent.postOnSetSearchKeyword(String searchKeyword) = PostOnSetSearchKeyword;

  const factory PostEvent.postOnSetBoardCategory(BoardGroupCategory boardCategory) = PostOnSetBoardCategory;

  const factory PostEvent.postOnSetSearchType(BoardSearchType searchType) = PostOnSetSearchType;

  const factory PostEvent.postOnSetPostStatusType(PostStatusType postStatusType) = PostOnSetPostStatusType;

  const factory PostEvent.fetchPost({String? searchKeyword, int? page, int? size}) = PostOnFetchPost;

  const factory PostEvent.pageRefresh() = PostOnPageRefresh;
}

class PostOnInit extends PostEvent {
  const PostOnInit() : super._();
}

class PostOnPostList extends PostEvent {
  final List<Post> postList;

  const PostOnPostList(this.postList) : super._();
}

class PostOnSetSearchKeyword extends PostEvent {
  final String searchKeyword;

  const PostOnSetSearchKeyword(this.searchKeyword) : super._();
}

class PostOnSetSearchType extends PostEvent {
  final BoardSearchType searchType;

  const PostOnSetSearchType(this.searchType) : super._();
}

class PostOnSetPostStatusType extends PostEvent {
  final PostStatusType postStatusType;

  const PostOnSetPostStatusType(this.postStatusType) : super._();
}

class PostOnSetBoardCategory extends PostEvent {
  final BoardGroupCategory boardCategory;

  const PostOnSetBoardCategory(this.boardCategory) : super._();
}

class PostOnFetchPost extends PostEvent {
  final String? searchKeyword;
  final int? page;
  final int? size;

  const PostOnFetchPost({
    this.searchKeyword,
    this.page,
    this.size,
  }) : super._();
}

class PostOnPageRefresh extends PostEvent {
  const PostOnPageRefresh() : super._();
}
