import 'package:thismed/app/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:thismed/app/utils/hellper/storage.dart';

class AuthService extends GetConnect {
  Future<UserModel> loginService(UserModel user) async {
    try {
      final Response<dynamic> response = await post(
        'http://10.0.2.2:3000/api/login',
        {
          'email': user.email,
          'password': user.password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.body['data'];
        final UserModel responseData = UserModel.fromJson(data);
        await Storages.saveUserData(responseData);
        return responseData;
      } else {
        throw Exception("error");
      }
    } catch (e) {
      throw Exception("error : $e");
    }
  }

  Future<UserModel> registerService(UserModel user) async {
    try {
      final response = await post(
        'http://10.0.2.2:3000/api/register',
        {
          'email': user.email,
          'password': user.password,
        },
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = response.body['data'];
        final UserModel responseData = UserModel.fromJson(data);
        await Storages.saveUserData(responseData);
        return responseData;
      } else {
        throw Exception("error");
      }
    } catch (e) {
      throw Exception("error : $e");
    }
  }
}
