import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thismed/app/modules/home/controllers/home_controller.dart';
import 'package:thismed/app/utils/themes/controllers/theme_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final themeC = Get.find<ThemeController>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('NAVBAR'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Obx(() => Icon(themeC.isDarkMode.value
                  ? Icons.dark_mode
                  : Icons.light_mode)),
              onPressed: () {
                themeC.toggleTheme();
              },
            ),
          ],
        ),
        body: Column(
          children: [Text("hallo world")],
        ));
  }
}
