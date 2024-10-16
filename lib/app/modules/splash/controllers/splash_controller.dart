import 'package:get/get.dart';
import 'package:thismed/app/routes/app_pages.dart';
import 'package:thismed/app/utils/hellper/storage.dart';

class SplashController extends GetxController {

  @override
    void onInit() {
      loadings();
      super.onInit();
    }

  Future<void> loadings() async {
    await Future.delayed(
        const Duration(seconds: 2), () => Get.offAllNamed(_credentials()));
  }

  String _credentials() {
    if (Storages.getUserToken != null) {
      return Routes.HOME;
    } else {
      return Routes.LOGIN;
    }
  }
}
