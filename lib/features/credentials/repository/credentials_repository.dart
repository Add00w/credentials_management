import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/credentials.dart';

class CredentialsRepository {
  late Box credentialsBox;
  CredentialsRepository() {
    _openBox();
  }
  Future<int> add(Credentials credential) async {
    final credentials = Hive.box<Credentials>('credentials');
    final icon = await _getBestFavicon(credential.brandName);
    log('icon:$icon');
    credential.icon = icon;
    final index = await credentials.add(credential);
    return index;
  }

  Future<void> edit(Credentials credential, int index) async {
    final credentials = Hive.box<Credentials>('credentials');
    credentials.putAt(index, credential);
  }

  Future<void> delete(int index) async {
    await Hive.box<Credentials>('credentials').deleteAt(index);
  }

  Future<List<Credentials>> getCredentials() async {
    log('credentials');
    if (!Hive.isBoxOpen('credentials')) {
      await _openBox();
    }
    return Hive.box<Credentials>('credentials').values.toList();
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
    credentialsBox = await Hive.openBox<Credentials>('credentials');
  }
}
