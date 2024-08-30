import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thismed/app/data/models/user_model.dart';
import 'package:thismed/app/data/services/services.dart';
import 'package:thismed/app/routes/app_pages.dart';

class LoginController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passwordC;
  late GlobalKey<FormState> key;
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
    key = GlobalKey<FormState>();
    emailC = TextEditingController();
    passwordC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailC.clear();
    emailC.dispose();
    passwordC.clear();
    passwordC.dispose();
    super.onClose();
  }

  Future<void> login() async {
    try {
      final data =
          UserModel(id: '', email: emailC.text, password: passwordC.text);
      final response = await AppServices.loginService(data);
      userData.value = response;
      Get.offNamed(Routes.SETUP);
    } catch (e) {
      throw Exception("errr");
    }
  }
}
