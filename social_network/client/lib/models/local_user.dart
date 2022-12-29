import 'package:hive/hive.dart';

part 'local_user.g.dart';

@HiveType(typeId: 1)
class User {
  User({required this.token});
  @HiveField(0)
  String token;
}
