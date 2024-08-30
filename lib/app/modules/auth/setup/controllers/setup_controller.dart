import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thismed/app/data/models/attribute_model.dart';
import 'package:thismed/app/data/services/services.dart';

class SetupController extends GetxController {
  late TextEditingController usernameC;
  late TextEditingController avatarC;
  late TextEditingController bioC;
  late GlobalKey<FormState> key;
  Rx<AttributeModel> attributeData = AttributeModel(
          id: 0, username: '', avatar: '', bio: '', badges: [], userId: '')
      .obs;

  @override
  void onInit() {
    key = GlobalKey<FormState>();
    usernameC = TextEditingController();
    avatarC = TextEditingController();
    bioC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    usernameC.clear();
    usernameC.dispose();
    avatarC.clear();
    avatarC.dispose();
    bioC.clear();
    bioC.dispose();
    super.onClose();
  }

  Future<void> setupAttribute() async {
    try {
      final data = AttributeModel(
          id: 0,
          username: usernameC.text,
          avatar: avatarC.text,
          bio: bioC.text);
      final response = await AppServices.attributeService(data);
      attributeData.value = response;
    } catch (e) {
      throw Exception("error : $e");
    }
  }
}
