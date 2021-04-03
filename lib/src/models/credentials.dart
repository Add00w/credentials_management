import 'package:hive/hive.dart';

part 'credentials.g.dart';

@HiveType(typeId: 1)
class Credentials extends HiveObject {
  Credentials(
    this.brandName,
    this.userName,
    this.email,
    this.password,
    this.icon,
  );
  @HiveField(0)
  final String brandName;

  @HiveField(1)
  final String? userName;

  @HiveField(2)
  final String email;
  @HiveField(3)
  final String password;
  @HiveField(4)
  String? icon;
  //I removed final keyword from icon
}
