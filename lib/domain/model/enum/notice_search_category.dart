enum NoticeSearchCategory {
  titleAndContent('TITLECONTENT', '제목+내용'),
  subject('TITLE', '제목'),
  content('CONTENT', '내용');

  const NoticeSearchCategory(this.value, this.title);

  final String value;
  final String title;
}
