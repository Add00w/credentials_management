import 'package:credentials_management/src/common/storage.dart';

class SecureStorageRepostitory {
  /// delete from keystore/keychain
  Future<void> deleteToken() async {
    Storage().token = '';
    await Storage().secureStorage.delete(key: 'access_token');
  }

  /// write to keystore/keychain
  Future<void> saveToken(String token) async {
    Storage().token = token;
    await Storage().secureStorage.write(key: 'access_token', value: token);
  }

  /// read to keystore/keychain
  Future<String> getToken() async {
    final token = await Storage().secureStorage.read(key: 'access_token') ?? '';
    Storage().token = token;
    return token;
  }
}
