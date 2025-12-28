import 'package:hive/hive.dart';
import '../../models/user_model.dart';

class HiveAuthDataSource {
  static const String _boxName = 'authBox';
  static const String _userKey = 'loggedUser';

  Future<void> saveUser(UserModel user) async {
    final box = Hive.box(_boxName);
    await box.put(_userKey, user.toJson());
  }

  UserModel? getUser() {
    final box = Hive.box(_boxName);
    final data = box.get(_userKey);
    if (data == null) return null;
    return UserModel.fromJson(Map<String, dynamic>.from(data));
  }

  Future<void> clearUser() async {
    final box = Hive.box(_boxName);
    await box.delete(_userKey);
  }
}
