import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:thismed/app/data/events/event_pref.dart';
import 'package:thismed/app/data/models/user_model.dart';

class Storages {
  static final Map<String, dynamic>? _userData = EventPref.readUser();
  static final String getUserId = _userData!["id"];
  static final String? getUserToken = _userData?["token"];

  static Future<void> deleteUserData() async {
    await EventPref.deleteUser();
  }

  static saveUserData(UserModel user) {
    return EventPref.writeUser(user);
  }
}

class Envs {
  static final String storageBucket = dotenv.get('STORAGEBUCKET');
  static final String projectId = dotenv.get('PROJECTID');
  static final String messagingSenderId = dotenv.get('MESSAGINGSENDERID');
  static final String appId = dotenv.get('APPID');
  static final String apiKey = dotenv.get('APIKEY');
}
