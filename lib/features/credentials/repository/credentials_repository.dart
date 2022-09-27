import 'dart:async';
import 'dart:convert' show base64UrlEncode, base64Url;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../common/services/connectivity_service.dart';
import '../../../common/services/secure_storage_service.dart';
import '../model/credentials.dart';

class CredentialsRepository {
  static late Box<Credentials> encryptedCredentialsBox;
  static late final _credentialsFirestore =
      FirebaseFirestore.instance.collection('credentials');
  CredentialsRepository(
    this._secureStorage,
  ) {
    if (!Hive.isBoxOpen('credentials')) {
      _openBox();
    }
  }
  final SecureStorageService _secureStorage;
  Future<int> add(Credentials credential) async {
    final icon = await _getBestFavicon(credential.brand);
    credential.icon = icon;
    if (await ConnectivityService.isConnected()) {
      final credentialSync = <String, String>{
        'brand': credential.brand,
        'icon': credential.icon!,
        'password': credential.password,
        'username_or_email': credential.userNameOrEmail,
      };
      try {
        _credentialsFirestore.add(credentialSync).then(
          (doc) {
            // Set synced
            credential.synced = true;
          },
        );
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    }
    return encryptedCredentialsBox.add(credential);
  }

  Future<void> edit(Credentials credential, int index) async {
    return encryptedCredentialsBox.putAt(index, credential);
  }

  Future<void> delete(int index) async {
    return encryptedCredentialsBox.deleteAt(index);
  }

  Future<List<Credentials>> getCredentials() async {
    if (encryptedCredentialsBox.values.isEmpty) {
      // If local storage is empty
      // Try to get the credentials from firestore
      // and store to local
      await _credentialsFirestore.get().then(
        (event) async {
          for (final doc in event.docs) {
            debugPrint("${doc.id} => ${doc.data()}");
            final credential = Credentials(
              doc.data()['brand'] as String,
              doc.data()['username_or_email'] as String,
              doc.data()['password'] as String,
              icon: doc.data()['icon'] as String,
              synced: true,
            );
            await encryptedCredentialsBox.add(credential);
          }
        },
      );
    }
    return encryptedCredentialsBox.values.toList();
  }

  static Future<void> syncTheData(ConnectivityResult? status) async {
    if (await ConnectivityService.isConnected(connectivityResult: status)) {
      //check if everything is in sync
      if (_notSynced()) {
        for (final credential in encryptedCredentialsBox.values) {
          if (!credential.synced) {
            final credentialSync = <String, String>{
              'brand': credential.brand,
              'icon': credential.icon!,
              'password': credential.password,
              'username_or_email': credential.userNameOrEmail,
            };
            _credentialsFirestore.add(credentialSync).then(
              (doc) async {
                // Set synced
                credential.synced = true;
                await credential.save();
              },
            );
          }
        }
      }
    }
  }

  static bool _notSynced() {
    return encryptedCredentialsBox.values.any((element) => !element.synced);
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
        //initiate connectivity service
        ConnectivityService();
        // Check everything in sync.
        syncTheData(null);
      },
    );
  }

  Future<List<int>> _getEncryptionKey() async {
    final encryptionKey = await _secureStorage.getFromKey('encryptionKey');
    if (encryptionKey == null) {
      final encryptionKey = Hive.generateSecureKey();
      await _secureStorage.saveToKey(
        'encryptionKey',
        base64UrlEncode(encryptionKey),
      );
      return encryptionKey;
    }
    return base64Url.decode(encryptionKey);
  }
}
