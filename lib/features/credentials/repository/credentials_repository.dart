import 'dart:async';
import 'dart:convert';
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import '../model/credentials.dart';

class CredentialsRepository {
  late Box<Credentials> encryptedCredentialsBox;
  CredentialsRepository() {
    if (!Hive.isBoxOpen('credentials')) {
      _openBox();
    }
  }
  Future<int> add(Credentials credential) async {
    final icon = await _getBestFavicon(credential.brand);
    log('icon:$icon');
    credential.icon = icon;
    return encryptedCredentialsBox.add(credential);
  }

  Future<void> edit(Credentials credential, int index) async {
    return encryptedCredentialsBox.putAt(index, credential);
  }

  Future<void> delete(int index) async {
    return encryptedCredentialsBox.deleteAt(index);
  }

  Future<List<Credentials>> getCredentials() async {
    return encryptedCredentialsBox.values.toList();
  }

  Future<String> _getBestFavicon(String domain) async {
    try {
      final favIcon =
          'https://t1.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=http://$domain.com&size=16';
      return favIcon;
    } catch (e) {
      debugPrint(e.toString());

      return '';
    }
  }

  Future<void> _openBox() async {
    final encryptionKey = await _getEncryptionKey();
    Hive.openBox<Credentials>(
      'credentials',
      encryptionCipher: HiveAesCipher(encryptionKey),
    ).then(
      (box) {
        encryptedCredentialsBox = box;
        log('data:${encryptedCredentialsBox.get(0)}');
      },
    );
  }

  Future<List<int>> _getEncryptionKey() async {
    const secureStorage = FlutterSecureStorage();
    final encryptionKey = await secureStorage.read(key: 'encryptionKey');
    if (encryptionKey == null) {
      final encryptionKey = Hive.generateSecureKey();
      await secureStorage.write(
        key: 'encryptionKey',
        value: base64UrlEncode(encryptionKey),
      );
      return encryptionKey;
    }
    return base64Url.decode(encryptionKey);
  }
}
