import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  late TextEditingController postC;

  @override
  void onInit() {
    postC = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    postC.dispose();
    super.dispose();
  }
}
