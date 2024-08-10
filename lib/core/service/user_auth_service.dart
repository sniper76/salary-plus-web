import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/domain/model/token.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserAuthService extends ChangeNotifier {
  static const _accessTokenStorageKey = 'key_access_token';
  static const _lastPinNumberVerifiedAtStorageKey = 'key_last_pin_number_verified_at';
  static const _lastMyDataUpdatedAtStorageKey = 'key_last_my_data_updated_at_at';

  final _iOSSecureStorageOptions = const IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );
  final _androidSecureStorageOptions = const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  final _secureStorage = const FlutterSecureStorage(
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  String _accessToken = '';

  User? _user;
  DateTime? _lastPinNumberVerifiedAt;
  DateTime? _lastMyDataUpdatedAt;

  String get accessToken => _accessToken;

  User? get userMe => _user;

  init() async {
    await _load();
  }

  bool hasAccessToken() {
    return _accessToken.isNotEmpty;
  }

  bool isAuthenticated() {
    return _accessToken.isNotEmpty && _user != null && !(_user?.isChangePasswordRequired ?? false);
  }

  bool isUserStatusActivated() {
    return _user?.isActiveStatus ?? false;
  }

  bool isPinNumberRegistered() {
    return _user?.isPinNumberRegistered ?? false;
  }

  bool isPinNumberVerification() {
    final userLastPinNumberVerifiedDuration = DateTime.now().getDurationDays(date: _user?.lastPinNumberVerifiedAt);

    final lastPinNumberVerifiedDuration =
        _lastPinNumberVerifiedAt != null ? DateTime.now().getDurationDays(date: _lastPinNumberVerifiedAt) : -1;
    return (userLastPinNumberVerifiedDuration >= 0 && userLastPinNumberVerifiedDuration <= 1) &&
        (lastPinNumberVerifiedDuration >= 0 && lastPinNumberVerifiedDuration <= 1);
  }

  bool isTodayMyDataUpdated() {
    try {
      final lastMyDataUpdatedDate = DateTime.parse(_lastMyDataUpdatedAt?.toFormatString() ?? '');
      final toDate = DateTime.parse(DateTime.now().toFormatString());
      final lastMyDataUpdatedDuration = toDate.getDurationDays(date: lastMyDataUpdatedDate);
      return lastMyDataUpdatedDuration == 0;
    } catch (e) {
      return false;
    }
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
        aOptions: _androidSecureStorageOptions,
        iOptions: _iOSSecureStorageOptions,
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

  verifiedPinNumber(User user) async {
    _user = user;
    await _secureStorage.write(
      key: _lastPinNumberVerifiedAtStorageKey,
      value: DateTime.now().toIso8601String(),
      aOptions: _androidSecureStorageOptions,
      iOptions: _iOSSecureStorageOptions,
    );
    _lastPinNumberVerifiedAt = DateTime.now();

    // _registerPushTopics();

    notifyListeners();
  }

  updatedMyData() async {
    await _secureStorage.write(
      key: _lastMyDataUpdatedAtStorageKey,
      value: DateTime.now().toIso8601String(),
      aOptions: _androidSecureStorageOptions,
      iOptions: _iOSSecureStorageOptions,
    );
    _lastMyDataUpdatedAt = DateTime.now();
  }

  clearLastPinNumberVerifiedAt() {
    _lastPinNumberVerifiedAt = null;
    notifyListeners();
  }

  Future<void> logout() async {
    await _secureStorage.delete(
      key: _accessTokenStorageKey,
      iOptions: _iOSSecureStorageOptions,
      aOptions: _androidSecureStorageOptions,
    );

    await _secureStorage.delete(
      key: _lastPinNumberVerifiedAtStorageKey,
      iOptions: _iOSSecureStorageOptions,
      aOptions: _androidSecureStorageOptions,
    );

    await _secureStorage.delete(
      key: _lastMyDataUpdatedAtStorageKey,
      iOptions: _iOSSecureStorageOptions,
      aOptions: _androidSecureStorageOptions,
    );

    // _unregisterPushTopics();

    _accessToken = '';
    _user = null;
    _lastPinNumberVerifiedAt = null;
    _lastMyDataUpdatedAt = null;
    notifyListeners();
  }

  _load() async {
    try {
      _accessToken = (await _secureStorage.read(
            key: _accessTokenStorageKey,
            iOptions: _iOSSecureStorageOptions,
            aOptions: _androidSecureStorageOptions,
          )) ??
          '';

      final lastMyDataUpdatedAt = await _secureStorage.read(
        key: _lastMyDataUpdatedAtStorageKey,
        iOptions: _iOSSecureStorageOptions,
        aOptions: _androidSecureStorageOptions,
      );
      if (lastMyDataUpdatedAt != null && lastMyDataUpdatedAt.isNotEmpty) {
        _lastMyDataUpdatedAt = DateTime.parse(lastMyDataUpdatedAt);
      }
    } catch (e) {}
  }
}
