import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thismed/app/data/models/attribute_model.dart';
import 'package:thismed/app/utils/hellper/asset.dart';

class SetupController extends GetxController {
  late TextEditingController usernameC;
  late TextEditingController avatarC;
  late TextEditingController bioC;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  Rx<AttributeModel> attributeData = AttributeModel(
          id: 0, username: '', avatar: '', bio: '', badges: [], userId: '')
      .obs;

  @override
  void onInit() {
    // key = GlobalKey<FormState>();
    usernameC = TextEditingController();
    avatarC = TextEditingController();
    bioC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    usernameC.dispose();
    avatarC.dispose();
    bioC.dispose();
    super.onClose();
  }

  Future<void> uploadImage() async {}

  void clearImage() {
    image = null;
    update();
  }

  Future<void> pickImage() async {
    try {
      image = await _picker.pickImage(source: ImageSource.gallery);
      update();
      if (image != null) {
        Get.log(image!.path);
      }
    } catch (e) {
      image = null;
      update();
    }
  }

  Future<void> setupAttribute() async {
    try {
      final data = AttributeModel(
          id: 0,
          username: usernameC.text,
          avatar: avatarC.text,
          bio: bioC.text);
      // final response = await AppServices.attributeService(data);
      // attributeData.value = response;
    } catch (e) {
      throw Exception("error : $e");
    }
  }
}
