import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  late final _secureStorage = const FlutterSecureStorage();
  late final _userKey = 'user';

  /// delete from keystore/keychain
  Future<void> deleteUser() async {
    await _secureStorage.delete(key: _userKey);
  }

  /// write to keystore/keychain
  Future<void> saveUser(String user) async {
    _secureStorage.write(key: _userKey, value: user);
  }

  /// read to keystore/keychain
  Future<String> getUser() async {
    final token = await _secureStorage.read(key: _userKey) ?? '';
    return token;
  }
}
