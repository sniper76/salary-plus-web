enum PeriodCheckStatus {
  all('ALL', '전체'),
  selected('SELECTED', '기간선택');

  const PeriodCheckStatus(this.value, this.title);
  final String value;
  final String title;
}
