import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';

class EventPref {
  static const _userKey = 'user';
  static final GetStorage _refrenceBox = GetStorage();

  static dynamic writeThemeBox(String key, dynamic value) {
    final dynamic data = _refrenceBox.write(key, value);
    return data;
  }

  static dynamic readThemeBox(String key, {dynamic defaultValue}) {
    final dynamic data = _refrenceBox.read(key) ?? defaultValue;
    return data;
  }

  static Future<void> writeUser(UserModel user) async {
    await _refrenceBox.write(_userKey, user.toJson());
  }

  // Fungsi untuk membaca data user
  static Map<String, dynamic>? readUser() {
    final userData = _refrenceBox.read<Map<String, dynamic>>(_userKey);
    if (userData != null) {
      return userData;
    }
    return null;
  }

  // Fungsi untuk menghapus data user
  static Future<void> deleteUser() async {
    await _refrenceBox.remove(_userKey);
  }
}
