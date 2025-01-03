import 'package:get/get.dart';
import 'package:thismed/app/layout/botnav/controllers/botnav_controller.dart';
import 'package:thismed/app/modules/home/controllers/home_controller.dart';
import 'package:thismed/app/modules/post/controllers/post_controller.dart';
import 'package:thismed/app/modules/profile/controllers/profile_controller.dart';
import 'package:thismed/app/modules/search/controllers/search_controller.dart';
import 'package:thismed/app/utils/themes/controllers/theme_controller.dart';

class BotnavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<BotnavController>(() => BotnavController());
    Get.lazyPut<PostController>(() => PostController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<SearchControllerG>(() => SearchControllerG());
  }
}
