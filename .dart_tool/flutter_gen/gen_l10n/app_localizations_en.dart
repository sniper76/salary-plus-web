import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Hello, World!';

  @override
  String get change_language => 'Change Language';

  @override
  String get write_post => 'Write Post';

  @override
  String get login => 'Login';

  @override
  String get form_id => 'ID';

  @override
  String get form_id_hintText => 'Please enter ID';

  @override
  String get form_pwd => 'Password';

  @override
  String get form_pwd_hintText => 'Please enter Password';

  @override
  String get logout => 'Logout';

  @override
  String get stock => 'Stock';

  @override
  String get info_service => 'Service Info';
}
