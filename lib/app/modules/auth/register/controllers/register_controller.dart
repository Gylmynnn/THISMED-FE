import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:thismed/app/data/models/user_model.dart';
import 'package:thismed/app/data/services/auth_service.dart';
import 'package:thismed/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final AuthService _http = AuthService();
  late TextEditingController usernameC;
  late TextEditingController emailC;
  late TextEditingController passwordC;
  late TextEditingController confirmPasswordC;
  final RxBool passwordSecure = true.obs;
  final RxBool confirmPasswordSecure = true.obs;

  final Random _random = Random();
  final String _characters =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890|!@#\$%^&*()_+';
  final RxString _password = ''.obs;

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

  set setPassword(String value) => _password.value = value;


  void generatePassword() {
    final String result = setPassword = List.generate(
        12, (index) => _characters[_random.nextInt(_characters.length)]).join();
    passwordC.text = result;
  }

  Future<void> register() async {
    try {
      final data =
          UserModel(id: '', email: emailC.text, password: passwordC.text);
      if (passwordC.text != confirmPasswordC.text) {
        Get.snackbar("Info", "password not match");
      } else {
        await _http.registerService(data);
        Get.offNamed(Routes.LOGIN);
      }
    } catch (e) {
      throw Exception("errr");
    }
  }
}
