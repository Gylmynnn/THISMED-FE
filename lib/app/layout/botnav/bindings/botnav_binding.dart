import 'package:get/get.dart';
import 'package:thismed/app/layout/botnav/controllers/botnav_controller.dart';
import 'package:thismed/app/modules/home/controllers/home_controller.dart';
import 'package:thismed/app/modules/profile/controllers/profile_controller.dart';
import 'package:thismed/app/modules/search/controllers/search_controller.dart';

class BotnavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BotnavController>(() => BotnavController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<SearchController>(() => SearchController());
  }
}
