enum UserSortType {
  createdAtDesc('최신순', 'createdAt:desc'),
  totalAssetAmountDesc('자산순', 'totalAssetAmount:desc');

  const UserSortType(this.label, this.queryValue);

  final String label;
  final String queryValue;
}
