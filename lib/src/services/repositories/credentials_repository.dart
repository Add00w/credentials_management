import 'dart:convert';
import 'dart:developer';

import 'package:credentials_management/src/models/credentials.dart';
import 'package:credentials_management/src/models/favicon.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class CredentialsRepository {
  late Box credentialsBox;
  CredentialsRepository() {
    Hive.openBox<Credentials>('credentials').then((box) {
      credentialsBox = box;
      debugPrint(credentialsBox.name);
    });
  }
  Future<int> add(Credentials credential) async {
    final credentials = Hive.box<Credentials>('credentials');
    final icon = await getBestFavicon(credential.brandName);
    log('icon:$icon');
    credential.icon = icon;
    final index = await credentials.add(credential);
    log('current added index:$index');
    return index;
  }

  Future<void> edit(Credentials credential, int index) async {
    final credentials = Hive.box<Credentials>('credentials');
    credentials.putAt(index, credential);
  }

  Future<void> delete(int index) async {
    await Hive.box<Credentials>('credentials').deleteAt(index);
  }

  Future<Iterable<Credentials>> getCredentials() async {
    return Hive.box<Credentials>('credentials').values;
  }

  Future<String> getBestFavicon(String url) async {
    try {
      final response = await http.get(
        Uri.tryParse('https://i.olsh.me/allicons.json?'
            'url=$url&formats=png,ico,gif')!,
      );

      if (response.statusCode != 200) {
        return '';
      }

      final bestIcon = FaviconResponse.fromJson(json.decode(
        response.body,
      ) as Map<String, dynamic>);

      return bestIcon.url;
    } catch (e) {
      debugPrint(e.toString());

      return '';
    }
  }
}
