import 'package:hive/hive.dart';

part 'credentials.g.dart';

@HiveType(typeId: 1)
class Credentials extends HiveObject {
  Credentials(
    this.brand,
    this.userNameOrEmail,
    this.password, {
    this.id,
    this.icon,
    this.synced = false,
  });
  @HiveField(0)
  final String brand;

  @HiveField(1)
  final String userNameOrEmail;

  //I removed email field with index 2

  @HiveField(3)
  final String password;
  @HiveField(4)
  String? icon;
  //I removed final keyword from icon

  @HiveField(6, defaultValue: false)
  bool synced;

  @HiveField(7)
  String? id;
}
