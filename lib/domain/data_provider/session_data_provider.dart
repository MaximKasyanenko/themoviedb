import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _DomainKey {
  static const sessionIdKey = 'sessionId';
}

class SessionDataProvider {
  static const _secureStorage = FlutterSecureStorage();

  Future<String?> getSessionId() async =>
      _secureStorage.read(key: _DomainKey.sessionIdKey);

  Future<void> setSessionId(String? sessionId) {
    if (sessionId != null) {
      return _secureStorage.write(
          key: _DomainKey.sessionIdKey, value: sessionId);
    } else {
      return _secureStorage.delete(key: _DomainKey.sessionIdKey);
    }
  }
}
