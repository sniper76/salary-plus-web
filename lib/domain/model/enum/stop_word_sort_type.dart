enum StopWordSortType {
  createdAtDesc('최신순', 'createdAt:DESC'),
  alphabeticalDesc('ABC가나다순', 'word:ASC');

  const StopWordSortType(this.label, this.queryValue);

  final String label;
  final String queryValue;
}
