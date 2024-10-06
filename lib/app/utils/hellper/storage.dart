import 'package:thismed/app/data/events/event_pref.dart';
import 'package:thismed/app/data/models/user_model.dart';

class Storages {
  static final Map<String, dynamic>? _userData = EventPref.readUser();
  static final String getUserId = _userData!["id"];
  static final String? getUserToken = _userData?["token"];

  static final deleteUserData = EventPref.deleteUser();
  static saveUserData(UserModel user) {
    return EventPref.writeUser(user);
  }
}
