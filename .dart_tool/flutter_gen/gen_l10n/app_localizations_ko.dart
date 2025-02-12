import 'app_localizations.dart';

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get title => '안녕하세요, 세상!';

  @override
  String get change_language => '언어 변경';

  @override
  String get write_post => '글쓰기';

  @override
  String get login => '로그인';

  @override
  String get form_id => '아이디';

  @override
  String get form_id_hintText => '아이디를 입력하세요';

  @override
  String get form_pwd => '비밀번호';

  @override
  String get form_pwd_hintText => '비밀번호를 입력하세요';

  @override
  String get logout => '로그아웃';

  @override
  String get stock => '종목';

  @override
  String get info_service => '서비스소개';
}
