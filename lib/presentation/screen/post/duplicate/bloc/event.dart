part of 'bloc.dart';

@immutable
abstract class PostEvent {
  const PostEvent._();

  const factory PostEvent.init() = PostOnInit;

  const factory PostEvent.postOnSetSourceSearchType(BoardSearchType searchType) = PostOnSetSourceSearchType;

  const factory PostEvent.postOnSetSourceSearchKeyword(String searchKeyword) = PostOnSetSourceSearchKeyword;

  const factory PostEvent.setSourceStock(SimpleStock stock) = PostOnSetSourceStock;

  const factory PostEvent.setTargetStock(SimpleStock stock) = PostOnSetTargetStock;

  const factory PostEvent.setTargetStockGroup(SimpleStockGroup stockGroup) = PostOnSetTargetStockGroup;

  const factory PostEvent.postOnSelectPost(Post post) = PostOnSelectPost;

  const factory PostEvent.postOnSetStockGroup(StockGroup stockGroup) = PostOnSetStockGroup;

  const factory PostEvent.postOnSetTargetSearchType(BoardTargetSearchType searchType) = PostOnSetTargetSearchType;

  const factory PostEvent.postOnSetTargetSearchKeyword(String searchKeyword) = PostOnSetTargetSearchKeyword;

  const factory PostEvent.fetchPost({
    String? searchKeyword,
    int page,
    int size,
    String? sorts,
  }) = PostOnFetchPost;

  const factory PostEvent.fetchPostLoadMore({
    String? searchKeyword,
    int page,
    int size,
    String? sorts,
  }) = PostOnLoadMore;

  const factory PostEvent.duplicatePostToStock() = PostOnDuplicatePostToStock;

  const factory PostEvent.duplicatePostToGroup() = PostOnDuplicatePostToGroup;
}

class PostOnInit extends PostEvent {
  const PostOnInit() : super._();
}

class PostOnDuplicatePostToStock extends PostEvent {
  const PostOnDuplicatePostToStock() : super._();
}

class PostOnDuplicatePostToGroup extends PostEvent {
  const PostOnDuplicatePostToGroup() : super._();
}

class PostOnSelectPost extends PostEvent {
  final Post post;

  const PostOnSelectPost(this.post) : super._();
}

class PostOnPostList extends PostEvent {
  final List<Post> postList;

  const PostOnPostList(this.postList) : super._();
}

class PostOnSetSourceSearchKeyword extends PostEvent {
  final String searchKeyword;

  const PostOnSetSourceSearchKeyword(this.searchKeyword) : super._();
}

class PostOnSetSourceStock extends PostEvent {
  final SimpleStock stock;

  const PostOnSetSourceStock(this.stock) : super._();
}

class PostOnSetTargetStock extends PostEvent {
  final SimpleStock stock;

  const PostOnSetTargetStock(this.stock) : super._();
}

class PostOnSetTargetStockGroup extends PostEvent {
  final SimpleStockGroup stockGroup;

  const PostOnSetTargetStockGroup(this.stockGroup) : super._();
}

class PostOnSetTargetSearchKeyword extends PostEvent {
  final String searchKeyword;

  const PostOnSetTargetSearchKeyword(this.searchKeyword) : super._();
}

class PostOnSetStockGroup extends PostEvent {
  final StockGroup stockGroup;

  const PostOnSetStockGroup(this.stockGroup) : super._();
}

class PostOnSetSourceSearchType extends PostEvent {
  final BoardSearchType searchType;

  const PostOnSetSourceSearchType(this.searchType) : super._();
}

class PostOnSetTargetSearchType extends PostEvent {
  final BoardTargetSearchType searchType;

  const PostOnSetTargetSearchType(this.searchType) : super._();
}

class PostOnFetchPost extends PostEvent {
  final String? searchKeyword;
  final int page;
  final int size;
  final String? sorts;

  const PostOnFetchPost({
    this.searchKeyword,
    this.page = 1,
    this.size = apiLoadSize,
    this.sorts,
  }) : super._();
}

class PostOnLoadMore extends PostEvent {
  final String? searchKeyword;
  final int page;
  final int size;
  final String? sorts;

  const PostOnLoadMore({
    this.searchKeyword,
    this.page = 1,
    this.size = apiLoadSize,
    this.sorts,
  }) : super._();
}

class PostOnDuplicate extends PostEvent {
  const PostOnDuplicate() : super._();
}
