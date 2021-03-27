import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 1)
class Person {
  @HiveField(0)
  final String brandName;

  @HiveField(1)
  final String? userName;

  @HiveField(2)
  final String email;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final String? icon;
}

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
