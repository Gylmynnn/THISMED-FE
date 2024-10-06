import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thismed/app/data/events/event_pref.dart';
import 'package:thismed/app/data/models/user_model.dart';
import 'package:thismed/app/data/services/auth_service.dart';
import 'package:thismed/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final AuthService http = AuthService();
  late TextEditingController emailC;
  late TextEditingController passwordC;
  // final GlobalKey<FormState> key = GlobalKey<FormState>();
  final RxBool passwordSecure = true.obs;

  Rx<UserModel> userData = UserModel(
          id: '',
          email: '',
          password: '',
          token: '',
          createdAt: '',
          updatedAt: '')
      .obs;

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
      await http.loginService(data);
      // print(EventPref.readUser()!.id);
      // userData.value = response;
      Get.offNamed(Routes.HOME);
    } catch (e) {
      throw Exception(e);
    }
  }
}
