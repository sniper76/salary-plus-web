enum UserSearchCategory {
  name('NAME', '이름', '이름 검색(부분일치)'),
  nickname('NICKNAME', '닉네임', '닉네임 검색 (부분일치)'),
  phoneNumber('PHONE_NUMBER', '휴대폰번호', '휴대폰번호 검색(전체일치) ex)01012347777'),
  email('EMAIL', '이메일', '이메일 검색(부분일치)'),
  userId('USER_ID', '사용자 아이디(UID)', '사용자 아이디 검색(전체일치)');

  const UserSearchCategory(this.value, this.title, this.placeholder);

  final String value;
  final String title;
  final String placeholder;
}
