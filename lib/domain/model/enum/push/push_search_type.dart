enum PushSearchType {
  pushTitle('PUSH_TITLE', '제목'),
  pushContent('PUSH_CONTENT', '내용'),
  stockName('STOCK_NAME', '종목명'),
  userName('AUTHOR_NAME', '이름'),
  nickName('AUTHOR_NICKNAME', '닉네임'),
  stockGroupName('STOCK_GROUP_NAME', '종목그룹명');

  const PushSearchType(this.value, this.title);

  final String value;
  final String title;
}
