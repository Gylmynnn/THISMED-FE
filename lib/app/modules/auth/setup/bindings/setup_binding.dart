import 'package:get/get.dart';

import '../controllers/setup_controller.dart';

class SetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetupController>(
      () => SetupController(),
    );
  }
}
