import 'package:act_web/domain/model/user/token.dart';
import 'package:act_web/domain/model/user/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class UserAuthService extends ChangeNotifier {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final Uuid _uuid = const Uuid();

  static const String _accessTokenStorageKey = 'key_access_token';
  static const String _userUuidKey = 'user_uuid';

  String _accessToken = '';
  User? _user;
  String? _userUuid;
  bool? _needLoginPopup;

  String get accessToken => _accessToken;
  String get userUuid => _userUuid ?? '';
  User? get userMe => _user;
  bool? get needLoginPopup => _needLoginPopup;

  init() async {
    await _load();
  }

  bool hasAccessToken() {
    return _accessToken.isNotEmpty;
  }

  bool isAuthenticated() {
    return _accessToken.isNotEmpty && _user != null;
  }

  bool isUserStatusActivated() {
    return _user?.isActiveStatus ?? false;
  }

  void setNeedLoginFlag(bool flag) {
    _needLoginPopup = flag;
    notifyListeners();
  }

  Future<bool> login({
    required Token token,
    required User user,
  }) async {
    if (token.accessToken.isEmpty) return false;

    try {
      await _secureStorage.write(
        key: _accessTokenStorageKey,
        value: token.accessToken,
      );

      _accessToken = token.accessToken;

      updateUser(user);
      return true;
    } catch (e) {
      return false;
    }
  }

  updateUser(User user) {
    _user = user;
    notifyListeners();
  }

  Future<void> logout() async {
    await _secureStorage.delete(
      key: _accessTokenStorageKey,
    );

    _accessToken = '';
    _user = null;

    notifyListeners();
  }

  _load() async {
    try {
      _accessToken = (await _secureStorage.read(key: _accessTokenStorageKey)) ?? '';

      String? localSavedUserUuid = await _secureStorage.read(
        key: _userUuidKey,
      );
      if (localSavedUserUuid == null) {
        _userUuid = _uuid.v4();
        _secureStorage.write(key: _userUuidKey, value: _userUuid);
      } else {
        _userUuid = localSavedUserUuid;
      }
    } catch (e) {
      if (kDebugMode) {
        print('UserAuthService load error: $e');
      }
    }
  }
}
