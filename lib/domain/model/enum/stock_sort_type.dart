enum StockSortType {
  stakeDesc('지분순', 'stake:desc'),
  memberCountDesc('인원순', 'memberCount:desc'),
  marketValueDesc('자산순', 'marketValue:desc');

  const StockSortType(this.label, this.queryValue);

  final String label;
  final String queryValue;
}
