import 'package:flutter/foundation.dart';

class Credentials {
  final String brandName;
  final String? userName;
  final String email;
  final String password;
  final String? icon;
  Credentials({
    required this.brandName,
    this.userName,
    required this.email,
    required this.password,
    this.icon,
  });
}
