import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thismed/app/data/models/user_model.dart';
import 'package:thismed/app/data/services/auth_service.dart';
import 'package:thismed/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final AuthService http = AuthService();
  late TextEditingController usernameC;
  late TextEditingController emailC;
  late TextEditingController passwordC;
  late TextEditingController confirmPasswordC;
  final RxBool passwordSecure = true.obs;
  final RxBool confirmPasswordSecure = true.obs;
  // final GlobalKey<FormState> key = GlobalKey<FormState>();
  final Random random = Random();
  final String characters =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890|!@#\$%^&*()_+';
  final RxString password = ''.obs;

  @override
  void onInit() {
    usernameC = TextEditingController();
    emailC = TextEditingController();
    passwordC = TextEditingController();
    confirmPasswordC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    usernameC.dispose();
    emailC.dispose();
    passwordC.dispose();
    confirmPasswordC.dispose();
    super.onClose();
  }

  void generatePassword() {
    final String result = password.value = List.generate(
        12, (index) => characters[random.nextInt(characters.length)]).join();
    passwordC.text = result;
  }

  Future<void> register() async {
    try {
      final data =
          UserModel(id: '', email: emailC.text, password: passwordC.text);
      if (passwordC.text != confirmPasswordC.text) {
        Get.snackbar("Info", "password not match");
      } else {
        await http.registerService(data);
        Get.offNamed(Routes.LOGIN);
      }
    } catch (e) {
      throw Exception("errr");
    }
  }
}
