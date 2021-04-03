import 'dart:developer';

import 'package:credentials_management/src/models/credentials.dart';
import 'package:hive/hive.dart';

class CredentialsRepository {
  Future<int> add(Credentials credential) async {
    final credentials = Hive.box<Credentials>('credentials');
    final index = await credentials.add(credential);
    log(index.toString());
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
}
