import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thismed/app/utils/hellper/storage.dart';
import 'package:thismed/app/utils/themes/controllers/theme_controller.dart';
import 'package:thismed/firebase_options.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();
  Get.lazyPut<ThemeController>(() => ThemeController());
  runApp(const Thismed());
}

class Thismed extends GetView<ThemeController> {
  const Thismed({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          defaultTransition: Transition.rightToLeftWithFade,
          debugShowCheckedModeBanner: false,
          theme: controller.getLightTheme(),
          darkTheme: controller.getDarkTheme(),
          themeMode: _theTheme(),
          title: "Thismed",
          initialRoute: _credentials(),
          getPages: AppPages.routes,
        ));
  }

  String _credentials() {
    if (Storages.getUserToken != null) {
      return Routes.HOME;
    } else {
      return Routes.LOGIN;
    }
  }

  ThemeMode _theTheme() {
    return controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
  }
}
