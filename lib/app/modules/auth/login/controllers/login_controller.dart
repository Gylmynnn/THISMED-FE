import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thismed/app/data/models/user_model.dart';
import 'package:thismed/app/data/services/auth_service.dart';
import 'package:thismed/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final AuthService http = AuthService();
  late TextEditingController emailC;
  late TextEditingController passwordC;
  final RxBool passwordSecure = true.obs;
  final Rxn<UserModel> userData = Rxn<UserModel>();

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

  Future<void> login() async {
    try {
      final data =
          UserModel(id: '', email: emailC.text, password: passwordC.text);
      final UserModel response = await http.loginService(data);
      userData.value = response;
      print("User Id is ${userData.value!.id}");

      Get.offNamed(Routes.HOME);
    } catch (e) {
      throw Exception(e);
    }
  }
}
