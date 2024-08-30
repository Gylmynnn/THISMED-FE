import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thismed/app/utils/themes/controllers/theme_controller.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  await GetStorage.init();
  Get.lazyPut<ThemeController>(() => ThemeController());
  runApp(const Thismed());
}

class Thismed extends GetView<ThemeController> {
  const Thismed({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: controller.getLightTheme(),
          darkTheme: controller.getDarkTheme(),
          themeMode: _theTheme(),
          title: "Application",
          initialRoute: Routes.LOGIN,
          getPages: AppPages.routes,
        ));
  }

  ThemeMode _theTheme() {
    return controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
  }
}
