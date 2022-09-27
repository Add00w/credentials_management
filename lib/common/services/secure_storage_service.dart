import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  late final _secureStorage = const FlutterSecureStorage();

  /// delete from keystore/keychain
  Future<void> deleteKey(String key) async {
    return _secureStorage.delete(key: key);
  }

  /// write to keystore/keychain
  Future<void> saveToKey(String key, String value) async {
    return _secureStorage.write(key: key, value: value);
  }

  /// read to keystore/keychain
  Future<String?> getFromKey(String key) async {
    return _secureStorage.read(key: key);
  }
}
