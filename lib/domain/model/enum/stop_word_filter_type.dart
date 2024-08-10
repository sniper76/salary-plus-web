enum StopWordFilterType {
  all('전체', 'createdAt:ASC'),
  active('활성', 'word:ASC'),
  inactive('비활성', 'word:ASC');

  const StopWordFilterType(this.label, this.queryValue);

  final String label;
  final String queryValue;
}
