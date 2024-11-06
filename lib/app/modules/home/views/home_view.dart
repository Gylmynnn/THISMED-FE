import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thismed/app/components/c_card.dart';
import 'package:thismed/app/data/models/post_model.dart';
import 'package:thismed/app/modules/home/controllers/home_controller.dart';
import 'package:thismed/app/routes/app_pages.dart';
import 'package:thismed/app/utils/hellper/storage.dart';
import 'package:thismed/app/utils/themes/controllers/theme_controller.dart';
import 'package:gap/gap.dart';
import 'package:thismed/app/utils/themes/views/theme_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final themeC = Get.find<ThemeController>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _buildAppBar(themeC, controller),
        body: _buildBody(controller),
      ),
    );
  }
}

Widget _buildBody(HomeController controller) {
  return Obx(() {
    final desc = controller.posts.reversed.toList();
    return TabBarView(children: [
      ListView.builder(
          itemCount: desc.length,
          itemBuilder: (context, index) {
            final PostModel item = desc[index];
            return CsCard(item: item);
          }),
      ListView.builder(
          itemCount: desc.length,
          itemBuilder: (context, index) {
            final PostModel item = desc[index];
            return CsCard(item: item);
          })
    ]);
  });
}


PreferredSizeWidget _buildAppBar(ThemeController themeC, HomeController home) {
  return AppBar(
    actions: <Widget>[
      IconButton(
          onPressed: () {
            Storages.deleteUserData();
            Get.offAllNamed(Routes.LOGIN);
          },
          icon: const Icon(Icons.exit_to_app)),
      IconButton(
        icon: Obx(() =>
            Icon(themeC.isDarkMode.value ? Icons.dark_mode : Icons.light_mode)),
        onPressed: () {
          themeC.toggleTheme();
        },
      ),
    ],
    title: const Text(
      'THISMED',
    ),
    bottom: TabBar(
      tabs: const <Widget>[
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.bell),
              Gap(12),
              Text('Terbaru'),
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.fire),
              Gap(12),
              Text('Following'),
            ],
          ),
        ),
      ],
      labelColor: primaryColor,
      indicatorColor: primaryColor,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 4,
    ),
  );
}
