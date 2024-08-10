enum ExposureStatus {
  all('ALL', '전체'),
  posting('POSTING', '게시'),
  reservation('RESERVATION', '예약'),
  hide('HIDE', '숨김');

  const ExposureStatus(this.value, this.title);
  final String value;
  final String title;
}
