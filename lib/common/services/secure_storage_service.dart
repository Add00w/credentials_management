import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  late final _secureStorage = const FlutterSecureStorage();

  /// delete from keystore/keychain
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'access_token');
  }

  /// write to keystore/keychain
  Future<void> saveToken(String token) async {
    _secureStorage.write(key: 'access_token', value: token);
  }

  /// read to keystore/keychain
  Future<String> getToken() async {
    final token = await _secureStorage.read(key: 'access_token') ?? '';
    return token;
  }
}
