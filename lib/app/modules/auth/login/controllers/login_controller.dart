import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thismed/app/data/models/user_model.dart';
import 'package:thismed/app/data/services/auth_service.dart';
import 'package:thismed/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final AuthService _http = AuthService();
  late TextEditingController emailC;
  late TextEditingController passwordC;
  final RxBool passwordSecure = true.obs;
  final Rxn<UserModel> _userData = Rxn<UserModel>();

  @override
  void onInit() {
    emailC = TextEditingController();
    passwordC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }

  set setUserData(UserModel response) => _userData.value = response;
  UserModel? get getUserData => _userData.value;

  Future<void> login() async {
    try {
      final data =
          UserModel(id: '', email: emailC.text, password: passwordC.text);
      final UserModel response = await _http.loginService(data);
      setUserData = response;
      Get.offNamed(Routes.HOME);
    } catch (e) {
      throw Exception(e);
    }
  }
}
