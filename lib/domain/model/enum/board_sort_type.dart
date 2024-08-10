enum BoardSortType { createdAt, viewCount, likeCount, createdAtAsc }

extension BoardSortTypeExtension on BoardSortType {
  String get value {
    switch (this) {
      case BoardSortType.createdAt:
        return 'createdAt';
      case BoardSortType.viewCount:
        return 'viewUserCount';
      case BoardSortType.likeCount:
        return 'likeCount';
      case BoardSortType.createdAtAsc:
        return 'createdAt';
    }
  }

  String get title {
    switch (this) {
      case BoardSortType.createdAt:
        return '최신순';
      case BoardSortType.viewCount:
        return '조회순';
      case BoardSortType.likeCount:
        return '좋아요순';
      case BoardSortType.createdAtAsc:
        return '작성순';
    }
  }
}
