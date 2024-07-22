enum RankingSortType {
  stakeAsc('지분율순', 'stake:asc', '지분율', '평가금액'),
  marketValueAsc('평가금액순', 'marketValueRank:asc', '평가금액', '지분율');

  const RankingSortType(
    this.label,
    this.queryValue,
    this.mainString,
    this.subString,
  );

  final String label;
  final String queryValue;
  final String mainString;
  final String subString;
}
